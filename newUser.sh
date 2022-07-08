#!/bin/bash

#On vérifie si il y a un argument
if [ $# -ne 1 ]; then
    echo "Nombre d'argument invalide, il en faut juste 1."
    exit 1
fi

#On vérifie s'il l'utilisateur est en root
if [ "$EUID" -ne 0 ]; then
	echo "Il est nécessaire d'etre root."
	exit 1
fi

#On range chacune des lignes des users
lines=($(cat $1))

#On récupère les users qui existent deja
users=($(cut -d: -f1 /etc/passwd))

for i in ${lines[@]}; do

    values=(${i//:/ }) 

    if [ ${#values[@]} -ne 4 ]; then
        echo "les 4 champs ne sont pas remplis à la ligne $i pour l'utilisateur ${values[0]}"
        exit 1
    fi

    if [[ " ${users[@]} " =~ " ${values[0]} " ]]; then
        echo "${values[0]} existe déjà"
        echo ""
      else
        echo "l'utilisateur ${values[0]} n'existe pas, création..."

        #partie creation user :
        echo "Création de l'utilisateur ${values[0]}"
        useradd -m ${values[0]}
        echo "${values[0]}:${values[3]}" | chpasswd
        passwd -e ${values[0]}
        echo "# ${values[1]}:${values[2]}" >> /etc/passwd


        #entre 5 et 10 fichiers générés
      file=$(($RANDOM % 6 + 5))
      echo "nous allons creer $file fichiers"
      echo " "
      for ((i=0; i<$file; i++)); do
     	echo "creation du fichier No:$i"
        name=$(​pwgen 8 1​)
        touch /home/${values[0]}/$name
        #taille entre 5 et 50 Mo
        size=$(($RANDOM % 46 + 5))
        size=$(($size*1024*1024))
        dd if=/dev/urandom of=/home/${values[0]}/$name bs=1 count=$size status=progress
        echo "creation du fichier No:$i finis"
        echo " "
    done
    fi

done
echo " ";
echo "Tout est bon.";
#cd /home/hamza/Bureau
#nano /etc/passwd
