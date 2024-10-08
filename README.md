**※このリポジトリは、[misskey.mt224244.com](https://misskey.mt224244.com)用にカスタマイズされています。**

Misskey本体。

- misskey
- [misskey-backup](https://github.com/MT224244/misskey-backup)
- [misskey-nginx-proxy](https://github.com/MT224244/misskey-nginx-proxy)

## 起動方法

1. `.config/.env.misskey.example` をコピーして `.config/.env.misskey` を作る
1. `.config/.env.postgres.example` をコピーして `.config/.env.postgres` を作る
1. `.config/default.yml.docker_compose` をコピーして `.config/default.yml` を作る
1. `compose_example.yml` をコピーして `compose.yml` を作る
1. 必要な情報を入れる
1. `docker compose build`
1. `docker compose run --rm web pnpm run init`
1. `docker compose up -d`

## ローカル実行時

- `.config/.env.misskey`
	- `VIRTUAL_HOST=localhost`
- `.config/default.yml`
	- `url: http://localhost:3000`
- `compose.yml`
	- `web` の `expose` は `ports` に変える
	- `ports` の値は `3000:3000`

これで `http://localhost:3000` にアクセスすれば見られるはず

## バージョンアップ方法

### 開発環境

1. upstreamをpull
1. `misskey-mt224244` にcheckout
1. 新バージョンのタグをマージする
	- `package.json` のversionも更新しておく
	- 必ず一度ローカルで動作確認すること
1. `{バージョン名}-mt224244` でタグを作る
1. push(タグも忘れずにpush)

### 本番環境

1. 本番環境のMisskeyを止める
	- `docker compose down`
1. `misskey-mt224244` にcheckout
1. pull
1. build & 起動
	1. `docker compose build`
	1. `docker compose run --rm web pnpm run init`
	1. `docker compose up -d`

### out of memoryでビルドが落ちる場合

`Dockerfile` の `NODE_ENV` が書いてあるあたりに以下を追加

```dockerfile
ARG NODE_OPTIONS="--max-old-space-size=4096"
```

---

<div align="center">
<a href="https://misskey-hub.net">
	<img src="./assets/title_float.svg" alt="Misskey logo" style="border-radius:50%" width="300"/>
</a>

**🌎 **Misskey** is an open source, federated social media platform that's free forever! 🚀**

[Learn more](https://misskey-hub.net/)

---

<a href="https://misskey-hub.net/servers/">
		<img src="https://custom-icon-badges.herokuapp.com/badge/find_an-instance-acea31?logoColor=acea31&style=for-the-badge&logo=misskey&labelColor=363B40" alt="find an instance"/></a>

<a href="https://misskey-hub.net/docs/for-admin/install/guides/">
		<img src="https://custom-icon-badges.herokuapp.com/badge/create_an-instance-FBD53C?logoColor=FBD53C&style=for-the-badge&logo=server&labelColor=363B40" alt="create an instance"/></a>

<a href="./CONTRIBUTING.md">
		<img src="https://custom-icon-badges.herokuapp.com/badge/become_a-contributor-A371F7?logoColor=A371F7&style=for-the-badge&logo=git-merge&labelColor=363B40" alt="become a contributor"/></a>

<a href="https://discord.gg/Wp8gVStHW3">
		<img src="https://custom-icon-badges.herokuapp.com/badge/join_the-community-5865F2?logoColor=5865F2&style=for-the-badge&logo=discord&labelColor=363B40" alt="join the community"/></a>

<a href="https://www.patreon.com/syuilo">
		<img src="https://custom-icon-badges.herokuapp.com/badge/become_a-patron-F96854?logoColor=F96854&style=for-the-badge&logo=patreon&labelColor=363B40" alt="become a patron"/></a>

</div>

## Thanks

<a href="https://sentry.io/"><img src="https://github.com/misskey-dev/misskey/assets/4439005/98576556-222f-467a-94be-e98dbda1d852" height="30" alt="Sentry" /></a>

Thanks to [Sentry](https://sentry.io/) for providing the error tracking platform that helps us catch unexpected errors.

<a href="https://www.chromatic.com/"><img src="https://user-images.githubusercontent.com/321738/84662277-e3db4f80-af1b-11ea-88f5-91d67a5e59f6.png" height="30" alt="Chromatic" /></a>

Thanks to [Chromatic](https://www.chromatic.com/) for providing the visual testing platform that helps us review UI changes and catch visual regressions.

<a href="https://about.codecov.io/for/open-source/"><img src="https://about.codecov.io/wp-content/themes/codecov/assets/brand/sentry-cobranding/logos/codecov-by-sentry-logo.svg" height="30" alt="Codecov" /></a>

Thanks to [Codecov](https://about.codecov.io/for/open-source/) for providing the code coverage platform that helps us improve our test coverage.

<a href="https://crowdin.com/"><img src="https://user-images.githubusercontent.com/20679825/230709597-1299a011-171a-4294-a91e-355a9b37c672.svg" height="30" alt="Crowdin" /></a>

Thanks to [Crowdin](https://crowdin.com/) for providing the localization platform that helps us translate Misskey into many languages.

<a href="https://hub.docker.com/"><img src="https://user-images.githubusercontent.com/20679825/230148221-f8e73a32-a49b-47c3-9029-9a15c3824f92.png" height="30" alt="Docker" /></a>

Thanks to [Docker](https://hub.docker.com/) for providing the container platform that helps us run Misskey in production.
