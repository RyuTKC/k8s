kubectl --namespace gitlab-helm get PersistentVolumeClaims -l release=gitlab-helm -ojsonpath='{range .items[*]}{.spec.volumeName}{"\t"}{.metadata.labels.app}{"\n"}{end}'

kubectl get pvc/gitlab-helm-prometheus-server -n gitlab-helm -o yaml > gitlab-helm-prometheus-server.yml
kubectl get pvc/redis-data-gitlab-helm-redis-master-0 -n gitlab-helm -o yaml> redis-data-gitlab-helm-redis-master-0.yml
kubectl get pvc/repo-data-gitlab-helm-gitaly-0 -n gitlab-helm -o yaml> repo-data-gitlab-helm-gitaly-0.yml