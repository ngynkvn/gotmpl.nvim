# gotmpl.nvim

Editing Go template files (.tmpl) in Neovim lacks accurate syntax highlighting, making the code
harder to read and maintain.

This plugin adds treesitter support to separate go template syntax from the host language syntax. It
is very simple for now, it checks the file name ends with a format like `.$FT.tmpl`, then sets it as
[`@injection.language = $FT`][1] for treesitter.

## Installation

```lua
-- lazy.nvim --
{
  "ngynkvn/gotmpl.nvim"
  opts = {}
}
```

# References

[1]: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#injections
