#!/bin/bash

rm -R frappe-bench

bench init --skip-redis-config-generation --frappe-path https://github.com/GraficheAquilane2021/frappe --frappe-branch version-12 frappe-bench
cd frappe-bench

bench set-mariadb-host mariadb
bench set-redis-cache-host redis-cache:6379
bench set-redis-queue-host redis-queue:6379
bench set-redis-socketio-host redis-socketio:6379

bench new-site erpnext.localhost --mariadb-root-password 123 --admin-password admin --no-mariadb-socket

bench --site erpnext.localhost set-config developer_mode 1
bench --site erpnext.localhost clear-cache

bench get-app --branch version-12 erpnext https://github.com/GraficheAquilane2021/erpnext.git
bench --site erpnext.localhost install-app erpnext