#!/usr/bin/bash

NAME="gitlab"

get_sec=`eval $'kubectl get secret -n rook-ceph | grep $NAME'`
get_conf=`eval $'kubectl get cm -n rook-ceph | grep $NAME'`
secrets=()
confs=()

for s in $get_sec
do
  if [[ "$s" == *$NAME* ]]; then
    secrets+=("$s")
  fi
done

for s in $get_conf
do
  if [[ "$s" == *$NAME* ]]; then
    confs+=("$s")
  fi
done

for (( i= 0; i< ${#secrets[@]}; i++ )) {
  setting_name=${secrets[$i]}
  # デコード
  key_id=`eval $'kubectl get secret/${secrets[$i]} -n rook-ceph -o jsonpath={.data.AWS_ACCESS_KEY_ID} | base64 -d && echo'`
  key=`eval $'kubectl get secret/${secrets[$i]} -n rook-ceph -o jsonpath={.data.AWS_SECRET_ACCESS_KEY} | base64 -d && echo'`
  
  b_host=`eval $'kubectl get cm/${confs[$i]} -n rook-ceph -o jsonpath={.data.BUCKET_HOST}'`
  # b_endpoint=`eval $'echo "https://$b_host" | base64 && echo'`
  b_endpoint='https://rook-ceph-rgw-ceph-object.rook-ceph.svc.cluster.local'

  b_name=`eval $'kubectl get cm/${confs[$i]} -n rook-ceph -o jsonpath={.data.BUCKET_NAME}'`
  b_port=`eval $'kubectl get cm/${confs[$i]} -n rook-ceph -o jsonpath={.data.BUCKET_PORT}'`
  b_region=`eval $'kubectl get cm/${confs[$i]} -n rook-ceph -o jsonpath={.data.BUCKET_REGION}'`
  b_subregion=`eval $'kubectl get cm/${confs[$i]} -n rook-ceph -o jsonpath={.data.BUCKET_SUBREGION}'`

  if [[ "$setting_name" == *registry* ]]; then
con_data=$(cat <<-EOS
s3:
  bucket: ${b_name}
  region: us-east-1
  accesskey: ${key_id}
  secretkey: ${key}
  v4auth: true
  endpoint: ${b_endpoint}
EOS
)
  else
con_data=$(cat <<-EOS
provider: AWS
region: ${b_region}
aws_access_key_id: ${key_id}
aws_secret_access_key: ${key}
aws_signature_version: 4
v4auth: true
endpoint: ${b_endpoint}
EOS
)
  fi

con_en=`eval $'echo "$con_data" | base64 && echo'`
con_en2=`echo $con_en | sed -e "s/[ |\n]//g"`
# echo "$con_en"

cat <<-EOD >> bucket_secrets.yml
---
apiVersion: v1
data:
  connection: "${con_en2}"
kind: Secret
metadata:
  name: ${setting_name}
  namespace: gitlab-helm
type: Opaque
EOD
}


# kubectl get cm -n rook-ceph | grep $NAME | \
# awk '{ system("kubectl get cm -n rook-ceph -o yaml " $1 " | grep BUCKET") }'