// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// CHECK:STDOUT: [
// CHECK:STDOUT:     {kind: 'FunctionIntroducer', text: 'fn'},
// CHECK:STDOUT:     {kind: 'DeclaredName', text: 'F'},
// CHECK:STDOUT:       {kind: 'ParameterListStart', text: '('},
// CHECK:STDOUT:     {kind: 'ParameterList', text: ')', subtree_size: 2},
// CHECK:STDOUT:   {kind: 'FunctionDefinitionStart', text: '{', subtree_size: 5},
// CHECK:STDOUT:     {kind: 'ReturnStatementStart', text: 'return'},
// CHECK:STDOUT:   {kind: 'ReturnStatement', text: ';', subtree_size: 2},
// CHECK:STDOUT: {kind: 'FunctionDefinition', text: '}', subtree_size: 8},
// CHECK:STDOUT: {kind: 'FileEnd', text: ''},
// CHECK:STDOUT: ]

fn F() {
  return;
}
