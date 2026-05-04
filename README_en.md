[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io.svg?type=shield)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io?ref=badge_shield)

# geojson.io

![](http://i.cloudup.com/kz3BAF7Hnx.png)

A fast, simple editor for map data. Read more on [Mapbox](https://www.mapbox.com/blog/geojsonio-announce/),
[macwright.org](https://macwright.org/2013/07/26/geojsonio.html).

## Goes Great With!

**Tools**

- [Using geojson.io with GitHub is better with the Chrome Extension](https://chrome.google.com/webstore/detail/geojsonio/oibjgofbhldcajfamjganpeacipebckp)
- [geojsonio-cli](https://github.com/mapbox/geojsonio-cli) lets you shoot geojson from your terminal to geojson.io! (with nodejs)
- [geojsonio.py](https://github.com/jwass/geojsonio.py) lets you shoot geojson from your terminal to geojson.io! (with python)

## API

You can interact with geojson.io programmatically via URL parameters. Here is an example of geojson encoded into the URL:

http://geojson.io/#data=data:application/json,%7B%22type%22%3A%22LineString%22%2C%22coordinates%22%3A%5B%5B0%2C0%5D%2C%5B10%2C10%5D%5D%7D

Full API documentation can be found in [API.md](API.md).

## Development

1. Clone this repository
2. Install dependencies
3. Run `npm start`

`npm start` uses `concurrently` to run `live-server` which will serve the project directory in your browser and listen for changes, `rollup` which will build the js and css bundles, and `npx tailwindcss` which builds `css/tailwind_dist.css` (including only the tailwind rules needed in the project)

`rollup` can take several seconds to build before changes appear in the browser.

If you get an error resolving dependencies related to `rollup` on newer versions of node, then try `npm install --force` and be sure to not commit changes to `package-lock.json`.

## Production Build & Deployment

`npm run build` creates the production assets in `/dist`. You can preview the production build locally with `npm run serve`.

Run `npm run deploy` from `main` after your changes are committed. The deploy script:

1. checks that `main` has no uncommitted tracked changes
2. runs `npm install` only if `node_modules` is missing
3. runs `npm run build`
4. creates a temporary detached worktree from `main`
5. copies the built `dist/` directory into that worktree
6. creates a deploy commit with `--no-verify`
7. force-pushes that commit to `origin/gh-pages`

This avoids deleting or reassigning a local `gh-pages` branch, so it still works if `gh-pages` is checked out in another worktree.

Netlify memo:

- 作業と修正は `main`
- `main` で `npm run deploy`
- 生成物は `gh-pages` に force push
- Netlify の Production branch は `gh-pages`
- Netlify の Build command は空欄
- Netlify の Publish directory は `.`

## License

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io.svg?type=large)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io?ref=badge_large)
