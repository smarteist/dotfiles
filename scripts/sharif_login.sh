#!/bin/bash

readonly username="ali.hosseini74"

readonly passowrd="$(echo "adadasdasda" | base64 --decode)"

sharif_login_status () {
    curl -s "https://net2.sharif.edu/status" | grep -oP '<td(?:\s[^>]*)?>\K.*?(?=</td>)'
}

sharif_login () {
    curl -d "username=$username&password=$passowrd" -X POST "https://net2.sharif.edu/login" > /dev/null
    sharif_login_status
}

sharif_login_ip () {
    curl -d "username=$username&password=$passowrd" -X POST -k "https://172.17.1.214/login" > /dev/null
    sharif_login_status
}

sharif_logout () {
    curl -d "username=$username&password=$passowrd" -X POST "https://net2.sharif.edu/logout"
    sharif_login_status
}

sharif_logout_ip () {
    curl -d "username=$username&password=$passowrd" -X POST "https://172.17.1.214/logout"
    sharif_login_status
}

if [ $1 ]; then
    eval $1
else
    sharif_login_ip
fi
