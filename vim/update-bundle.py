#!/usr/bin/env python
# update-bundle
# Updates plugins in ~/.config/vim/bundle
#
# Author: Daniel Gonzalez Gasull

import git
import os


os.chdir(os.path.expanduser('~'))
os.chdir('.config/vim/bundle')
for directory in os.listdir('.'):
    if os.path.isdir(directory):
        repo = git.cmd.Git(directory)
        print('Updating %s:' % repo.working_dir)
        print(repo.pull())