function init_brew() {
  apple_silicon="${1:=false}"
  if $apple_silicon; then
    eval $(/opt/homebrew/bin/brew shellenv)
  else
    eval $(/usr/local/bin/brew shellenv)
  fi
}

function init_dvnm() {
  if [ -f "$HOME/Library/Application Support/dnvm/env" ]; then
    . "$HOME/Library/Application Support/dnvm/env"
  fi
}

function init_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
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
  export SDKMAN_DIR="/opt/homebrew/opt/sdkman-cli/libexec"
  [[ -s "/opt/homebrew/opt/sdkman-cli/libexec/bin/sdkman-init.sh" ]] && source "/opt/homebrew/opt/sdkman-cli/libexec/bin/sdkman-init.sh"
}

function init_volta() {
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
}
