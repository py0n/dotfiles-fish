# name: Informative Vcs
# author: Mariusz Smykula <mariuszs at gmail.com>
#
# - fish 4.3+ での利用を想定して、prompt 実行のたびに変数初期化しないよう整理
# - ユーザーが別の場所で上書きしている場合は尊重（set -q; or set -g）

# -----------------------------
# __fish_git_prompt の表示設定
# -----------------------------
set -q __fish_git_prompt_show_informative_status; or set -g __fish_git_prompt_show_informative_status 1
set -q __fish_git_prompt_hide_untrackedfiles;     or set -g __fish_git_prompt_hide_untrackedfiles 1

set -q __fish_git_prompt_color_branch;            or set -g __fish_git_prompt_color_branch magenta --bold

set -q __fish_git_prompt_showupstream;            or set -g __fish_git_prompt_showupstream "informative"
set -q __fish_git_prompt_char_upstream_ahead;     or set -g __fish_git_prompt_char_upstream_ahead "↑"
set -q __fish_git_prompt_char_upstream_behind;    or set -g __fish_git_prompt_char_upstream_behind "↓"
set -q __fish_git_prompt_char_upstream_prefix;    or set -g __fish_git_prompt_char_upstream_prefix ""

set -q __fish_git_prompt_char_stagedstate;        or set -g __fish_git_prompt_char_stagedstate "●"
set -q __fish_git_prompt_char_dirtystate;         or set -g __fish_git_prompt_char_dirtystate "✚"
set -q __fish_git_prompt_char_untrackedfiles;     or set -g __fish_git_prompt_char_untrackedfiles "…"
set -q __fish_git_prompt_char_conflictedstate;    or set -g __fish_git_prompt_char_conflictedstate "✖"
set -q __fish_git_prompt_char_cleanstate;         or set -g __fish_git_prompt_char_cleanstate "✔"

set -q __fish_git_prompt_color_dirtystate;        or set -g __fish_git_prompt_color_dirtystate blue
set -q __fish_git_prompt_color_stagedstate;       or set -g __fish_git_prompt_color_stagedstate yellow
set -q __fish_git_prompt_color_invalidstate;      or set -g __fish_git_prompt_color_invalidstate red
set -q __fish_git_prompt_color_untrackedfiles;    or set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -q __fish_git_prompt_color_cleanstate;        or set -g __fish_git_prompt_color_cleanstate green --bold


function fish_prompt --description 'Write out the prompt'
    # 直前コマンドの終了ステータス（prompt 内のコマンドで上書きされないよう最初に退避）
    set -l last_status $status

    # cwd の色は root のときだけ変える
    set -l color_cwd $fish_color_cwd
    set -l suffix '%'
    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            end
            set suffix '#'
    end

    # hostname（SSH 接続中なら remote 用の色があれば使う）
    set -l host_color $fish_color_host
    if set -q SSH_CONNECTION
        if set -q fish_color_host_remote
            set host_color $fish_color_host_remote
        end
    end

    set_color $host_color
    echo -n (prompt_hostname)
    set_color normal
    echo -n ':'

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    # VCS（git 等）
    printf '%s ' (__fish_vcs_prompt)

    # エラーなら色を変える
    if test $last_status -ne 0
        set_color $fish_color_error
    end

    echo -n "$suffix "
    set_color normal
end
