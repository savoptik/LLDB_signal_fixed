#!/bin/sh

#  LLVMBuildScript.sh
#  
#
#  Created by Артём Семёнов on 18.03.2020.
#  

if ![ -e ./llvm-project/README ]
then
git submodule init
git submodule update
fi

