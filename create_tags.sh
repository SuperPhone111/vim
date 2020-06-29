#! /bin/bash

function usage()
{
    echo
    echo "Usage:"
    echo "  $(basename $0) kernel"
    echo
}

tag_type=$1

if [ "$tag_type" == "kernel" ]; then
    rm -rf gtags.files
    find . -type d                  \
        \(                          \
        -path ./.git -o             \
        -path ./Documentation       \
        \)                          \
        -prune -o                   \
        -type f                     \
        \(                          \
        -name "*.[chxsS]" -o        \
        -name "*.cpp"     -o        \
        -name ".dts"                \
        \)                          \
        -print > gtags.files

        echo "Create kernel tags"
fi

export GTAGSFORCECPP=1

#create tags
if [ -f ./gtags.files ]; then
    gtags -f ./gtags.files
else
    gtags
fi

