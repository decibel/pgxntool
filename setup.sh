#!/bin/sh

set -o errexit -o errtrace -o pipefail
trap 'echo "Error on line ${LINENO}"' ERR

[ -d .git ] || git init

safecreate () {
    file=$1
    shift
    if [ -e $file ]; then
        echo "$file already exists"
    else
        echo "Creating $file"
        echo $@ > $file
        git add $file
    fi
}

safecp () {
    [ $# -eq 2 ] || exit 1
    local src=$1
    local dest=$2
    if [ -e $dest ]; then
        echo $dest already exists
    else
        echo Copying $src to $dest and adding to git
        cp $src $dest
        git add $dest
    fi
}

safecp pgxntool/_.gitignore .gitignore

safecreate Makefile include pgxntool/base.mk

mkdir -p sql test src

cd test
safecreate deps.sql '-- Add any test dependency statements here'
ln -s ../pgxntool/test/pgxntool .
git add pgxntool

echo "If you won't be creating C code then you should:

rmdir src

If everything looks good then

git commit -am 'Initial commit'"
