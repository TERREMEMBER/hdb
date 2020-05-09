使用该playbook遵循如下步骤：
1.在该目录下 放入inhybrid-db.tar文件
2.配置/etc/ansible/hosts 文件，包含如下3个主机组
  [hdb_all] 包含全部主机
  [master] 包含master节点
  [segement] 包含segement节点
  例：
        [hdb_all]
        172.12.0.10
        172.12.0.11
        172.12.0.12
        172.12.0.13

        [master]
        172.12.0.10

        [segment]
        172.12.0.11
        172.12.0.12
        172.12.0.13
3.运行 ansible-playbook playbook.yml