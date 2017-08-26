#!/bin/sh



#editor have to perform following script upon file change.

for file in $(find $1 -type f -name "*.[chSjp]")
do
	etags -a $file
done
