// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

package ExplorerTest api;

fn F[T:! ((), ())](x: T) -> () {
  // CHECK:STDERR: COMPILATION ERROR: fail_type_tuple_as_type.carbon:[[@LINE+1]]: only arrays and tuples can be indexed, found T
  return x[0];
}

fn Main() -> i32 {
  F(((), ()));
  return 0;
}
