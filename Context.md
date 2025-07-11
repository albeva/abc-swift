# Project: BASIC Compiler in Swift

This document outlines the context and plan for building a BASIC compiler using the Swift language.

## Compilation Stages

The compiler will be built with the following classical stages:

1.  **Lexer:** Converts source code into a stream of tokens.
2.  **Parser:** Builds an Abstract Syntax Tree (AST) from the token stream.
3.  **Sema (Semantic Analysis):** Performs type checking and other semantic checks on the AST.
4.  **IR (Intermediate Representation):** Generates an intermediate representation from the AST.
5.  **Code Generation:** Translates the IR into C code. (Future goal: LLVM IR).

## Core Principles

-   **Language:** Swift
-   **Lean & Clean:** The codebase should be simple, well-structured, and easy to understand.
-   **Minimalism:** Focus on the essential features first, avoiding over-engineering.
-   **Readability over Performance:** At this stage, we are not concerned with performance optimizations like memory arenas or avoiding copies. The priority is a clear and maintainable foundation.

## Development Process

-   Development will proceed one step at a time.
-   Code will only be written upon explicit request.
-   The assistant will provide critical feedback to ensure solutions remain simple and aligned with the project's core principles.
