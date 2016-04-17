if [ "$SSH_TTY" ]
then
  cd ~/profile
  source ./ssh-agent.sh
  source ./update-profile.sh
  source ./bashrc
fi
