export ZSH=$HOME/.zsh
#HISTFILE=$ZSH/.zsh_history
bindkey -e

export STARSHIP_CONFIG=~/.config/starship.toml

export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
export PATH=$PATH:~/.config/emacs/bin/
# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath' # In case a command is not found, try to find the package that has it

function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null ; then
            arch+=("${pkg}")
        else 
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function oo()
{
  cd ~/My-Vault/
  nvim
}



# Helpful aliases
# alias  adb='~/Downloads/platform-tools/adb'
# alias  fastboot='~/Downloads/platform-tools/fastboot'
alias  lpd='~/.scripts/manual-duplexer.sh'
alias  tkw='tmux kill-window -a'
alias  tks='tmux kill-session -a'
alias  tkp='tmux kill-pane -a'
alias  c='clear' # clear terminal
alias  cdh='cd ~' # clear terminal
alias  sudo='doas' # clear terminal
alias  md='mkdir' # clear terminal
alias  ls='eza -lh  --icons=auto' # long list
alias l='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias un='$aurhelper -Rns' # uninstall package
alias in='$aurhelper -S' # install package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor
alias zhconfig="nvim ~/.zshrc" 
alias hyconfig="nvim ~/.config/hypr/hyprland.conf" 
alias rg="rg --hyperlink-format=kitty"
alias e="nvim"
alias ocr="/home/noon/.config/sioyek/ocr.py"
# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# bun completions
[ -s "/home/noon/.bun/_bun" ] && source "/home/noon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export SSH_ASKPASS="/usr/bin/ksshaskpass"
export SSH_ASKPASS_REQUIRE=prefer
export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR="/usr/bin/nvim"
eval "$(zoxide init zsh --cmd cd)"

# Tmux auto session
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

# FZF
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# Unbind original Ctrl+T
bindkey -r '^T'
bindkey '^F' fzf-file-widget
# Bind Ctrl+F to the fzf-file-widget
export FZF_CTRL_F_COMMAND="${FZF_DEFAULT_COMMAND} --exclude .cache"
export FZF_CTRL_F_OPTS="${FZF_DEFAULT_OPTS}"

# Unbind the default Ctrl-T and bind Ctrl-F to file search
bindkey -r '^T'  # Unbind Ctrl-T
bindkey '^F' fzf-file-widget

# Customize the command used for file search
export FZF_CTRL_F_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_F_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null'"


# Quick cd using fzf
fcd() {
  cd "$(fd -type d | fzf --preview 'tree -C {} | head -200' --preview-window 'up:60%')"
}

stty -ixon
# Find and edit using fzf
# fe() {
#   nvim "$(find -type f | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
# }

fe() {
  local file
  file=$(fd --type f --hidden | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
  [[ -n "$file" ]] && nvim "$file"
}


bindkey '^[f' fe-widget

fe-widget() {
  zle -I # Refreshes the line editor to avoid glitches
  fe
}
zle -N fe-widget

frg() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

pe() {
  local file
  file=$(find ~/.password-store -type f -name '*.gpg' | sed "s|^$HOME/.password-store/||;s|\.gpg$||" | fzf)
  if [ -n "$file" ]; then
    pass edit "$file"
  fi
}

# Find and remove files with fzf
frm() {
  # Use `find` to list files and directories, and pipe them to `fzf` for selection
  selected=$(find . -type f -o -type d 2>/dev/null | fzf -m)
  
  # Check if any selection was made
  if [[ -n "$selected" ]]; then
    # Echo the files or directories that will be deleted
    echo "Deleting the following files or directories:"
    echo "$selected"
    
    # Use `xargs` to safely pass selected files/directories to `rm -rf`
    echo "$selected" | xargs -d '\n' rm -rf
  else
    echo "No files or directories selected."
  fi
}

## Define the widget function for the custom key binding
#fzf-file-widget() {
#  FZF_DEFAULT_COMMAND="$FZF_CTRL_F_COMMAND" fzf "$FZF_CTRL_F_OPTS"
#}

# Man
export MANPAGER='nvim -c "setlocal signcolumn=no" +Man!'

echo -ne "\033[6 q"
bindkey -r '^[w'
bindkey '^[w' forward-word
bindkey -r "^U"
bindkey "^U" backward-kill-line


open_yazi ()
{
  zle -I
  y
}
zle -N open_yazi
bindkey "^O" open_yazi



aur_manager() {
    local action packages confirm

    action=$(echo -e "Install\nRemove" | fzf --prompt="Choose an action: " --height=10 --border --reverse)

    case "$action" in
        "Install")
            packages=$(yay -Ssq | fzf --multi --prompt="Select packages to install: " --height=20 --border --reverse | tr '\n' ' ')
            if [[ -z "$packages" ]]; then
                echo "❌ No package selected. Aborting."
                return 1
            fi
            
            echo "🔹 Packages to install: $packages"
            read -q "confirm?Proceed with installation? (y/n) "
            echo ""  # Move to a new line after read
            
            if [[ $confirm == "y" ]]; then
                yay -S --noconfirm $=packages || echo "❌ Installation failed!"
            else
                echo "❌ Installation cancelled."
            fi
            ;;
        
        # "Update")
        #     echo "🔄 Updating all installed packages..."
        #     yay -Syu || echo "❌ Update failed!"
        #     ;;
        
        "Remove")
            packages=$(yay -Qq | fzf --multi --prompt="Select packages to remove: " --height=20 --border --reverse | tr '\n' ' ')
            if [[ -z "$packages" ]]; then
                echo "❌ No package selected. Aborting."
                return 1
            fi

            echo "🔹 Packages to remove: $packages"
            read -q "confirm?Proceed with removal? (y/n) "
            echo ""

            if [[ $confirm == "y" ]]; then
                yay -Rns --noconfirm $=packages || echo "❌ Removal failed!"
            else
                echo "❌ Removal cancelled."
            fi
            ;;
        
        *)
            echo "❌ No valid option selected."
            return 1
            ;;
    esac
}

