#!/bin/bash

export ORACLE_HOME=$HOME/Downloads/Disk1/u01/app/oracle/product/11.2.0/xe
export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib:$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$PATH:$HOME/Documents/Data-Integration/DB/Oracle
export HPCC_ORA=$HOME/Documents/Data-Integration/DB/Oracle