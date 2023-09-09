## How to bootstrap flux

### Prepare the environment and create secrets
Run the `prepare-env.sh` script in your current terminal using
```bash
source prepare-env.sh
```
This will create a new age key `age.agekey` in this directory and set some environment variables. It will also create a new ssh-key `deploy-key`. The public key `deploy-key.pub` has to be set as deploy key with push privileges in the GitHub repository.

The environment-variable `GIT_REPO_URL` is set to this repository by default and can afterwards be changed with
```bash
export GIT_REPO_URL=ssh://git@github.com/<user>/<repo>
```

### Install flux cd
Run the following command to install the flux cd manifests to your cluster:
```bash
kubectl apply --server-side --kustomize kubernetes/bootstrap
```

### Inject secrets into the cluster
Next we have to inject our secrets into the cluster. Run the script `create-secrets.sh`. It will create secrets based on the environment variables configured beforehand. The secrets are injected into the cluster and saved as SOPS encrypted files.

### Connect the Git Repository
Now that flux is installed and the secrets are in place, we can create the GitRepository object and thus make flux sync our cluster to the repo.
```bash
kubectl apply --server-side --kustomize kubernetes/base/flux-system
```

Now flux should automatically pull changes made to the repository and change the cluster accordingly.