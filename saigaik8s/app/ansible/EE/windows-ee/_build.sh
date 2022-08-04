                      # タグ付け, ランタイムをdocker指定、verbosityにてログ標準出力
ansible-builder build --tag registry.saigai-ansible.com/ansible/windows-ee \
                      --container-runtime docker \
                      --verbosity 3
                      # --build-arg ANSIBLE_GALAXY_CLI_COLLECTION_OPTS=--ignore-certs \
