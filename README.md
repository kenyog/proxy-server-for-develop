# Docker compose file for http-proxy server for development

This is the docker-compose file for booting http-proxy(squid) for development purpose.

## How to use

~~~
$ git clone https://github.com/kenyog/proxy-server-for-develop.git
$ cd proxy-server-for-develop
$ docker-compose build
$ docker-compose up -d
~~~
Then, you can use http-proxy server.

## Proxy setting

After booting container, You can access proxy server at folloing ports.

| Port | Proxy server protocol | Authentication |
|:--|:--|:--|
| 8001 | http                  | None   |
| 8002 | http                  | BASIC  |
| 8003 | http                  | DIGEST |
| 8011 | https                 | None   |
| 8012 | https                 | BASIC  |
| 8013 | https                 | DIGEST |

Default username and password for authentication.

| User name | Password |
|:--|:--|
| user01   | pass01     |
| user02   | pass02     |
| user03   | pass03     |

### Restriction

* Need certification file for https.
  put your cert file and private key into confs-xxx directory with name mycertfile.{crt,key}
  and comment-in the line of squid.conf
* Only port 443 is allowed for accessing remote server using protocol https.

## Check for using proxy with cURL

You can try to use proxy by following command.

* Non authentication proxy on http
  ~~~
  curl --proxy http://192.168.x.y:8001/ https://www.example.com/
  curl --proxy http://192.168.x.y:8001/ http://www.example.com/
  ~~~
* BASIC authentication proxy on http
  ~~~
  curl --proxy http://192.168.x.y:8002/ --proxy-basic  --proxy-user user02:pass02 https://www.example.com/
  curl --proxy http://192.168.x.y:8002/ --proxy-basic  --proxy-user user02:pass02 http://www.example.com/
  ~~~
* DIGEST authentication proxy on http
  ~~~
  curl --proxy http://192.168.x.y:8003/ --proxy-digest --proxy-user user03:pass03 https://www.example.com/
  curl --proxy http://192.168.x.y:8003/ --proxy-digest --proxy-user user03:pass03 http://www.example.com/
  ~~~
* Non authentication proxy on https
  ~~~
  curl --proxy https://192.168.x.y:8011/ --proxy-cacert ./rootCA.crt https://www.example.com/
  curl --proxy https://192.168.x.y:8011/ --proxy-cacert ./rootCA.crt http://www.example.com/
  ~~~
* BASIC authentication proxy on https
  ~~~
  curl --proxy https://192.168.x.y:8012/ --proxy-cacert ./rootCA.crt --proxy-basic  --proxy-user user02:pass02 https://www.example.com/
  curl --proxy https://192.168.x.y:8012/ --proxy-cacert ./rootCA.crt --proxy-basic  --proxy-user user02:pass02 http://www.example.com/
  ~~~
* DIGEST authentication proxy on https
  ~~~
  curl --proxy https://192.168.x.y:8013/ --proxy-cacert ./rootCA.crt --proxy-digest --proxy-user user03:pass03 https://www.example.com/
  curl --proxy https://192.168.x.y:8013/ --proxy-cacert ./rootCA.crt --proxy-digest --proxy-user user03:pass03 http://www.example.com/
  ~~~

