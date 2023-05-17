# プロキシ環境構築

開発用に使うためのプロキシサーバーをたてるコンテナ定義ファイルです。

## 使い方

~~~
$ docker-compose build
$ docker-compose up -d
~~~

## プロキシ設定

以下の各ポートで設定の異なるプロキシサーバーが起動します

| port | プロキシプロトコル | 認証   |
|:--|:--|:--|
| 8001 | http               | なし   |
| 8002 | http               | BASIC  |
| 8003 | http               | DIGEST |
| 8011 | https              | なし   |
| 8012 | https              | BASIC  |
| 8013 | https              | DIGEST |

認証ありの場合のパスワードは以下の通り

| ユーザー | パスワード |
|:--|:--|
| user01   | pass01     |
| user02   | pass02     |
| user03   | pass03     |

### 制限

* 証明書が必要です
  各squid.confのhttps_portの行をコメントインしたうえで、証明書とその秘密鍵ファイルを設定してください
* 通信先サーバーがhttpsの場合、ポート443のみを有効です


## cURLによるアクセスチェック

以下のコマンドでプロキシを試せます

### 認証なしプロキシ on http
~~~
curl --proxy http://192.168.x.y:8001/ https://www.example.com/
curl --proxy http://192.168.x.y:8001/ http://www.example.com/
~~~

### BASIC認証プロキシ on http
~~~
curl --proxy http://192.168.x.y:8002/ --proxy-basic  --proxy-user user02:pass02 https://www.example.com/
curl --proxy http://192.168.x.y:8002/ --proxy-basic  --proxy-user user02:pass02 http://www.example.com/
~~~

### DIGEST認証プロキシ on http
~~~
curl --proxy http://192.168.x.y:8003/ --proxy-digest --proxy-user user03:pass03 https://www.example.com/
curl --proxy http://192.168.x.y:8003/ --proxy-digest --proxy-user user03:pass03 http://www.example.com/
~~~

### 認証なしプロキシ on https
~~~
curl --proxy https://192.168.x.y:8011/ --proxy-cacert ./rootCA.crt https://www.example.com/
curl --proxy https://192.168.x.y:8011/ --proxy-cacert ./rootCA.crt http://www.example.com/
~~~

### BASIC認証プロキシ on https
~~~
curl --proxy https://192.168.x.y:8012/ --proxy-cacert ./rootCA.crt --proxy-basic  --proxy-user user02:pass02 https://www.example.com/
curl --proxy https://192.168.x.y:8012/ --proxy-cacert ./rootCA.crt --proxy-basic  --proxy-user user02:pass02 http://www.example.com/
~~~

## DIGEST認証プロキシ on https
~~~
curl --proxy https://192.168.x.y:8013/ --proxy-cacert ./rootCA.crt --proxy-digest --proxy-user user03:pass03 https://www.example.com/
curl --proxy https://192.168.x.y:8013/ --proxy-cacert ./rootCA.crt --proxy-digest --proxy-user user03:pass03 http://www.example.com/
~~~

