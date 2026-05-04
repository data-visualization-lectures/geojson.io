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

`npm run build` will create minified bundles in `/dist`. You can try out the production build with `npm run serve` which will run live-server.

`npm run deploy` runs `deploy.sh`, which creates a production build locally and force-pushes the deployment worktree to the `gh-pages` branch.

### Netlify Deployment Workflow

このリポジトリでは、デプロイのために 2 つのブランチを使います。

- `main`: ソースコード、ドキュメント、日常の修正作業を行うブランチ
- `gh-pages`: `npm run deploy` でローカル build した成果物を置く配信用ブランチ

Netlify 側の設定は次の通りです。

- Production branch: `gh-pages`
- Build command: 空欄
- Publish directory: `.`

今後の標準手順は次の通りです。

1. `main` に切り替える
2. 最新の `main` を pull する
3. 修正作業を `main` で行う
4. 必要に応じて `npm start` でローカル確認する
5. `npm run build` を実行して本番 build が通ることを確認する
6. `main` の変更を commit / push する
7. 引き続き `main` で `npm run deploy` を実行する
8. `gh-pages` に force-push されたことと、Netlify の deploy が始まったことを確認する

注意点:

- `gh-pages` は生成物ブランチなので、通常は直接編集しない
- `main` を push しただけでは公開は更新されず、公開更新には `npm run deploy` が必要
- `npm run deploy` は `gh-pages` を force-push するため、先に `main` の反映したい変更を commit しておく
- GitHub Desktop では通常 `main` を確認し、`gh-pages` は生成物確認用と考える

## License

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io.svg?type=large)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fmapbox%2Fgeojson.io?ref=badge_large)
