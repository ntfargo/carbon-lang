// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// CHECK:STDOUT: cross_reference_irs_size: 1
// CHECK:STDOUT: callables: [
// CHECK:STDOUT:   {param_refs: block0, return_type: nodeIntegerType},
// CHECK:STDOUT: ]
// CHECK:STDOUT: integer_literals: [
// CHECK:STDOUT:   12,
// CHECK:STDOUT:   34,
// CHECK:STDOUT: ]
// CHECK:STDOUT: real_literals: [
// CHECK:STDOUT: ]
// CHECK:STDOUT: strings: [
// CHECK:STDOUT:   Main,
// CHECK:STDOUT: ]
// CHECK:STDOUT: nodes: [
// CHECK:STDOUT:   {kind: FunctionDeclaration, arg0: str0, arg1: callable0},
// CHECK:STDOUT:   {kind: IntegerLiteral, arg0: int0, type: nodeIntegerType},
// CHECK:STDOUT:   {kind: IntegerLiteral, arg0: int1, type: nodeIntegerType},
// CHECK:STDOUT:   {kind: BinaryOperatorAdd, arg0: node+1, arg1: node+2, type: nodeIntegerType},
// CHECK:STDOUT:   {kind: ReturnExpression, arg0: node+3, type: nodeIntegerType},
// CHECK:STDOUT:   {kind: FunctionDefinition, arg0: node+0, arg1: block2},
// CHECK:STDOUT: ]
// CHECK:STDOUT: node_blocks: [
// CHECK:STDOUT:   [
// CHECK:STDOUT:   ],
// CHECK:STDOUT:   [
// CHECK:STDOUT:     node+0,
// CHECK:STDOUT:     node+5,
// CHECK:STDOUT:   ],
// CHECK:STDOUT:   [
// CHECK:STDOUT:     node+1,
// CHECK:STDOUT:     node+2,
// CHECK:STDOUT:     node+3,
// CHECK:STDOUT:     node+4,
// CHECK:STDOUT:   ],
// CHECK:STDOUT: ]

fn Main() -> i32 {
  return 12 + 34;
}
