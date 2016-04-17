export REALNAME=`who am i | awk '{print $1}'`

# http://bashrcgenerator.com/
export PS1="\[\033[38;5;10m\]$REALNAME\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;11m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;74m\]\w\[$(tput sgr0)\]\[\033[38;5;6m\]]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

cd /var/www/html
echo Welcome to $HOSTNAME
