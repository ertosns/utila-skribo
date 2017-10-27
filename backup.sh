#!/usr/bin/python
import os
import sys

'''
init-script
backups, are inteded for files e.g books, notes, so it's not VCS,
and backup done per execution.
inteded to be used alogside online backup client i.e dropbox-client that only backup one directory!
'''

BACKUP_LOC = '~/Dropbox/'
TO_BACKUP_DIR = '/var/lib/backup/'
TO_BACKUP= TO_BACKUP_DIR+'tobackup'

def trim_path(path):
    if path[len(path)-1] == '/':
            #basename() requriement.
            path[len(path)-1] == ''
    return path

def add_backup(path):
    if not os.path.isdir(TO_BACKUP_DIR):
        os.mkdir(TO_BACKUP_DIR)
        open(TO_BACKUP, 'a').close()
    elif not os.path.isfile(TO_BACKUP):
        open(TO_BACKUP, 'a').close()
        
    tobackup = open(TO_BACKUP, 'r')
    for line in tobackup:
        if path == line[:len(line)-1]:
            tobackup.close()
            return

    tobackup = open(TO_BACKUP, 'a')
    tobackup.write(trim_path(path)+'\n')
    tobackup.close()
    
def remove_backup(path):
    path = trim_path(path)
    tobackup = open(TO_BACKUP, 'rw')
    new_tobackup = ''
    for line in tobackup:
        if line != path:
            new_tobackup+=line
    tobackup.write(new_tobackup)
    tobackup.close()
    
def linkfile(path, dest):
    if not os.path.isfile(dest): #hard-link
        os.link(path, dest)

def linkdir(path, dest):
    if not os.path.isdir(dest):
        os.mkdir(dest)

    for entry in os.listdir(path):
        epath=path+'/'+entry
        edest=dest+'/'+entry
        if os.path.isfile(epath):
            linkfile(epath, edest)
        else:
            linkdir(epath, edest)

def backup():
    if not os.path.exists(TO_BACKUP):
        if not os.path.isdir(TO_BACKUP_DIR):
            os.mkdir(TO_BACKUP_DIR)
        open(TO_BACKUP, 'a').close()
        return

    tobackup = open(os.path.expanduser(TO_BACKUP))
    for path in tobackup:
        path = path[:len(path)-1]
        if path[len(path)-1]=='/':
            path = path[:len(path)-1]
        bname = os.path.basename(path)
        dest = os.path.expanduser(BACKUP_LOC)+bname

        linkfile(path, dest) if os.path.isfile(path) else linkdir(path, dest)

'''
$> backup <directory-path> [command]
command:
r: unlink path
default: link path
'''
def cli():
    argvl = len(sys.argv)
    arg = sys.argv
    if argvl > 1:
        path = os.path.expanduser(trim_path(arg[1]))
        if argvl>2 and arg[2]=='r':
            remove_backup(path)
        else:
            add_backup(path)
    backup()

cli()
