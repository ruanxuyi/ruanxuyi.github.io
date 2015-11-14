title: "grep_intro"
date: 2015-07-11 14:53:42
updated: 2015-07-11 14:53:42
tags:
categories:
---

Introduction

## Usage:

### Search location of files:

grep file named `sniff.py` in current directory:
  
`grep -rl "sniff.py" .`

`-r` - (or `--recursive`)indicates search recursivly
`-l` - (or `--files-with-matches`) only print files name of matching files 
