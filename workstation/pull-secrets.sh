#!/bin/bash

set -eu

echo "Authenticating with 1Password"
export OP_SESSION_ibm=$(op signin https://ibm.ent.1password.com danberg@us.ibm.com --output=raw)

echo "Pulling secrets"
# private keys
op get document 'github_rsa' > github_rsa
#op get document 'zsh_private' > zsh_private
op get document '.zsh_history' > .zsh_history

# rm ~/.ssh/github_rsa
# rm ~/.ssh/jump2_rsa
#rm ~/.zsh_private
# rm ~/.zsh_history

ln -s $(pwd)/github_rsa ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa
#ln -s $(pwd)/zsh_private ~/.zsh_private
ln -s $(pwd)/.zsh_history ~/.zsh_history

echo "Done!"
