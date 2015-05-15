#!/bin/bash

usage() {
    echo " ======================================================================="
    echo "|                                                                       |"
    echo "|    仪器控测试平台自动搭建脚本                                         |"
    echo "|    sudo ./deploy.sh [ up(部署) | down(撤销) | rebuild(重新构建) ]     |"
    echo "|                                                                       |"
    echo " ======================================================================="
    return 1
}

work() {

    file="$1.sh"
    p=$(pwd)

    for app in $(ls .);
    do
        if [ -d "$app" ] && [ -f "$app/$file" ]; then
            echo "$app do $file ing..."
            ./$app/$file
            echo "====="
        fi
    done
}

update_wine_dnsmasq() {

    echo -n '' > /etc/dnsmasq.d/yiqikong
    echo "address=/yiqikong-reserve.wine.genee.cn/192.168.0.20" >> /etc/dnsmasq.d/yiqikong
    echo "address=/yiqikong-wechat/192.168.0.20" >> /etc/dnsmasq.d/yiqikong
    echo "address=/yiqikong-control/192.168.0.20" >> /etc/dnsmasq.d/yiqikong

    service dnsmasq restart

}

if [ $(id -u) -ne 0 ]; then
    usage
    exit 0
fi

case "$1" in
    up | down )
        action="$1"
        update_wine_dnsmasq
        work $action
        exit 0
        ;;
    rebuild )
        work "down"
        update_wine_dnsmasq
        work "up"
        exit 0
        ;;
    *)
        usage
        exit 0
        ;;
esac
