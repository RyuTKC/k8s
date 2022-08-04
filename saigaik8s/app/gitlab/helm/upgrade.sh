WORK_DIR=$(cd $(dirname $0); pwd)

helm upgrade gitlab-helm gitlab/gitlab -n gitlab-helm \
  -f "${WORK_DIR}"/values.yml \
  --set gitlab.migrations.enabled=true \
  # --version <new version> \