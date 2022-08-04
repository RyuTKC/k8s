PS_USER=$(kubectl get secret gitlab-root.gitlab-postgres.credentials.postgresql.acid.zalan.do -n z-postgres -o 'jsonpath={.data.username}' | base64 -d)
PS_PASS=$(kubectl get secret gitlab-root.gitlab-postgres.credentials.postgresql.acid.zalan.do -n z-postgres -o 'jsonpath={.data.password}' | base64 -d)

echo "username: $PS_USER"
echo "password: $PS_PASS"

PS_USER2=$(kubectl get secret gitlab-user.gitlab-postgres.credentials.postgresql.acid.zalan.do -n z-postgres -o 'jsonpath={.data.username}' | base64 -d)
PS_PASS2=$(kubectl get secret gitlab-user.gitlab-postgres.credentials.postgresql.acid.zalan.do -n z-postgres -o 'jsonpath={.data.password}' | base64 -d)

echo "username2: $PS_USER2"
echo "password2: $PS_PASS2"