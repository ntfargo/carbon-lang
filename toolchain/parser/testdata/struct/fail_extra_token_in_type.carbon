// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// CHECK:STDOUT: [
// CHECK:STDOUT:   {kind: 'VariableIntroducer', text: 'var'},
// CHECK:STDOUT:     {kind: 'DeclaredName', text: 'x'},
// CHECK:STDOUT:       {kind: 'StructLiteralOrStructTypeLiteralStart', text: '{'},
// CHECK:STDOUT:           {kind: 'DesignatedName', text: 'a'},
// CHECK:STDOUT:         {kind: 'StructFieldDesignator', text: '.', subtree_size: 2},
// CHECK:STDOUT:         {kind: 'Literal', text: 'i32'},
// CHECK:STDOUT:       {kind: 'StructFieldType', text: ':', subtree_size: 4},
// CHECK:STDOUT:     {kind: 'StructTypeLiteral', text: '}', has_error: yes, subtree_size: 6},
// CHECK:STDOUT:   {kind: 'PatternBinding', text: ':', subtree_size: 8},
// CHECK:STDOUT:   {kind: 'VariableInitializer', text: '='},
// CHECK:STDOUT:     {kind: 'StructLiteralOrStructTypeLiteralStart', text: '{'},
// CHECK:STDOUT:         {kind: 'DesignatedName', text: 'a'},
// CHECK:STDOUT:       {kind: 'StructFieldDesignator', text: '.', subtree_size: 2},
// CHECK:STDOUT:       {kind: 'Literal', text: '0'},
// CHECK:STDOUT:     {kind: 'StructFieldValue', text: '=', subtree_size: 4},
// CHECK:STDOUT:   {kind: 'StructLiteral', text: '}', subtree_size: 6},
// CHECK:STDOUT: {kind: 'VariableDeclaration', text: ';', subtree_size: 17},
// CHECK:STDOUT: {kind: 'FileEnd', text: ''},
// CHECK:STDOUT: ]

// CHECK:STDERR: fail_extra_token_in_type.carbon:[[@LINE+1]]:17: Expected `,` or `}`.
var x: {.a: i32 banana} = {.a = 0};
