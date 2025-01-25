#!/bin/bash

# grep '^[^%]' 003.pl
# grep '^[[:alpha:]]' 003.pl
# grep '^[[:alnum:]_]*([^)]*)' -o main.pl | uniq
grep '^[[:alnum:]_]*([^)]*)' -o *.pl | uniq

