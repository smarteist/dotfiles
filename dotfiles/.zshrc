# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

myip(){ curl -s https://1.1.1.1/cdn-cgi/trace | awk -F= '/^ip=/{print $2}'; }
myloc(){ curl -s https://1.1.1.1/cdn-cgi/trace | awk -F= '/^loc=/{print $2}'; }
mycolo(){ curl -s https://1.1.1.1/cdn-cgi/trace | awk -F= '/^colo=/{print $2}'; }
randpw(){ LC_ALL=C tr -dc 'A-Za-z0-9!@#$%&*()-_=+[]{}:;,.?/<>~' < /dev/urandom | head -c ${1:-16}; echo; }
randhex(){ head -c ${1:-16} /dev/urandom | od -An -tx1 | tr -d ' \n'; echo; }
b64e(){ printf "%s" "${*:-$(cat)}" | base64 | tr -d '\n'; echo; }
b64d(){ printf "%s" "${*:-$(cat)}" | base64 --decode; echo; }
gpgenc() {
  (( $# )) || { echo "Usage: gpgenc FILE [FILE2 ...]"; return 1; }
  local -a keys=(${(f)"$(gpg --list-keys --with-colons | awk -F: '$1=="pub"{k=$5} $1=="uid"{print k "|" $10}')"})
  local i=0 idx recipient file
  (( ${#keys[@]} )) || { echo "No public keys found"; return 1; }
  for line in "${keys[@]}"; do
    printf '%d) %s\n' "$i" "${line#*|}"
    ((i++))
  done
  read -r "idx?Select key index: "
  [[ $idx == <-> && $idx -ge 0 && $idx -lt ${#keys[@]} ]] || { echo "Invalid selection"; return 1; }
  recipient="${keys[$((idx+1))]%%|*}"
  for file in "$@"; do
    [ -f "$file" ] && gpg --yes --batch --trust-model always --output "$file.gpg" --encrypt --recipient "$recipient" "$file"
  done
}
gpgdec() {
  (( $# )) || { echo "Usage: gpgdec FILE [FILE2 ...]"; return 1; }
  for file in "$@"; do
    [ -f "$file" ] || { echo "Skip missing file: $file"; continue; }
    gpg --yes --batch --output "${file%.gpg}" --decrypt "$file"
  done
}


export JAVA_HOME="$(readlink -f /usr/bin/java | sed 's:/bin/java$::')"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
#export PATH="$PATH:$HOME/Android/flutter/bin/:/opt/trelliscli/:$JAVA_HOME/bin"
