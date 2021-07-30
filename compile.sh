set -e
set -x

sudo apt install -y ninja-build

echo "hello world"
root_dir=$(pwd)

git clone --recursive --single-branch --branch release/10.x https://github.com/llvm/llvm-project
cd llvm-project

mkdir -p build

pushd build

export CC=$(which clang)
export CXX=$(which clang++)

cmake ../llvm -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_LLD=ON -DLLVM_ENABLE_BINDINGS=OFF \
  -DLLVM_ENABLE_PROJECTS="llvm;clang;clang-tools-extra;libc;libclc;libcxx;libcxxabi;libunwind;lld;lldb;openmp;parallel-libs;polly;pstl" \
  -DCMAKE_INSTALL_PREFIX=${root_dir}/llvm-10

cmake --build . --target install --config Release

popd