# Customizing the UI

Everything visual lives in `html/main.css`. The file is layered: a minified base
sheet on line 1, then a series of override blocks. Later blocks win, so make
your edits at the bottom rather than trying to unpick the minified line.

## Moving the artwork

Three pieces of art frame the menu: `zhead.png` (left), `zbody.png` (right) and
`zskelly.png` (bottom right). All three are positioned through CSS variables in
the `:root` block, so you can move and resize them without touching any rules:

```css
:root {
    --rs-menu-player-height: min(990px, 88vh);

    --rs-zhead-left: -275px;
    --rs-zhead-top: -42px;
    --rs-zhead-width: 410px;
    --rs-zhead-height: 455px;

    --rs-zbody-right: -280px;
    --rs-zbody-top: -72px;
    --rs-zbody-width: 410px;
    --rs-zbody-height: 470px;

    --rs-zskelly-right: -245px;
    --rs-zskelly-bottom: -175px;
    --rs-zskelly-width: 440px;
    --rs-zskelly-height: 560px;
}
```

Negative values push the art outside the panel, which is what makes it overlap
the edges. Increasing `--rs-menu-player-height` makes the item grid taller
without changing its width, the column count, or the item size.

To remove a piece of art entirely, set its width and height to `0`.

## Replacing the logo

The logo is the `rslogo.png` image in the top bar, sized by:

```css
.logo-left .rslogo {
    display: block !important;
    flex: 0 0 54px !important;
    width: 54px !important;
    height: 54px !important;
}
```

Drop your own `rslogo.png` into `html/` at roughly square dimensions, or point
the `<img>` in `html/index.html` at a different file.

There is also a `.rs-menu-watermark` element behind the grid. It ships with
`background-image: none` because an earlier version embedded an oversized data
URI. To use it, give it a `background-image` in a block at the end of the file.

## Colours

The palette is a small set of variables at the very top of the base sheet:

```css
--bg          /* page background            */
--panel-bg    /* menu panel background      */
--border      /* panel and slot borders     */
--green       /* primary text and highlight */
--green2      /* secondary text             */
--slot-bg     /* empty slot background      */
--red         /* the blood drip accents     */
```

Redefine any of them in a `:root` block at the bottom of the file to re-theme
the whole menu at once.

## A note on scaling

The menu is sized with `zoom`, not `transform: scale()`. This matters: `scale()`
rasterizes text at full size and then shrinks it on the GPU, which is what made
every label blurry before v2.6.0. `zoom` lays the UI out at its final size, so
glyphs render pixel-crisp. If you change the sizing, keep using `zoom`.
