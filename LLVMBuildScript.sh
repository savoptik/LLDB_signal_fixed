#!/bin/sh

#  LLVMBuildScript.sh
#  
#
#  Created by Артём Семёнов on 18.03.2020.
#  

if [ ! -f ./llvm-project/README ];
then
echo "вошёл"
git submodule update --init --recursive
#git submodule init
#git submodule update
fi

