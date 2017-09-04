#!/bin/bash

#passwd:msandbox,rsandbox
git clone https://github.com/datacharmer/mysql-sandbox.git
cd mysql-sandbox
perl Makefile.PL 
make
make test
sudo make install
