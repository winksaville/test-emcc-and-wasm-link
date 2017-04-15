%.wasm: %.wast
	wast2wasm $< -o $@

%.wast: %.wasm
	wasm2wast $(basename $<).wasm -o $@

all: addTwoInc.wast

addTwoInc.wast: addTwoInc.wasm
addTwoInc.wasm: addTwo.wasm inc.wasm
	wasm-link $^ -o $@

inc.wasm: inc.wast
addTwo.wasm: addTwo.wast

clean:
	rm -f addTwoInc.wast addTwoInc.wasm addTwo.wasm inc.wasm
