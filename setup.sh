#!/bin/sh

safecreate () {
    file=$1
    shift
    if [ -x $file ]; then
        echo "$file already exists"
    else
        echo "Creating $file"
        echo $@ > $file
    fi
}

cp -n pgxntool/_.gitignore .gitignore

safecreate Makefile include pgxntool/base.mk

mkdir -p sql test src

cd test
safecreate deps.sql '-- Add any test dependency statements here'
ln -s ../pgxntool/test/pgxntool .

echo "If you won't be creating C code then you should:
rmdir src"
