# svg-viewer

Open an SVG in your preferred browser and refresh it automatically while you edit it.

```sh
svg-viewer path/to/file.svg
```

The command creates a small `index.html` under `${XDG_CACHE_HOME:-$HOME/.cache}/svg-viewer`,
opens the page with `xdg-open`, `open`, or `$BROWSER`, and renders the SVG inline
so browser find tooling can search text elements. It refreshes every second by
default while preserving the SVG's explicit `width` and `height`. A small background
updater rewrites the cached HTML from the source SVG so browser refreshes pick up
file changes. Transparent SVG regions show on a black page canvas.

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
