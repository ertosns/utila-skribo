#!/bin/sh

#editor have to perform following script upon file change.

cd $1
rm -rf TAGS
for file in $(find $1 -type f -regex ".+\\.c?h?S?\(cpp\)?\(cxx\)?\(cc\)?\(hpp\)?\(hxx\)?\(hh\)?\(rb\)?\(go\)?\(js\)?\(py\)?\(java\)?" ); do
    echo "adding $file"
    etags -a $file
done
