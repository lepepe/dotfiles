read -p 'Enter directory: ' dir
read -p 'String or word to find for: ' find_var
read -p 'String or word to replace: ' replace_var
echo

find $dir \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s/$find_var/$replace_var/g"
