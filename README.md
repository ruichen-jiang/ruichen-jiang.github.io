# Personal website maintenance

This site is written in [jemdoc](https://jemdoc.jaboc.net/) and committed with its generated HTML. Edit the `.jemdoc` source files and regenerate the HTML; do not edit generated `.html` files directly because the next build will overwrite those changes.

## Requirements

- `jemdoc` available on your `PATH`
- `make`

Check the installation with:

```sh
command -v jemdoc
jemdoc --version
```

## Important files

- `index.jemdoc`: homepage content and selected works
- `publications.jemdoc`: complete publication list
- `MENU`: shared navigation
- `jemdoc.css`: desktop, mobile, typography, and accessibility styling
- `site.conf`: shared HTML metadata, viewport settings, and favicon link
- `favicon.svg`: browser favicon
- `photos/`: profile and other image assets
- `Makefile`: HTML build commands

The generated pages are `index.html` and `publications.html`.

## Editing and rebuilding

1. Edit the relevant `.jemdoc`, `MENU`, CSS, or configuration file.
2. From the repository directory, regenerate all published pages:

   ```sh
   make
   ```

3. Review the generated changes:

   ```sh
   git diff -- index.html publications.html
   ```

4. Open both pages locally and check them at desktop and mobile widths before publishing.

To regenerate only one page, run:

```sh
make index.html
make publications.html
```

To force regeneration even when `make` considers the files current, run:

```sh
make -B
```

The equivalent manual command must include the shared configuration:

```sh
jemdoc -c site.conf index.jemdoc
```

## Updating publications

- Keep the homepage limited to selected work in `index.jemdoc`.
- Add the full citation to the appropriate section of `publications.jemdoc`.
- Keep entries in reverse chronological order.
- Do not put blank lines between adjacent `-` entries in the same section. This lets jemdoc generate one coherent HTML list, which is better for spacing and screen readers.
- Run `make` after every update.

Example:

```text
- [https://arxiv.org/abs/0000.00000 Paper Title] \n
*Ruichen Jiang* and Coauthor \n
Conference 2026
```

## Updating navigation or adding a page

Edit `MENU` to change the shared navigation. For an internal content link that should remain in the same browser tab, prefix the URL with `/` in jemdoc markup:

```text
[/publications.html View all publications]
```

When adding a new generated page:

1. Create `page-name.jemdoc` with a menu directive and browser title.
2. Add its navigation entry to `MENU` if it should be visible.
3. Add `page-name.html` to `PAGES` in the `Makefile`.
4. Run `make`.

Example page header:

```text
# jemdoc: menu{MENU}{page-name.html}, title{Page Name — Ruichen Jiang}
= Page Name
```

## Metadata and styling

Update `site.conf` when the site description, theme color, or favicon changes. Update `jemdoc.css` for visual changes. The responsive breakpoint is currently `700px`, and the main content width is limited to `960px`.

Keep `.jemdoc` files encoded as UTF-8 with LF line endings. Mixed CRLF/LF line endings can interfere with title detection in the legacy jemdoc parser.

## Legacy warnings

The installed jemdoc version may print Python `SyntaxWarning` messages about invalid escape sequences. These come from the legacy generator and are harmless when the command exits successfully and produces the expected HTML files.
