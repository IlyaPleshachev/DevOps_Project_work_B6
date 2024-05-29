# 1. Развёртывание серверов.

## Инструкция по использованию

В консоли перейти в каталог
```console
cd d:\Devops\Projects\Repo\DevOps_Project_work_B6\Terraform\
```

```console
terraform init
```

```console
terraform apply
```

```console
terraform destroy
```

# 2. Настройка.

## Создание пользователя ansible на VM-1

Создаём пользователя "ansible" с паролем "ansible", папку для ключей и даём права sudo:

```console
sudo adduser ansible
sudo mkdir -p /home/ansible/.ssh
sudo chown -R ansible:ansible /home/ansible/.ssh
sudo bash -c 'echo $ANSIBLE_USER_PUBLIC_KEY >> /home/ansible/.ssh/authorized_keys'
sudo usermod -a -G sudo ansible
```

## SSH права доступа к файлам ключей на VM

Переключаемся под нового пользователя и создаём ключи без парольной фразы, для корректной работы скриптов

```console
su ansible
cd /home/ansible/
ssh-keygen 
```
Читаем файл публичного ключа и переносим его на VM-2 и VM-3
```console
cd /home/ansible/
cat ~/.ssh/id_rsa.pub
```

На VM-2 и VM-3 создаём файл с ключом и добавляем в .shh
```console
echo "ssh-rsa IDDQD+....IDKFA= nsible@edu-vm1-ubuntu-2004" >> vm1_key.pub
cat vm1_key.pub

cat vm1_key.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
```
После подключаемся из VM-1 к удалённым VM-2 и VM-3. Через пользователя ubuntu на них.
```console
ssh -i ~/.ssh/id_rsa ubuntu@192.168.10.13
```

# 3. Установка и использование Ansible.

## Установка Ansible

```console
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Настройка

```
sudo nano /etc/ansible/ansible.cfg

[defaults]
remote_user = ubuntu
sudo_user = ubuntu
remote_port             = 22
timeout                 = 10
host_key_checking       = False
ssh_executable          = /usr/bin/ssh
private_key_file        = ~/.ssh/id_rsa
inventory               = hosts

[privilege_scalation]

become                  = True
become_method           = sudo
become_user             = ubuntu
become_ask_pass         = False

```console

## Создание файла Inventory и Playbooks

```console
su ansible 
cd /home/ansible/
sudo nano /etc/ansible/hosts
nano playbook-anyos-docker.yml
nano playbook-ubuntu-postgresql.yml
```

## Пинг через Ansible

```console
ansible all -i inventory-hosts.ini -m ping
```

## Запуск Ansible playbooks

```console
ansible-playbook playbook-anyos-docker.yml
ansible-playbook playbook-ubuntu-postgresql.yml
```