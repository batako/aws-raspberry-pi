# Update
sudo yum update -y

# Change time zone to Asia/Tokyo
timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=ja_JP.utf8

# Change the color of the prompt
sudo echo "export PS1='\[\033[01;36m\]\u@\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /etc/profile
sudo echo "export PS1='\[\033[01;31m\]\u@\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '" >> /root/.bashrc

# zsh
sudo yum install -y \
  git \
  util-linux-user \
  zsh \
;
echo /usr/bin/zsh | sudo chsh $(whoami)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
mkdir $HOME/.local
git clone https://github.com/b4b4r07/enhancd.git $HOME/.local/enhancd
git clone https://github.com/junegunn/fzf.git $HOME/.local/fzf
echo y | $HOME/.local/fzf/install
cat > $HOME/.zshrc << 'EOF'
# ------------------------------
# 定数定義
# ------------------------------

# Zsh
export ZSH_THEME="robbyrussell"
export RPROMPT="%m"

# Oh My Zsh
export ZSH=~/.oh-my-zsh


# ------------------------------
# 設定
# ------------------------------

# 補完機能有効化
autoload -Uz compinit && compinit

# Oh My Zsh
plugins=(
  git
  # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  zsh-autosuggestions
  # git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
  zsh-history-substring-search
  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  zsh-syntax-highlighting
  # git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  zsh-completions
)
source ~/.oh-my-zsh/oh-my-zsh.sh

# enhancd
# git clone https://github.com/b4b4r07/enhancd.git ~/.local/enhancd
source ~/.local/enhancd/init.sh

# fzf
# git clone https://github.com/junegunn/fzf.git ~/.local/fzf
# echo y | ~/.local/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ------------------------------
# fzf の関数
# ------------------------------

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
EOF

# tig
sudo yum install -y \
  automake \
  gcc \
  gcc-c++ \
  make \
  ncurses-devel \
;
git clone https://github.com/jonas/tig.git
cd tig
sudo yum provides \*/curses.h
./autogen.sh
LDFLAGS=-L/usr/lib/ncursesw CPPFLAGS=-I/usr/include/ncursesw ./configure
make prefix=/usr/local
sudo make install prefix=/usr/local
cd ../
rm -fr tig

# Docker
sudo yum install -y docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo systemctl start docker

# Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.28.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
