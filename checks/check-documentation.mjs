import fs from "node:fs";
import path from "node:path";
import process from "node:process";

const root = path.resolve(process.argv[2] ?? process.cwd());
const failures = [];

function collectFiles(directory, predicate) {
  return fs.readdirSync(directory, {withFileTypes: true}).flatMap((entry) => {
    if (entry.name === ".git") return [];

    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) return collectFiles(entryPath, predicate);
    return predicate(entryPath) ? [entryPath] : [];
  });
}

function relative(file) {
  return path.relative(root, file);
}

const markdownFiles = collectFiles(root, (file) => file.endsWith(".md"));

for (const file of markdownFiles) {
  const contents = fs.readFileSync(file, "utf8");
  const links = contents.matchAll(/\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)/g);

  for (const [, rawTarget] of links) {
    if (/^(?:https?:|mailto:|#)/.test(rawTarget)) continue;

    const target = decodeURIComponent(rawTarget.split("#", 1)[0]);
    if (!target) continue;

    const resolved = path.resolve(path.dirname(file), target);
    if (!fs.existsSync(resolved)) {
      failures.push(`${relative(file)}: broken local link to ${rawTarget}`);
    }
  }
}

const skillFiles = markdownFiles.filter(
  (file) =>
    path.basename(file) === "SKILL.md" &&
    relative(file).startsWith(`static${path.sep}ai${path.sep}skills${path.sep}`),
);
const skillNames = new Map();

for (const file of skillFiles) {
  const contents = fs.readFileSync(file, "utf8");
  const frontmatter = contents.match(/^---\n([\s\S]*?)\n---(?:\n|$)/);

  if (!frontmatter) {
    failures.push(`${relative(file)}: missing YAML frontmatter`);
    continue;
  }

  const name = frontmatter[1].match(/^name:\s*["']?([^\n"']+)["']?\s*$/m)?.[1].trim();
  const description = frontmatter[1].match(/^description:\s*.+$/m);

  if (!name) failures.push(`${relative(file)}: missing frontmatter name`);
  if (!description) failures.push(`${relative(file)}: missing frontmatter description`);

  if (name) {
    const previous = skillNames.get(name);
    if (previous) {
      failures.push(`${relative(file)}: duplicate skill name ${name}; first declared in ${previous}`);
    } else {
      skillNames.set(name, relative(file));
    }
  }
}

if (failures.length > 0) {
  console.error(failures.join("\n"));
  process.exit(1);
}

console.log(
  `Checked ${markdownFiles.length} Markdown files and ${skillFiles.length} skill definitions.`,
);
