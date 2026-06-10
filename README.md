# svg-viewer

Open an SVG in your preferred browser and refresh it automatically while you edit it.

```sh
svg-viewer path/to/file.svg
```

The command starts a tiny local server, opens the page with `$BROWSER`, `xdg-open`,
or `open`, and renders the SVG inline so browser find tooling can search text
elements. The page checks for SVG changes every second by default and replaces the
inline SVG only when the file content changes, so there is no timer-based page
reload flicker. Transparent SVG regions show on a black page canvas.

Use a different refresh interval with:

```sh
svg-viewer --interval 0.5 path/to/file.svg
```

## Nix

Run directly:

```sh
nix run . -- path/to/file.svg
```

Build the package:

```sh
nix build
```

Enter the development shell:

```sh
nix develop
```

`shell.nix` is included for workflows that still call `nix-shell`, and `.envrc`
loads the flake through direnv.

## License

AGPL-3.0-only. See [LICENSE](./LICENSE).
