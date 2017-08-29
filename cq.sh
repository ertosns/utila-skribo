#!/bin/bash


#prepare c,c++,java,python,go,ruby,js for cqmakedb
#usage
#ln -s cq.sh /usr/bin/cqinit
#cqinit [path] [language]
#languages supported {
#    c:c,c++
#    j:java
#    p:python
#    js:java script
#    r:ruby
#    g:go
#}
#i.e cqinit ~/prj/bitcoin c
#credit https://github.com/ruben2020/codequery/blob/master/doc/HOWTO-LINUX.md



cd $2 &&
#c,c++
if [ $1 == 'c' ]; then
    find . -iname "*.c"    > ./cscope.files
    find . -iname "*.cpp" >> ./cscope.files
    find . -iname "*.cxx" >> ./cscope.files
    find . -iname "*.cc " >> ./cscope.files
    find . -iname "*.h"   >> ./cscope.files
    find . -iname "*.hpp" >> ./cscope.files
    find . -iname "*.hxx" >> ./cscope.files
    find . -iname "*.hh " >> ./cscope.files
    cscope -cb
    ctags --fields=+i -n -R -L ./cscope.files
    cqmakedb -s ./myproject.db -c ./cscope.out -t ./tags -p
#java
elif [ $1 == 'j' ]; then
    find . -iname "*.java" > ./cscope.files
    cscope -cbR
    ctags --fields=+i -n -R -L ./cscope.files
    cqmakedb -s ./myproject.db -c ./cscope.out -t ./tags -p
#python
elif [ $1 == 'p' ]; then
    find . -iname "*.py"    > ./cscope.files
    pycscope -i ./cscope.files
    ctags --fields=+i -n -R -L ./cscope.files
    cqmakedb -s ./myproject.db -c ./cscope.out -t ./tags -p
# ruby, go, javascript
elif [ $1 == 'r' | $1 == 'g' | $1 == 'js' ]; then
    find . -iname "*.rb"    > ./cscope.files
    find . -iname "*.go"    > ./cscope.files
    find . -iname "*.js"    > ./cscope.files
    starscope -e cscope
    ctags --fields=+i -n -R -L ./cscope.files
    cqmakedb -s ./myproject.db -c ./cscope.out -t ./tags -p
fi
codequery
