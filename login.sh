source ./profile/bashrc
cd /var/www/html
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_lubikx_id_rsa
echo Welcome to $HOSTNAME

