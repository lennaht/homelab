cd kubernetes/bootstrap

# Create age-key secret in cluster and save sops-encrypted file
if [ ! -f "age-key.sops.yaml" ]
then
    kubectl create secret generic sops-age \
        -n flux-system \
        --from-file=age.agekey=../../age.agekey \
        -o yaml \
        | sops -e \
        --input-type yaml \
        --output-type yaml \
        --encrypted-regex "^(data|stringData)" \
        /dev/stdin > age-key.sops.yaml
else
    sops --decrypt age-key.sops.yaml | kubectl apply -f -
fi

#CREATE git key secret
if [ ! -f "git-auth.sops.yaml" ]
then
    secret="$(
        flux create secret git git-auth \
            --url=$GIT_REPO_URL \
            --private-key-file=$GIT_PRIVATE_KEYFILE \
            --export
    )"
    echo "$secret" | kubectl apply -f -
    echo "$secret" | sops -e \
        --input-type yaml \
        --output-type yaml \
        --encrypted-regex "^(data|stringData)" \
        /dev/stdin > git-auth.sops.yaml
else
    sops --decrypt git-auth.sops.yaml | kubectl apply -f -
fi