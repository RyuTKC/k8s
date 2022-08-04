docker stop $(docker ps -q)
docker rm $(docker ps -q -a)
docker rmi $(docker images -q)
docker volume prune

apt install netfilter-persistent
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -t raw -F
netfilter-persistent save
netfilter-persistent reload

kubectl get pods -A | awk '{ if( $4 ~ "Evicted") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "Evicted") system ("echo " $1 " " $2 " " $4)}'

kubectl get pods -A | awk '{ if( $4 ~ "Pending") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "Pending") system ("echo " $1 " " $2 " " $4)}'

kubectl get pods -A | awk '{ if( $4 ~ "Error") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "ImagePullBackOff") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "Init:ImagePullBackOff") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "CrashLoopBackOff") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "Terminating") system (" kubectl delete pods -n " $1 " " $2 " --force")}'

kubectl get pods -A | awk '{ if( $4 ~ "ErrImage") system (" kubectl delete pods -n " $1 " " $2)}'
kubectl get pods -A | awk '{ if( $4 ~ "Term") system (" kubectl delete pods --force -n " $1 " " $2)}'

kubectl get pv -A | awk '{ if( $5 ~ "Released") system (" kubectl delete pv " $1)}'


echo 3 > /proc/sys/vm/drop_caches