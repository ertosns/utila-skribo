#!/bin/sh

espeak $1
dict $1 | less
espeak $1
