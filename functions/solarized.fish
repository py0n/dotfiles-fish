# Defined in /tmp/fish.2XF7ke/solarized.fish @ line 1
function solarized
	# https://github.com/ithinkihaveacat/dotfiles/blob/master/fish/solarized.fish
	# http://ethanschoonover.com/solarized#the-values

	if test -z "$NO_SOLARIZED_TERM"
		# Use these settings if you've applied a Solarized theme to your terminal (for
		# example, if "ls -G" produces Solarized output). i.e. if "blue" is #268bd2, not
		# whatever the default is. (See "../etc/Solarized Dark.terminal" for OS X.)

		set base03  "--bold black"
		set base02  "black"
		set base01  "--bold green"
		set base00  "--bold yellow"
		set base0   "--bold blue"
		set base1   "--bold cyan"
		set base2   "white"
		set base3   "--bold white"
		set yellow  "yellow"
		set orange  "--bold red"
		set red     "red"
		set magenta "magenta"
		set violet  "--bold magenta"
		set blue    "blue"
		set cyan    "cyan"
		set green   "green"
	else
		# Use these settings if your terminal supports term256 and your terminal hasn't
		# been configured with a Solarized theme.i.e. if "blue" is the default blue, not
		# Solarized blue.

		set base03  002b36
		set base02  073642
		set base01  586e75
		set base00  657b83
		set base0   839496
		set base1   93a1a1
		set base2   eee8d5
		set base3   fdf6e3
		set yellow  b58900
		set orange  cb4b16
		set red     dc322f
		set magenta d33682
		set violet  6c71c4
		set blue    268bd2
		set cyan    2aa198
		set green   859900
	end

	# Used by fish's completion; see
	# http://fishshell.com/docs/2.0/index.html#variables-color

	set -g fish_color_normal      $base0
	set -g fish_color_command     $base0
	set -g fish_color_quote       $cyan
	set -g fish_color_redirection $base0
	set -g fish_color_end         $base0
	set -g fish_color_error       $red
	set -g fish_color_param       $blue
	set -g fish_color_comment     $base01
	set -g fish_color_match       $cyan
	set -g fish_color_search_match "--background=$base02"
	set -g fish_color_operator    $orange
	set -g fish_color_escape      $cyan

	# Used by fish_prompt

	set -g fish_color_hostname    $cyan
	set -g fish_color_cwd         $yellow
	set -g fish_color_git         $green
end
