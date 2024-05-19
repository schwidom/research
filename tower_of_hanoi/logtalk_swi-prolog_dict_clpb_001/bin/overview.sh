#!/bin/bash

# grep '\<\(object\|public\)\> *(' *.lgt 

grep '\<\(object\|public\)\> *(' $( bin/filelist.sh )

