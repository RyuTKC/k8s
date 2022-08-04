#!/usr/bin/bash

WORK_DIR=$(cd $(dirname $0); pwd)

helm delete -n rook-ceph rook-ceph-cluster