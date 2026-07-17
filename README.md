>[!NOTE]
> This is intended to be kept as a proof of concept, please adapt the example to your specific situation 

# gotmpl.nvim

Editing Go template files (.tmpl) in Neovim lacks accurate syntax highlighting, making the code
harder to read and maintain.

This plugin adds treesitter support to separate go template syntax from the host language syntax. It
is very simple for now, it checks the file name ends with a format like `.$FT.tmpl`, then sets it as
[`@injection.language = $FT`][1] for treesitter.

## Requirements

- Neovim >= 0.10
- The `gotmpl` parser installed via `nvim-treesitter` (`:TSInstall gotmpl`), plus a parser for
  whatever host language you're injecting (`:TSInstall yaml html json ...`)

## Installation

```lua
-- lazy.nvim --
{ "ngynkvn/gotmpl.nvim", opts = {}}
```

## Usage

Once installed, Treesitter will automatically highlight Go template files. Simply open a .tmpl file,
and you should see improved syntax highlighting. If your file type isn’t detected correctly, you can
manually set it:

```vim
:set filetype=gotmpl
```

## Contributing

There's a small smoke test covering the extension/filetype detection logic in `tests/smoke.lua` —
run it with `nvim --headless -u NONE -l tests/smoke.lua` after making changes to `lua/gotmpl/init.lua`.

### References

- [Injections for nvim-treesitter][1]

[1]:
  https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#injections
  "Injections"
