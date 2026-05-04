# geojson.io

Prj_DatavizJP 向けに調整している `geojson.io` の、初見者向けビルド・デプロイ手順です。  
コードを書き始める前に、この README の順番どおりに進めればローカル起動から Netlify 公開まで一通り確認できます。

英語版の元 README は [README_en.md](./README_en.md) を参照してください。

## 前提条件

- `Node.js 14.x`
- `npm`
- GitHub リポジトリへの push 権限
- Netlify サイトの設定変更権限
- Mapbox の public access token

`package.json` の `engines.node` は `14` です。  
Node の切り替えに `nvm` を使う場合は、先に以下を実行してください。

```bash
nvm install 14
nvm use 14
```

## 初回セットアップ

1. リポジトリを clone して移動します。

```bash
git clone <your-repo-url>
cd geojson.io
```

2. 依存関係をインストールします。

```bash
npm install
```

3. Mapbox token を設定します。

```bash
cp .env.example .env
```

`.env` を開き、`MAPBOX_ACCESS_TOKEN` に利用する token を入れてください。

```dotenv
MAPBOX_ACCESS_TOKEN=pk.xxxxxxxxxxxxxxxxxxxx
```

4. 任意で lint を実行します。

```bash
npm test
```

`npm test` は現在 `eslint` の実行です。

## ローカル開発

以下で開発サーバーを起動します。

```bash
npm start
```

起動後は `http://127.0.0.1:8080` で確認できます。

`npm start` では次の 3 つが同時に動きます。

- `live-server`: ルートディレクトリを配信
- `rollup -cw`: JavaScript バンドルを watch build
- `tailwindcss --watch`: `dist/css/tailwind_dist.css` を再生成

初回の `rollup` ビルドは数秒かかることがあります。ブラウザを開いてすぐ画面が不完全でも、まずビルド完了を待ってください。

## 本番ビルド

本番用の静的アセットを作るときは以下を実行します。

```bash
npm run build
```

生成物は `dist/` に出ます。

ビルド済み成果物をローカル確認したい場合は以下です。

```bash
npm run serve
```

`index.html` が `dist/` 配下の bundle を読む構成なので、`serve` はプロジェクトルートを配信します。

## デプロイ手順

このリポジトリは `main` で作業し、`gh-pages` ブランチを Netlify の本番配信用ブランチとして使います。

### 実行前の注意

- `npm run deploy` は `main` の commit を基準に build して `origin/gh-pages` に force push します
- `main` に未 commit の変更があると deploy は止まります
- ローカルの `gh-pages` worktree が別に存在していても deploy 自体は実行できます
- Netlify が参照するのは remote の `gh-pages` です

### 実行手順

1. `main` にいることを確認します。

```bash
git branch --show-current
```

2. 変更を commit します。

```bash
git status
git add -A
git commit -m "your message"
```

3. デプロイを実行します。

```bash
npm run deploy
```

4. スクリプト完了後、Netlify 側で反映を確認します。

`npm run deploy` は内部で [deploy.sh](./deploy.sh) を実行し、次をまとめて行います。

1. `main` に未 commit の tracked 変更がないことを確認
2. 必要なら `npm install`
3. `npm run build`
4. 一時 detached worktree を作成
5. build 済みの `dist/` をその worktree にコピー
6. deploy 用 commit を `--no-verify` で作成
7. `origin/gh-pages` へ force push

## Netlify 設定

Netlify 側は次の設定にします。

- Production branch: `gh-pages`
- Build command: 空欄
- Publish directory: `.`

独自ドメインを使う場合は、ルートの [CNAME](./CNAME) を公開したいドメイン名に合わせて管理してください。

## よくある詰まりどころ

### `MAPBOX_ACCESS_TOKEN` を入れていない

ビルドは通っても、地図や geocoder が正常に動きません。  
まず `.env` の値を確認してください。

### 新しい Node.js で依存解決に失敗する

既存 README の注意書きどおり、`rollup` 周りで依存解決エラーが出ることがあります。

```bash
npm install --force
```

この回避策で入れ直した場合、`package-lock.json` の差分をそのまま commit しないよう注意してください。

### `npm run deploy` が `gh-pages` worktree とぶつかる

今の deploy スクリプトは、ローカルの `gh-pages` branch を削除・付け替えません。  
そのため `gh-pages` を別 worktree で開いていても、remote の `gh-pages` へ deploy できます。
