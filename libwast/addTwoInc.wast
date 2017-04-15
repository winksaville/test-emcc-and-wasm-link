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
  (export "_addTwo" (func 0))
  (export "_inc" (func 1)))
