function init_brew() {
  # If you're on an M# Mac, you need to set the APPLE_SILICON environment variable
  if [[ -z "$APPLE_SILICON" ]]; then
    export HOMEBREW_INSTALL_PATH=/usr/local/opt
    export HOMEBREW_CLI_PATH=/usr/local/bin/brew
  else
    export HOMEBREW_INSTALL_PATH=/opt/homebrew/opt
    export HOMEBREW_CLI_PATH=/opt/homebrew/bin/brew
  fi
  eval $("$HOMEBREW_CLI_PATH" shellenv)
}

function init_dvnm() {
  if [ -f "$HOME/Library/Application Support/dnvm/env" ]; then
    . "$HOME/Library/Application Support/dnvm/env"
  fi
}

function init_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_INSTALL_PATH/nvm/nvm.sh" ] && \. "$HOMEBREW_INSTALL_PATH/nvm/nvm.sh"                                       # This loads nvm
  [ -s "$HOMEBREW_INSTALL_PATH/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_INSTALL_PATH/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
}

function init_pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
}

function init_rbenv() {
  eval "$(rbenv init - zsh)"
}

function init_sdk() {
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec"
  [[ -s "$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec/bin/sdkman-init.sh" ]] && source "$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec/bin/sdkman-init.sh"
}

function init_sqlite() {
  export PATH="$HOMEBREW_INSTALL_PATH/sqlite/bin:$PATH"
  export LDFLAGS="-L$HOMEBREW_INSTALL_PATH/sqlite/lib"
  export CPPFLAGS="-I$HOMEBREW_INSTALL_PATH/sqlite/include"
  # PKG_CONFIG_PATH="$HOMEBREW_INSTALL_PATH/sqlite/lib/pkgconfig"
}

function init_ssh() {
  [[ -z "$SSH_AGENT_PID" ]] && eval $(ssh-agent -s)

  private_keys=("$@")
  public_keys=$(ssh-add -L)

  # Add any SSH keys that haven't been added yet
  for private_key in $private_keys; do
    public_key="$(cat ~/.ssh/$private_key.pub)"
    if [[ "$public_keys" != *"$public_key"* ]]; then
      ssh-add ~/.ssh/$private_key
    fi
  done
}

function init_volta() {
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
}
