server {
    listen {{ .interface }}:8099 default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location / {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://backend/;
        sub_filter_once off;
        sub_filter_types *;
        sub_filter '/iris/'  '{{ .entry }}/iris/';
        sub_filter '/mopidy/ws' '{{ .entry }}/mopidy/ws';
        sub_filter 'href="manifest.json">' 'href="manifest.json" crossorigin="use-credentials">';
        sub_filter 'document.body.appendChild(js);' 'document.body.appendChild(js); (function() { var wait=function(){let t=document.querySelector(".sidebar__menu__item");t?t.click():setTimeout(function(){wait()},100)};wait(); })();';
    }
}