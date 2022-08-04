NAME="gitlab"

configs=`eval $'kubectl get cm -n rook-ceph | grep $NAME'`

for cm in $configs
do
  if [[ "$cm" == *$NAME* ]]; then
    echo $cm
    kubectl get cm/$cm -n rook-ceph -o jsonpath={.data.BUCKET_NAME}
    echo -e "\n"
  fi
done

# kubectl get cm -n rook-ceph | grep git | awk '{ system("kubectl get cm/" $1 " -n rook-ceph -o jsonpath={.data.BUCKET_NAME} | echo") }'