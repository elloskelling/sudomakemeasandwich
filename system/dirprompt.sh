# turns on the ZSH directory history stack and...
# ...puts the directory stack in a fixed-position bar on top of the terminal
# source this from .zshrc

setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
setopt PROMPT_SUBST	     	   # enable full expansions in prompt

autoload -U compinit && compinit   # load + start completion
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

export _qdirPS1=$PS1
# unset this to turn off path truncation. Works dynamically so you can toggle it in a running shell
export _qdirTRUNCATE=1
get_qdirs() { # ennumerate and pretty-print the dirs and fill the column width
	export _qdirCOLS=$COLUMNS	
	echo -ne "\e[90;1;3m";
	if [[ -z $_qdirTRUNCATE ]]; then
		echo -ne $(d | perl -0777 -pe 's/(^)/$1/g;s/\t/\:\ /g;s/\n/\ /g;$_=sprintf "%-$ENV{_qdirCOLS}s", $_;$_=substr($_,0,$ENV{_qdirCOLS});s/(\d+:)/\e[90;1;3m$1\e[2;3;38;5;238m/g')
	else
		echo -ne $(d | perl -0777 -pe 's/(^)/$1/g;s/\t/\:\ /g;s/(\S{10})\S*(\S{10})\b/$1…$2/g;s/\n/\ /g;$_=sprintf "%-$ENV{_qdirCOLS}s", $_;$_=substr($_,0,$ENV{_qdirCOLS});s/(\d+:)/\e[90;1;3m$1\e[2;3;38;5;238m/g')
	fi
}
PS1=$_qdirPS1$'%{\e[s\e[H$(get_qdirs)\e[u%}' 
