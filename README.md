# dotfiles

This repo uses [chezmoi](https://www.chezmoi.io/) to manage my macOS/Linux dotfiles and packages.

## Pre-reqs

- Install [homebrew](https://brew.sh/):
  > If on linux, you may need to install some dependencies, e.g.:
  > ```bash
  > apt install curl git build-essential
  > ... or ...
  > yum install curl git gcc
  > ```
  > 

  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- Install [chezmoi](https://www.chezmoi.io/install/)
  ```bash
  brew install chezmoi
  ```

- Generate and set an access token for Bitwarden Secrets
  - Log in to [Secrets Manager](https://vault.bitwarden.com/#/sm)
  - Create or select an existing Machine account and associate it with the `chezmoi` project
  - Create an access token for the account, and paste it after running the following:
    ```bash
    chezmoi secret keyring set --service bws --user chezmoi
    Value: xxxxxxxx
    ```

- Fetch and initialise the config:
  ```bash
  chezmoi init dsbibby
  ```

- Check what will be changed
  ```bash
  chezmoi diff
  ```

- Apply the changes
  ```bash
  chezmoi apply
  ```
