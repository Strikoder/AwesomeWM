eval "$(starship init zsh)"
cd /media/Github/
colorscript random
export PATH=/usr/local/cuda-12.3/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64:$LD_LIBRARY_PATH
export PATH="$PATH:/home/user/bin"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/strikoder/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/strikoder/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/strikoder/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/strikoder/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias ju='touch file.ju.py'
source activate nvim
