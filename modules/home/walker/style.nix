''
  @define-color base #1f1f28;
  @define-color base #1f1f28;
  @define-color background #1f1f28;
  @define-color text #f2ecbc;
  @define-color border #54546d;
  @define-color selected-text #f2ecbc;

  * {
    all: unset;
  }

  * {
    font-family: monospace;
    font-size: 18px;
    color: @text;
  }

  scrollbar {
    opacity: 0;
  }

  .normal-icons {
    -gtk-icon-size: 16px;
  }

  .large-icons {
    -gtk-icon-size: 32px;
  }

  window,
  .window {
    background-color: transparent;
    background: transparent;
  }

  .box-wrapper {
    background: alpha(@background, 0.9);
    padding: 20px;
    border: 2px solid @border;
    border-radius: 14px;
    overflow: hidden;
  }

  .search-container {
    background: transparent;
    padding: 10px;
  }

  .input placeholder {
    opacity: 0.5;
  }

  .input:focus,
  .input:active {
    box-shadow: none;
    outline: none;
  }


  child:selected .item-box {
    background: alpha(@border, 0.35);
  }

  child:selected .item-box * {
    color: @selected-text;
  }

  .item-box {
    margin-top: 6px;
    padding-left: 14px;
  }

  .item-text-box {
    all: unset;
    padding: 0;
  }

  .item-subtext {
    font-size: 0px;
    min-height: 0px;
    margin: 0px;
    padding: 0px;
  }

  .item-image {
    margin-right: 14px;
    -gtk-icon-transform: scale(0.9);
  }

  .current {
    font-style: italic;
  }

  .keybind-hints {
    background: @background;
    padding: 10px;
    margin-top: 10px;
  }

  .keybinds,
  .keybinds * {
    height: 0;
    min-height: 0;
    padding: 0;
    margin: 0;
    margin-top: 0;
    opacity: 0;
    border: none;
    font-size: 0;
  }

  .keybind,
  .keybind-button,
  .keybind-label,
  .keybind-bind,
  .item-keybinds,
  .global-keybinds,
  .item-quick-activation {
    display: none;
    height: 0;
    min-height: 0;
    padding: 0;
    margin: 0;
    opacity: 0;
  }

  .placeholder {
    min-height: 0;
    min-width: 0;
    max-height: 0;
    max-width: 0;
    padding: 0;
    margin: 0;
    font-size: 0;
    line-height: 0;
    opacity: 0;
    border: 0;
    background: transparent;
    color: transparent;
  }
''
