# ------------------------------------------------------------
# テーマ / 色設定（fish 4.3+ 対応）
#
# - fish 4.3 以降では fish_color_* / fish_pager_color_* は
#   universal ではなく global 変数として管理される
# - upgrade 時に生成される fish_frozen_theme.fish を使わず、
#   明示的にここでテーマを定義する方針
#
# NOTE:
#   - 色を変更したい場合はこのブロックだけ編集すればよい
#   - 他の場所で fish_color_* を set しないこと
# ------------------------------------------------------------
#
# CAUTION:
#   fish_frozen_theme.fish が存在する場合は削除または無効化すること。
#   両方が同時に存在すると色設定が分かりにくくなる。

# ---- コマンドライン / プロンプト関連 ----
set --global fish_color_cancel -r
set --global fish_color_cwd_root red
set --global fish_color_history_current --bold
set --global fish_color_host_remote yellow
set --global fish_color_selection white --bold --background=brblack
set --global fish_color_status red
set --global fish_color_user brgreen
set --global fish_color_valid_path --underline

# ---- pager（補完候補表示）関連 ----
set --global fish_pager_color_completion
set --global fish_pager_color_description B3A06D yellow
set --global fish_pager_color_prefix white --bold --underline
set --global fish_pager_color_progress brwhite --background=cyan
set --global fish_pager_color_selected_background -r
