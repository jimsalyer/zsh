add_ssh_keys() {
  private_keys=(github/personal_ed github/wwt_ed gitlab/wwt_ed)
  public_keys=$(ssh-add -L)

  # Add any SSH keys that haven't been added yet
  for private_key in $private_keys; do
    public_key="$(cat ~/.ssh/$private_key.pub)"
    if [[ "$public_keys" != *"$public_key"* ]]; then
      ssh-add "~/.ssh/$private_key"
    fi
  done
}
