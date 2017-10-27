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

cd $1 &&
    
#c,c++
if [ $2 == 'c' ]; then
    find . -regex .".+\\.c?h?\(cpp\)?\(cxx\)?\(cc\)?\(hh\)?\(hpp\)?\(hxx\)?"    > ./cscope.files
    cscope -cb
    ctags --fields=+i -n -R -L ./cscope.files
#java
elif [ $2 == 'j' ]; then
    find . -name ".+\\.\(java\)" > ./cscope.files
    cscope -cbR
#python
elif [ $2 == 'p' ]; then
    find . -name ".+\\.\(py\)"    > ./cscope.files
    pycscope -i ./cscope.files
# ruby, go, javascript
elif [ $2 == 'r' | $1 == 'g' | $2 == 'js' ]; then
    find . -name ".+\\.\(rb\)|\(go\)?\(js\)?"    > ./cscope.files
    starscope -e cscope
fi

ctags --fields=+i -n -R -L ./cscope.files &&
cqmakedb -s ./myproject.db -c ./cscope.out -t ./tags -p &&
codequery &>/dev/null &