aur-widget() {
  zle -I # Refreshes the line editor to avoid glitches
  aur_manager
}
zle -N aur_widget
zle -N aur_manager
bindkey "^[a" aur_manager


# Function to manage Arch Linux packages using fzf
pm() {
    # Define colors for better visibility
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color

    # Check if fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo -e "${RED}Error: fzf is not installed. Please install it with 'pacman -S fzf'.${NC}"
        return 1
    fi

    # Check if paru or yay is installed
    AUR_HELPER=""
    if command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    fi

    # Step 1: Choose operation mode
    local MODE=$(echo -e "Manage installed packages\nSearch and install new packages" | 
                fzf --prompt="Select operation mode: " --height=15% --layout=reverse --border)

    if [[ -z "$MODE" ]]; then
        echo -e "${RED}Operation cancelled.${NC}"
        return 0
    fi

    if [[ "$MODE" == "Manage installed packages" ]]; then
        echo -e "${BLUE}Fetching installed packages...${NC}"
        
        local PACKAGES=$(pacman -Q | awk '{print $1}' | 
                        fzf --prompt="Select packages: " --multi --preview="pacman -Qi {1} 2>/dev/null || echo 'Not installed'" \
                            --height=80% --layout=reverse --border)

        if [[ -z "$PACKAGES" ]]; then
            echo -e "${RED}No packages selected.${NC}"
            return 0
        fi

        # Convert selected packages into an array
        pkg_array=(${(f)PACKAGES})

        # Choose action
        local OPERATION=$(echo -e "Update\nRemove\nGet information" | 
                        fzf --prompt="Select operation: " --height=15% --layout=reverse --border)

        if [[ -z "$OPERATION" ]]; then
            echo -e "${RED}Operation cancelled.${NC}"
            return 0
        fi

        case "$OPERATION" in
            "Update")
                echo -e "${GREEN}Updating selected packages:${NC}"
                for pkg in "${pkg_array[@]}"; do
                    echo -e " - $pkg"
                done

                read "confirm?Proceed with update? [y/N] "
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    sudo pacman -S --needed "${pkg_array[@]}"
                else
                    echo -e "${RED}Update cancelled.${NC}"
                fi
                ;;
            "Remove")
                echo -e "${RED}Removing selected packages:${NC}"
                for pkg in "${pkg_array[@]}"; do
                    echo -e " - $pkg"
                done

                read "confirm?Are you sure you want to remove these packages? [y/N] "
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    sudo pacman -R "${pkg_array[@]}"
                else
                    echo -e "${RED}Removal cancelled.${NC}"
                fi
                ;;
            "Get information")
                for pkg in "${pkg_array[@]}"; do
                    echo -e "${BLUE}Information for $pkg:${NC}"
                    pacman -Qi "$pkg"
                    echo ""
                    read -k1 "Press any key to continue..."
                done
                ;;
        esac
    else
        # Search for packages to install
        echo -e "${BLUE}Enter a search term (leave empty to browse):${NC}"
        read QUERY

        local SEARCH_RESULT=""
        if [[ -z "$AUR_HELPER" ]]; then
            # Search only in official repos
            SEARCH_RESULT=$(pacman -Ss "$QUERY" | sed 'N;s/\n/ /' | 
                            fzf --multi --prompt="Select packages to install: " \
                                --preview="pacman -Si \$(echo {} | awk '{print \$1}' | sed 's/^.*\\///')" \
                                --height=80% --layout=reverse --border)
        else
            # Use AUR helper to search
            SEARCH_RESULT=$($AUR_HELPER -Ss "$QUERY" | sed 'N;s/\n/ /' | 
                            fzf --multi --prompt="Select packages to install: " \
                                --preview="$AUR_HELPER -Si \$(echo {} | awk '{print \$1}' | sed 's/^.*\\///')" \
                                --height=80% --layout=reverse --border)
        fi

        if [[ -z "$SEARCH_RESULT" ]]; then
            echo -e "${RED}No packages selected.${NC}"
            return 0
        fi

        # Extract package names
        install_pkg_array=()
        while IFS= read -r line; do
            pkg_name=$(echo "$line" | awk '{print $1}' | sed 's/^.*\///')
            install_pkg_array+=("$pkg_name")
        done <<< "$SEARCH_RESULT"

        # Install selected packages
        if [[ -n "$AUR_HELPER" ]]; then
            echo -e "${GREEN}Installing packages using $AUR_HELPER:${NC}"
            for pkg in "${install_pkg_array[@]}"; do
                echo -e " - $pkg"
            done

            read "confirm?Proceed with installation? [y/N] "
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                $AUR_HELPER -S "${install_pkg_array[@]}"
            else
                echo -e "${RED}Installation cancelled.${NC}"
            fi
        else
            echo -e "${GREEN}Installing packages from official repos:${NC}"
            for pkg in "${install_pkg_array[@]}"; do
                echo -e " - $pkg"
            done

            read "confirm?Proceed with installation? [y/N] "
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                sudo pacman -S "${install_pkg_array[@]}"
            else
                echo -e "${RED}Installation cancelled.${NC}"
            fi
        fi
    fi
}

# ~/.zshrc

if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"



### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Zinit Installed Packages
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
##zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
