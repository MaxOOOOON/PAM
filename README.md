# PAM
1. Запретить всем пользователям, кроме группы admin, логин в выходные (суббота и воскресенье), без учета праздников
2. Дать конкретному пользователю права работать с докером и возможность рестартить докер сервис
---
1. Запретить всем пользователям, кроме группы admin, логин в выходные (суббота и воскресенье), без учета праздников

Создание пользователя

    sudo useradd user1 
    echo "Passwd!@#" | sudo passwd --stdin user1

Разрешение входа по паролю 

    sudo bash -c "sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config && systemctl restart sshd.service"

Редактирование файла /etc/pam.d/sshd
Необходимо добавить строчку 

    account    required     pam_exec.so  /usr/local/bin/check_user.sh

И установить разрешение на выполнение

    chmod +x /usr/local/bin/check_user.sh

Проверка




2. Дать конкретному пользователю права работать с докером и возможность рестартить докер сервис

Установка и запуск докера

    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce -y
    systemctl enable docker 
    systemctl start docker

Добавление пользователя в группу docker  

    sudo usermod -aG docker user1

Правило разрешения рестарта docker сервиса для пользователя user1

cat /etc/polkit-1/rules.d/10-docker.rules

    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            action.lookup("unit") == "docker.service" &&
            action.lookup("verb") == "restart" &&
            subject.user == "user1")
        {
            return polkit.Result.YES;
        }
    })


