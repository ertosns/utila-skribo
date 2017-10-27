#!/usr/bin/python

import os

for file in os.listdir("."):
            part = file.split('.')
            if len(part)==1 or part[0]=='install' or part[0]=='md' or part[1]=='git':
                        continue
            src=os.getcwd()+'/'+file
            local='/usr/local/bin/'+part[0]
            if not os.path.islink(local):
                        print "linking "+file
                        os.chmod(src, 775)
                        os.symlink(src, local)

print 'installation done!\n'
