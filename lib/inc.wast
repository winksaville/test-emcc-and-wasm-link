(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func))
  (import "env" "memoryBase" (global (;0;) i32))
  (import "env" "_addTwo" (func (;0;) (type 0)))
  (import "env" "memory" (memory (;0;) 256))
  (import "env" "table" (table (;0;) 0 anyfunc))
  (import "env" "tableBase" (global (;1;) i32))
  (func (;1;) (type 1) (param i32) (result i32)
    get_local 0
    i32.const 1
    call 0)
  (func (;2;) (type 2)
    nop)
  (func (;3;) (type 2)
    block  ;; label = @1
      get_global 0
      set_global 2
      get_global 2
      i32.const 5242880
      i32.add
      set_global 3
      call 2
    end)
  (global (;2;) (mut i32) (i32.const 0))
  (global (;3;) (mut i32) (i32.const 0))
  (export "_inc" (func 1))
  (export "__post_instantiate" (func 3))
  (export "runPostSets" (func 2)))
