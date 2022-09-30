# nginx-certbot-docker-compose

## First run
``` bash
./first-start.sh
```

enter your hostname
enter the email for letsencrypt

on success

## configure target container

add your service to docker compose.

Example:


``` yaml

services: 

...
    yourService:
        image: yourImage

```

add your service to:  `./nginx/nginx.conf`


``` conf
...
server {
    listen 443 ssl;
    ...
    ssl_certificate_key ...;

    location / {
        proxy_pass http://yourService;
    }
}
...

```

then run: `docker-compose up`