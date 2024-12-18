# Crée l'utilisateur docker et définir un mot de passe provisoire
sudo adduser --gecos "" docker
echo "docker:password" | sudo chpasswd

# Ajoute l'utilisateur docker au groupe sudo et au groupe docker
sudo usermod -aG sudo docker
sudo usermod -aG docker docker
sudo chown -R docker:docker /home/docker/

# Configure sudoers pour l'utilisateur docker
echo "docker ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

# Passe à l'utilisateur docker pour effectuer l'installation et les autres actions
sudo -u docker bash << EOF
# Mise à jour les paquets existants
sudo apt-get update

# Installe les paquets nécessaires pour Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Ajoute la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Ajoute le dépôt Docker à APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Mise à jour la base de données des paquets
sudo apt-get update

# Installe Docker
sudo apt-get install -y docker-ce

# Active Docker pour qu'il démarre au démarrage du système
sudo systemctl enable docker

# Vérifie l'installation de Docker
sudo systemctl status docker

# Installe Python et pip
sudo apt-get install -y python3 python3-pip

# Vérifie l'installation de Python
python3 --version
pip3 --version

# Installe Docker-Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Vérifier l'installation de Docker Compose
docker-compose --version

# Crée le répertoire .ssh et générer la clé SSH
mkdir -p /home/docker/.ssh
cd /home/docker/.ssh

# Génére une clé SSH ed25519 (le nom sera 'id_srv-docker')
ssh-keygen -t ed25519 -f id_srv-docker -N ""

# Ajoute la clé publique au fichier authorized_keys
cat id_srv-docker.pub >> authorized_keys

EOF

echo "Installation de Docker, Python et Docker Compose terminée avec succès."
echo "Configuration SSH pour l'utilisateur 'docker' terminée. L'utilisateur 'docker' est prêt à être utilisé, son mot de passe sera à modifier à la prochaine connexion."
