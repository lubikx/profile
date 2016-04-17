echo -n "Initializing ssh-agent: "
eval "$(ssh-agent -s)"
echo "Adding private github key"
ssh-add ~/.ssh/github_lubikx_id_rsa
