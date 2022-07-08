# UserGeneratorLinux

Le premier script bash (newUser) permettant de creer une serie d'utilisateurs via un fichier texte.
Il permet:
-la creation des utilisateurs du .txt
-si un utilisateur a deja été inscrit,il ne le réinscrit pas
-créer entre 5 et 10 fichiers dans le repertoire personnel du user creer de taille entre 5 et 50 Mo
-chaque mdp est à redéfinir à la connexion
-un commentaire est fait dans etc/passwd avec le nom et prenom à chaque nouvel utilisateur

Le deuxieme script bash (sizeFile) permet de lister la taille de tous les repertoires des utilisateurs.


## Utilisation

#### Lancer newUser

```bash
./newUser.sh users.txt
```
#### Lancer sizeFile

```bash
./sizeFile.sh
```
