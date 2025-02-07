#!/bin/bash

# for FILE in $(find . -iname '*.pl'); do
#  swipl -s bin/tools/grep_outside_of_comments2.pl -g "grepfile3( '$FILE', \`$1\`)" -g halt 
# done

swipl -s bin/tools/grep_outside_of_comments2.pl -g "grepfile4( \`$1\`)" -g halt 

