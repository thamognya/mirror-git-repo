# Git Mirror Action

A GitHub Action for [mirroring a git repository](https://help.github.com/en/articles/duplicating-a-repository#mirroring-a-repository-in-another-location) to another location via SSH.

## Inputs

### `source-repo`

**Required** SSH URL of the source repo.

### `destination-repo`

**Required** SSH URL of the destination repo.

## Environment variables

`SSH_PRIVATE_KEY`: Create a [SSH key](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) **without** a passphrase which has access to both repositories. On GitHub you can add the public key as [a deploy key to the repository](https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys). GitLab has also [deploy keys with write access](https://docs.gitlab.com/ee/user/project/deploy_keys/) and for any other services you may have to add the public key to your personal account.  
Store the private key as [an encrypted secret](https://docs.github.com/en/actions/reference/encrypted-secrets) and use it in your workflow as seen in the example workflow below.

`SSH_KNOWN_HOSTS`: Known hosts as used in the `known_hosts` file. *StrictHostKeyChecking* is disabled in case the variable isn't available.

If you added the private key or known hosts in an [environment](https://docs.github.com/en/actions/reference/environments) make sure to [reference the environment name in your workflow](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idenvironment) otherwise the secret is not passed to the workflow.

## Example workflow

```yml
name: mirror to repo

on: 
  schedule:
  - cron: '*/5 * * * *'

# Ensures that only one mirror task will run at a time.
concurrency:
  group: mirror-git-repo

jobs:
  mirror-git-repo:
    runs-on: ubuntu-latest
    steps:
      - uses: ThamognyaKodi/mirror-git-repo@0.0.1
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
          EMAIL: ${{ github.event.pusher.email }}
          NAME: ${{ github.event.pusher.name }}
          DRY_RUN: false
        with:
          source-repo: "git@_some_provider_:_user_name_/_repo_name_.git"
          destination-repo: "git@_some_provider_which_you_have_ssh_access_:_user_name_/_repo_name_.git"
```

## Docker

```sh
docker run --rm -e "SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)" $(docker build -q .) "$SOURCE_REPO" "$DESTINATION_REPO"
```


## License

This work is dual-licensed under MIT and GPL 3.0 (or any later version). You have to comply to both of them if you want to use this work.

`SPDX-License-Identifier: MIT AND GPL-3.0-or-later`

You can find the licenses in the licenses folder.
