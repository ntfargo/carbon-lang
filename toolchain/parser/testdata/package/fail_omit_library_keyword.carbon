// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// CHECK:STDOUT: [
// CHECK:STDOUT:   {kind: 'PackageIntroducer', text: 'package'},
// CHECK:STDOUT:   {kind: 'DeclaredName', text: 'Geometry'},
// CHECK:STDOUT: {kind: 'PackageDirective', text: ';', has_error: yes, subtree_size: 3},
// CHECK:STDOUT: {kind: 'FileEnd', text: ''},
// CHECK:STDOUT: ]

// CHECK:STDERR: fail_omit_library_keyword.carbon:[[@LINE+1]]:18: Missing `library` keyword.
package Geometry "Shapes" api;
