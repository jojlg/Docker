# Que fait ce script
* Crée un nouvel utilisateur docker avec un mot de passe provisoire.
* Ajoute l'utilisateur docker aux groupes sudo et docker.
* Met à jour la liste des paquets.
* Installe les paquets nécessaires pour Docker.
* Ajoute la clé GPG officielle de Docker et le dépôt Docker à APT.
* Met à jour la base de données des paquets et installe Docker.
* Active Docker pour qu'il démarre au démarrage du système et vérifie son statut.
* Installe Python 3 et pip.
* Vérifie les versions installées de Python et pip.
* Télécharge et installe la dernière version de Docker Compose.
* Vérifie l'installation de Docker Compose.
Configuration SSH pour l'utilisateur docker :

* Crée le répertoire .ssh dans le dossier de l'utilisateur docker.
* Génère une clé SSH ed25519 pour l'utilisateur docker.
* Ajoute la clé publique générée au fichier authorized_keys.

*Donner au système l’autorisation d’exécuter le script* `chmod +x docker-install.sh`
