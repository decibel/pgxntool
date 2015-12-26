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

safecreate Makefile include pgxntool/base.mk
safecreate .gitignore '.*.swp # Vi swap files

# Compiler output
*.o
*.so
.deps/

# built targets
/sql/*--*
!/sql/*--*--*.sql

# Test artifacts
results/
regression.diffs
regression.out

# Misc
tmp/
.DS_Store
'

mkdir -p sql test src

cd test
safecreate deps.sql '-- Add any test dependency statements here'
ln -s ../pgxntool/test/pgxntool .

echo "If you won't be creating C code then you should:
rmdir src"
