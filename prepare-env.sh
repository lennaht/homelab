if [ ! -f "age.agekey" ]
then
    age-keygen > age.agekey
fi

export SOPS_AGE_KEY=$(cat age.agekey)
export SOPS_AGE_RECIPIENTS=$(cat age.agekey | grep public | cut -d " " -f4)

export GIT_REPO_URL="ssh://git@github.com/lennaht/homelab"

if [ ! -f "deploy-key" ]
then
    ssh-keygen -t rsa -b 4096 -f deploy-key
fi
export GIT_PRIVATE_KEYFILE="$(pwd)/deploy-key"