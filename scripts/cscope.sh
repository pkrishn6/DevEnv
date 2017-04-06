#!/bin/bash

echo "MAKING the cscope.file..."
find `pwd` -type f -name "*.[cChH]" >> cscope.files;
find `pwd` -type f -name '*.asm'  >> cscope.files;
find `pwd` -type f -name '*.cc' >> cscope.files;
find `pwd` -type f -name '*.cpp' >> cscope.files;
find `pwd` -type f -name '*.hh' >> cscope.files;
find `pwd` -type f -name '*.go' >> cscope.files;
find `pwd` -type f -name '*.thrift' >> cscope.files;
find `pwd` -type f -name Makefile  >> cscope.files;
find `pwd` -type f -name README  >> cscope.files;
echo "cscope -bqv -i ./cscope.files..."
cscope -bqv -i cscope.files;
echo "DONE ... "
echo "Start to build ctags"
rm -f tags
ctags -R --exclude="cscope.\*" --exclude="*.js" --exclude=test --exclude=opennsl-2.0.0.8-odp --exclude=.git --exclude=docs --exclude=opennsl-6.4.6.5-odp --exclude=opennsl-3.1.0.1-odp --exclude=vendor --sort=yes
echo "Done"
