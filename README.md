# gotmpl.nvim

Editing Go template files (.tmpl) in Neovim lacks accurate syntax highlighting, making the code
harder to read and maintain.

This plugin adds treesitter support to separate go template syntax from the host language syntax.

## Installation

```lua
-- lazy.nvim --
{
  "ngynkvn/gotmpl.nvim"
  opts = {}
}
```
