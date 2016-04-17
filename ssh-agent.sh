if [ -f ~/.ssh/github_lubikx_id_rsa ];
then
  echo -n "Initializing ssh-agent: "
  eval "$(ssh-agent -s)"
  echo "Adding private github key"
  ssh-add ~/.ssh/github_lubikx_id_rsa
else
  echo "Private github key not found! You will not be able to commit from this machine."
fi
