# gotmpl.nvim

Editing Go template files (.tmpl) in Neovim often lacks accurate syntax highlighting, making code
hard to read and maintain. This plugin adds Tree-sitter support to separate go template syntax from
the host language syntax.

## Installation

```lua
-- lazy.nvim --
{
  "ngynkvn/gotmpl.nvim"
  opts = {}
}
```
