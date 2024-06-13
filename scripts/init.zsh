init_brew() {
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

init_dvnm() {
  if [ -f "$HOME/Library/Application Support/dnvm/env" ]; then
    . "$HOME/Library/Application Support/dnvm/env"
  fi
}

init_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_INSTALL_PATH/nvm/nvm.sh" ] && \. "$HOMEBREW_INSTALL_PATH/nvm/nvm.sh"                                       # This loads nvm
  [ -s "$HOMEBREW_INSTALL_PATH/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_INSTALL_PATH/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
}

init_pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
}

init_rbenv() {
  eval "$(rbenv init - zsh)"
}

init_sdk() {
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec"
  [[ -s "$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec/bin/sdkman-init.sh" ]] && source "$HOMEBREW_INSTALL_PATH/sdkman-cli/libexec/bin/sdkman-init.sh"
}

init_sqlite() {
  export PATH="$HOMEBREW_INSTALL_PATH/sqlite/bin:$PATH"
  export LDFLAGS="-L$HOMEBREW_INSTALL_PATH/sqlite/lib"
  export CPPFLAGS="-I$HOMEBREW_INSTALL_PATH/sqlite/include"
  # PKG_CONFIG_PATH="$HOMEBREW_INSTALL_PATH/sqlite/lib/pkgconfig"
}

init_ssh() {
    env=~/.ssh/agent.env

  # Load environment file
  [[ -f $env ]] && source $env >| /dev/null

  # Get agent run state:
  # 0 = agent running with keys
  # 1 = agent running without keys
  # 2 = agent not running
  state=$(
    ssh-add -l >| /dev/null 2>&1
    echo $?
  )

  if [[ ! "$SSH_AUTH_SOCK" ]] || [[ "$state" == 2 ]]; then
    # If the agent is not running, start it
    umask 077
    ssh-agent >| $env
    source $env >| /dev/null
  fi

  private_keys=("$@")
  public_keys=$(ssh-add -L)

  # Add any SSH keys that haven't been added yet
  for private_key in $private_keys; do
    public_key="$(cat ~/.ssh/$private_key.pub)"
    if [[ $public_keys != *$public_key* ]]; then
      ssh-add ~/.ssh/$private_key
    fi
  done
}

init_volta() {
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
}
