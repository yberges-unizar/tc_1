#!/bin/bash

flex "${1}".l

gcc lex.yy.c -lfl -o "${1}"
./${1} < input_${1}.txt
