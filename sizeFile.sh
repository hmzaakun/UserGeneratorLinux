#!/bin/bash

users=($(grep -E "/bin/bash|/bin/sh" /etc/passwd))
j=0
for i in ${users[@]}; do
    values=(${i//:/ })
    if [ ${values[0]} == "root" ]; then
        size=$(du -sh /root | cut -f1)
        size=$size"o"
    else
        size=$(du -sh /home/${values[0]} | cut -f1)
        size=$size"o"
    fi
    users[$j]="${values[0]}:${size}"
    j=$(($j+1))
done

echo ${users[@]}
