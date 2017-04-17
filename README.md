# test how to use wasm-link
This captures what I learned about trying to use `wasm-link`
to combine multiple wasm files into a single file.

[Here](https://groups.google.com/forum/#!topic/emscripten-discuss/qLDhAIAQ5Zc) is
the discussion on [emscripten-discuss](https://groups.google.com/forum/#!topic/emscripten-discuss/qLDhAIAQ5Zc)
helped get this far.

One goal out of this is for [TurboScript](https://github.com/01alchemist/TurboScript)
to be able to create "libraries" for itself as well as link with `C/C++`
code from clang v5.0.

## Prerequisites
Build clang v5.0, see [Using WebAssembly in LLVM](https://gist.github.com/yurydelendik/4eeff8248aeb14ce763e). Note: this took my desktop with 32GB of ram on linux my
laptop with 16GB of ram wasn't enough.

Build from source [binaryen]()https://github.com/WebAssembly/binaryen)

Build from source [wabt](https://github.com/WebAssembly/wabt).

## What I learned
For wasm-link to combine multiple `.wasm` files the import sections
must be named `"__extern"`.  And there must be no `memory` sections defined,
instead you need to use `--import-memory` to work. See the `Makefile`.

## The results are:
```
$ cd lib
wink@wink-desktop:~/prgs/test-emcc-and-wasm-link/lib (master)
$ make clean
rm -f *.s *.bc *wasm *wast
wink@wink-desktop:~/prgs/test-emcc-and-wasm-link/lib (master)
$ make
/home/wink/llvmwasm/bin/clang -emit-llvm --target=wasm32 -Oz addTwo.c -c -o addTwo.bc
/home/wink/llvmwasm/bin/llc -asm-verbose=false addTwo.bc -o addTwo.s
s2wasm --import-memory addTwo.s | sed -e's/"env"/"__extern"/' > addTwo.wast
wast2wasm addTwo.wast -o addTwo.wasm
/home/wink/llvmwasm/bin/clang -emit-llvm --target=wasm32 -Oz inc.c -c -o inc.bc
/home/wink/llvmwasm/bin/llc -asm-verbose=false inc.bc -o inc.s
s2wasm --import-memory inc.s | sed -e's/"env"/"__extern"/' > inc.wast
wast2wasm inc.wast -o inc.wasm
wasm-link addTwo.wasm inc.wasm -o addTwoInc.wasm
wasm2wast addTwoInc.wasm -o addTwoInc.wast
```
And the `linked` result is
```
$ cat addTwoInc.wast
(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32) (result i32)))
  (func (;0;) (type 0) (param i32 i32) (result i32)
    get_local 1
    get_local 0
    i32.add)
  (func (;1;) (type 2) (param i32) (result i32)
    get_local 0
    i32.const 1
    call 0)
  (table (;0;) 0 0 anyfunc)
  (export "addTwo" (func 0))
  (export "inc" (func 1)))
```

## The `addTwoInc.wasm` has NOT been tested
You'll notice there are no memory sections being imported,
I have a feeling that is a bug and probably won't work.
