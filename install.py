import os

for file in os.listdir("."):
            src=os.getcwd()+'/'+file
            local='/usr/local/bin/'+file[:len(file)-3]
            if file.endswith(".sh") and not os.path.islink(local):
                        print "linking "+file
                        os.chmod(src, 775)
                        os.symlink(src, local)
