# solarized 関数が存在しないなら何もしない（起動時のエラー回避）
type -q solarized; or exit

# NO_SOLARIZED_TERM が定義されていれば “端末側で色管理する” 想定で引数なし
# そうでなければ fish 側で solarized を有効化（元の挙動を踏襲）
if set -q NO_SOLARIZED_TERM
    solarized
else
    solarized 1
end
