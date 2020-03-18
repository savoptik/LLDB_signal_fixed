#!/bin/sh

#  LLVMBuildScript.sh
#  
#
#  Created by Артём Семёнов on 18.03.2020.
#  

# проверка подмодулей
if [ ! -f ./llvm-project/README.md ];
then
git submodule update --init --recursive
#git submodule init
#git submodule update
fi

# проверка установки патча
if [ ! -f ./llvm-project/0001-apply-patch-from-signals.patch ];
then
cp ./0001-apply-patch-from-signals.patch ./llvm-project
cd ./llvm-project
git apply 0001-apply-patch-from-signals.patch
cd ..
fi

# создание папок для сборки и установки
mkdir "build"
mkdir "install"
cd ./build

# Создание проекта для сборки и установки
cmake -DLIBOMP_ARCH=x86_64 -DLINK_POLLY_INTO_TOOLS=ON -DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_FFI=ON -DLLVM_ENABLE_LIBCXX=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_INCLUDE_DOCS=OFF -DLLVM_INSTALL_UTILS=ON -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLDB_DISABLE_PYTHON=1 -DLIBOMP_INSTALL_ALIASES=OFF -DLLDB_USE_SYSTEM_DEBUGSERVER=ON -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;compiler-rt;libcxx;libcxxabi;libunwind;lld;lldb;openmp;polly' -DLLVM_CREATE_XCODE_TOOLCHAIN=ON -DCMAKE_INSTALL_PREFIX=../install     -DCMAKE_BUILD_TYPE=Release ../llvm-project/llvm

# Сборка LLVM и LLVM чxcode toolchain
cmake --build . --target install
cmake --build . --target install-xcode-toolchain
