# Hex String Macro Example

Demonstrates the use of the hex string macro for defining multibyte constants in NES assembly.

## Overview

This example shows how to use the `hex` macro to define multibyte constants in a readable format. The macro converts hexadecimal string literals into byte values, making it easier to define lookup tables, magic numbers, and other multibyte data.

## Features

- Hex string macro usage
- Multibyte constant definition
- Readable hex string formatting with underscores
- Example lookup table using hex strings

## Building

```bash
cd examples/nes/hex_string_example
make
```

## Files

- `src/main.asm` - Main example demonstrating hex macro usage
- `src/macros/hex_string.inc` - Hex string macro definition

## Usage Example

```asm
.include "macros/hex_string.inc"

; Define a lookup table using hex strings
lookup_table:
    hex "09F9_1102_9D74"      ; Bytes: $09, $F9, $11, $02, $9D, $74
    hex "E35B_D841_56C5"      ; Underscores are ignored for readability
    hex "6356_88C0"           ; Must have even number of hex digits

; Define a magic number
magic_signature:
    hex "4E4553"              ; "NES" in ASCII hex: $4E, $45, $53
```

## Related Documentation

- [NES Advanced Fundamentals: Optimization Techniques](../../../docs/nes/advanced_fundamentals/2.6-optimization-techniques.md) - Hex string macros section
- [NES Template Macros](../../../templates/nes/macros/hex_string.inc) - Macro implementation
- [NES References: Multibyte Constant](../../../docs/nes/REFERENCES.md) - External resources
