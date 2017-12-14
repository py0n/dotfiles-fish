# Defined in /tmp/fish.HUJl4K/solarized.fish @ line 2
function solarized --argument is_solarized_term
	# https://github.com/ithinkihaveacat/dotfiles/blob/master/fish/solarized.fish
	# http://ethanschoonover.com/solarized#the-values

	# SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      RGB         HSB
	# --------- ------- ---- -------  ----------- ---------- ----------- -----------
	# base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
	# base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
	# base01    #586e75 10/7 brgreen  240 #585858 45 -07 -07  88 110 117 194  25  46
	# base00    #657b83 11/7 bryellow 241 #626262 50 -07 -07 101 123 131 195  23  51
	# base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
	# base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
	# base2     #eee8d5  7/7 white    254 #e4e4e4 92 -00  10 238 232 213  44  11  93
	# base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
	# yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
	# orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
	# red       #d30102  1/1 red      124 #af0000 45  70  60 211   1   2   0  99  83
	# magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
	# violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
	# blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
	# cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
	# green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

	set base03  "brblack"
	set base02  "black"
	set base01  "brgreen"
	set base00  "bryellow"
	set base0   "brblue"
	set base1   "brcyan"
	set base2   "white"
	set base3   "brwhite"
	set yellow  "yellow"
	set orange  "brred"
	set red     "red"
	set magenta "magenta"
	set violet  "brmagenta"
	set blue    "blue"
	set cyan    "cyan"
	set green   "green"

	# Used by fish's completion; see
	# http://fishshell.com/docs/2.0/index.html#variables-color

	set -g fish_color_normal         $base0                 # the default colot
	set -g fish_color_command        $base0                 # the color for command
	set -g fish_color_quote          $cyan                  # the color for quoted blocks of text
	set -g fish_color_redirection    $base0                 # the color for IO redirections
	set -g fish_color_end            $base0                 # the color for process separators like ';' and '&'
	set -g fish_color_error          $red                   # the color for used to highlight potential errors
	set -g fish_color_param          $blue                  # the color for regular command parameters
	set -g fish_color_comment        $base01                # the color used for code comment
	set -g fish_color_match          $cyan                  # the color used to highlight matching parenthesis
	set -g fish_color_search_match   "--background=$base02" # the color used to highlight history search matches
	set -g fish_color_operator       $orange                # the color for parameters expansion operators like '*' and '~'
	set -g fish_color_escape         $cyan                  # the color used to highlight character escape like '\n' and '\x70'
	set -g fish_color_cwd            $yellow                # the color used for the current working directory in the default prompt
	set -g fish_color_autosuggestion $orange                # the color use for autosuggestion
	# Used by fish_prompt
#	set -g fish_color_user           $yellow                # the color used to print the current username in some of fish default prompt
	set -g fish_color_host           $cyan                  # the color used to print the current host system in some of fith default prompt
#	set -g fish_color_cancel         $red                   # the color for the '^C' indicator on a canceled command
	# Used by Git
	set -g fish_color_git            $green
end
