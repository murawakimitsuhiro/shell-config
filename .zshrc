eval "$(rbenv init -)"

#zsh補完を有効化
fpath=(/usr/local/share/zsh-completions $fpath)

function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search

# キーバインドをvimに
bindkey -v

# コマンドミスを修正
setopt correct

# ディレクトリ名のみでcdを実行
setopt auto_cd

# pathのブックマーク(cd ~hogeで移動)
hash -d doc=/Users/murawakimitsuhiro/Documents
hash -d ng=/Users/murawakimitsuhiro/Documents/_Angular_Projects
hash -d xcode=/Users/murawakimitsuhiro/Documents/_Xcode_Project
hash -d unity=/Users/murawakimitsuhiro/Documents/_Unity_Project
hash -d node=/Users/murawakimitsuhiro/Documents/_Nodejs_Project
hash -d of=/Users/murawakimitsuhiro/Documents/_Xcode_Project/SDK_Library/of_v0.9.8_osx_release
hash -d rails=/Users/murawakimitsuhiro/Documents/rails_Project
hash -d docker=/Users/murawakimitsuhiro/Documents/docker

# エイリアス
alias l='ls -la -G'
alias lst='ls -ltr'
alias la='ls -la'
alias ll='ls -l'
alias so='source'
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
alias dc='docker-compose'
alias pwdcp='pwd | pbcopy' #カレントディレクトリの絶対パスをコピー
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

# gitignoreを追加
alias ignoreSwift='cp /Users/murawakimitsuhiro/Documents/shell_script/gitignore/Swift.gitignore .gitignore'

# podinitをする(よく使うものをあらかじめ入れてある)
alias podinit='cp /Users/murawakimitsuhiro/Documents/shell_script/static/Podfile Podfile'

#sfc
alias sshsfc='ssh t17792mm@webedit.sfc.keio.ac.jp'

# cdしたら自動で pwdとls -la を実行する
chpwd() {
  pwd $2 && ls -l $1
}

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/zsh_autocomplete


# tp <任意の数字>で透明度の変更を可能に
case ${OSTYPE} in
  darwin*)
    function tp() {
      if [ $# -ne 1 ] ; then
        echo "    invalid argument."
        echo "    use 0 - 9"
      else
        echo "
          tell application \"iTerm\"
            activate -- make window active
            tell current session of current window
              set transparency to $1/10
            end tell
          end tell
        " | /usr/bin/osascript -
      fi
    }
    ;;
esac 

[[ -s "/Users/murawakimitsuhiro/.gvm/scripts/gvm" ]] && source "/Users/murawakimitsuhiro/.gvm/scripts/gvm"



############## oh-my-zsh用の設定 #################


# Path to your oh-my-zsh installation.
export ZSH=/Users/murawakimitsuhiro/.oh-my-zsh
export PATH=$PATH:/extlib/gems/bin/


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
#export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/.zsh.d/z.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
