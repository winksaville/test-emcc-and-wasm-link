%.wasm: %.c
	emcc -Oz $< --ignore-dynamic-linking -s WASM=1 -s SIDE_MODULE=1 -o $(basename $<).wasm

%.wast: %.wasm
	wasm2wast $(basename $<).wasm -o $@

all: addTwo.wast inc.wast addTwoInc.wast

addTwoInc.wast: addTwoInc.wasm
addTwoInc.wasm: addTwo.wasm inc.wasm
	wasm-link $^ -o $@

inc.wast: inc.wasm
inc.wasm: inc.c

addTwo.wast: addTwo.wasm
addTwo.wasm: addTwo.c

clean:
	rm -f addTwoInc.wasm addTwo.wast addTwo.wasm inc.wast inc.wasm
