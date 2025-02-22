// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef CARBON_TOOLCHAIN_LOWERING_LOWERING_CONTEXT_H_
#define CARBON_TOOLCHAIN_LOWERING_LOWERING_CONTEXT_H_

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "toolchain/semantics/semantics_ir.h"
#include "toolchain/semantics/semantics_node.h"

namespace Carbon {

// Context and shared functionality for lowering handlers.
class LoweringContext {
 public:
  explicit LoweringContext(llvm::LLVMContext& llvm_context,
                           llvm::StringRef module_name,
                           const SemanticsIR& semantics_ir,
                           llvm::raw_ostream* vlog_stream);

  // Lowers the SemanticsIR to LLVM IR. Should only be called once, and handles
  // the main execution loop.
  auto Run() -> std::unique_ptr<llvm::Module>;

  auto HasLoweredNode(SemanticsNodeId node_id) -> bool {
    return !lowered_nodes_[node_id.index].isNull();
  }

  // Returns a type for the given node. May construct and cache the type
  // if it hasn't yet been built.
  auto GetLoweredNodeAsType(SemanticsNodeId node_id) -> llvm::Type*;

  // Returns a value for the given node.
  auto GetLoweredNodeAsValue(SemanticsNodeId node_id) -> llvm::Value*;

  // Sets the value for the given node.
  auto SetLoweredNodeAsValue(SemanticsNodeId node_id, llvm::Value* value) {
    CARBON_CHECK(lowered_nodes_[node_id.index].isNull()) << node_id;
    lowered_nodes_[node_id.index] = value;
  }

  // Gets a callable's function.
  auto GetLoweredCallable(SemanticsCallableId callable_id) -> llvm::Function* {
    CARBON_CHECK(lowered_callables_[callable_id.index] != nullptr)
        << callable_id;
    return lowered_callables_[callable_id.index];
  }

  // Sets a callable's function.
  auto SetLoweredCallable(SemanticsCallableId callable_id,
                          llvm::Function* function) {
    CARBON_CHECK(lowered_callables_[callable_id.index] == nullptr)
        << callable_id;
    lowered_callables_[callable_id.index] = function;
  }

  auto llvm_context() -> llvm::LLVMContext& { return *llvm_context_; }
  auto llvm_module() -> llvm::Module& { return *llvm_module_; }
  auto builder() -> llvm::IRBuilder<>& { return builder_; }
  auto semantics_ir() -> const SemanticsIR& { return *semantics_ir_; }
  auto todo_blocks() -> llvm::SmallVector<
      std::pair<llvm::BasicBlock*, SemanticsNodeBlockId>>& {
    return todo_blocks_;
  }

 private:
  // Runs lowering for a block.
  auto LowerBlock(SemanticsNodeBlockId block_id) -> void;

  // Builds the type for the given node, which should then be cached by the
  // caller.
  auto BuildLoweredNodeAsType(SemanticsNodeId node_id) -> llvm::Type*;

  // State for building the LLVM IR.
  llvm::LLVMContext* llvm_context_;
  std::unique_ptr<llvm::Module> llvm_module_;
  llvm::IRBuilder<> builder_;

  // The input Semantics IR.
  const SemanticsIR* const semantics_ir_;

  // The optional vlog stream.
  llvm::raw_ostream* vlog_stream_;

  // Blocks which we've observed and need to lower.
  llvm::SmallVector<std::pair<llvm::BasicBlock*, SemanticsNodeBlockId>>
      todo_blocks_;

  // Maps nodes in SemanticsIR to a lowered value. This will have one entry per
  // node, and will be non-null when lowered. It's expected to be sparse during
  // execution because while expressions will have entries, statements won't.
  // TODO: Long-term, we should examine the practical trade-offs of making this
  // a map; a map may end up lower memory consumption, but a vector offers cache
  // efficiency and better performance. As a consequence, the right choice is
  // unclear.
  llvm::SmallVector<llvm::PointerUnion<llvm::Type*, llvm::Value*>>
      lowered_nodes_;

  // Maps callables to lowered functions. Semantics treats callables as the
  // canonical form of a function, so lowering needs to do the same.
  llvm::SmallVector<llvm::Function*> lowered_callables_;
};

// Declare handlers for each SemanticsIR node.
#define CARBON_SEMANTICS_NODE_KIND(Name)                                       \
  auto LoweringHandle##Name(LoweringContext& context, SemanticsNodeId node_id, \
                            SemanticsNode node)                                \
      ->void;
#include "toolchain/semantics/semantics_node_kind.def"

}  // namespace Carbon

#endif  // CARBON_TOOLCHAIN_LOWERING_LOWERING_CONTEXT_H_
