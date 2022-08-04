#!/usr/bin/bash

kubectl get secret gitlab-root.gitlab-postgres.credentials.postgresql.acid.zalan.do -n z-postgres -o yaml > db_secret.yml