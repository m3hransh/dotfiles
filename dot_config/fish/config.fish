set fish_greeting
set PATH $PATH /usr/local/go/bin
set PATH $PATH /home/mehran/go/bin
set PATH $PATH /home/mehran/.cargo/bin
set PATH $PATH /home/mehran/.yarn/bin
abbr -a ws 'sudo systemctl start windscribe'
abbr -a wind 'windscribe connect'
set TERMINAL (which nvim)
set EDITOR (which nvim) 
#-----------------------------------------------------
#Aliases
#-------------------------------------------------------
alias nn="nvim"
# alias lf lfrun
alias color "colorscript random"
alias ll "exa --icons -l -g"
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# PATH
set -U fish_user_paths $HOME/.local/share/gem/ruby/3.0.0/bin



starship init fish | source

# TokyoNight Color Palette
    set -l foreground c0caf5
    set -l selection 364A82
    set -l comment 565f89
    set -l red f7768e
    set -l orange ff9e64
    set -l yellow e0af68
    set -l green 9ece6a
    set -l purple 9d7cd8
    set -l cyan 7dcfff
    set -l pink bb9af7
    
    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment
    
    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
