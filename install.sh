#!/bin/bash
echo "if [ -f profile/login.sh ];" >> ~/.bashrc
echo "then" >> ~/.bashrc
echo "  source ./profile/login.sh" >> ~/.bashrc
echo "fi" >> ~/.bashrc

git clone https://github.com/lubikx/profile.git ~/profile
