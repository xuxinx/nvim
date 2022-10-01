set -e

# These were found from https://github.com/sheerun/vim-polyglot. 
# I only need the *indent* configuration, so they are here.
# Thanks to these authors for their efforts!
files=(
https://raw.githubusercontent.com/othree/html5.vim/master/indent/html.vim
https://raw.githubusercontent.com/pangloss/vim-javascript/master/indent/javascript.vim
https://raw.githubusercontent.com/HerringtonDarkholme/yats.vim/master/indent/typescript.vim
https://raw.githubusercontent.com/HerringtonDarkholme/yats.vim/master/indent/typescriptreact.vim
https://raw.githubusercontent.com/posva/vim-vue/master/indent/vue.vim
)

for f in ${files[@]}
do
    if (curl -o /dev/null -Isf $f); then
        curl -Os $f
        echo "$f fetched."
    else
        echo "$f does not exist."
        exit 1
    fi
done
