# Game Boy Gold Standard Examples

This directory contains **hardware-accurate reference implementations** demonstrating correct Game Boy programming patterns. These examples serve as authoritative references for hardware-accurate Game Boy development.

## Important Note

**"Gold Standard" in this context means hardware-accurate reference implementations**, not Nintendo's Seal of Quality (which was a licensing/quality assurance program for commercial games). These examples are technical references demonstrating correct hardware usage, not commercial quality certifications.

## Purpose

Examples placed here must be:
- **Verified to work on real hardware**: Tested on actual Game Boy hardware or verified emulators (SameBoy, BGB, mGBA)
- **Demonstrating correct hardware behavior**: Show proper use of Game Boy hardware features with hardware-accurate timing
- **Clearly documented with hardware rationale**: Explain why the implementation is correct, referencing Pan Docs
- **Serving as reference implementations**: Can be used as templates for similar functionality
- **Traceable to authoritative sources**: Based on Pan Docs (gbdev.io/pandocs/) or verified hardware behavior

## Current Status

This directory is currently empty. Gold-standard examples will be added only when verified, authoritative reference implementations become available.

Examples will only be added if they:
1. Are from official Nintendo documentation or widely recognized authoritative sources (e.g., Pan Docs official examples, verified test ROMs)
2. Have been verified to work correctly on real Game Boy hardware by multiple independent sources
3. Are traceable to official documentation (Pan Docs) or verified hardware behavior
4. Include complete documentation with authoritative source citations

## Adding New Examples

When adding new gold-standard examples:

1. **Verify on hardware**: Test the example works on real Game Boy hardware (not just emulators)
2. **Document behavior**: Explain the hardware behavior being demonstrated, referencing Pan Docs
3. **Explain correctness**: Describe why the implementation is correct, with Pan Docs citations
4. **Reference sources**: Link to Pan Docs (gbdev.io/pandocs/) or other authoritative documentation
5. **Include instructions**: Provide build instructions and requirements
6. **Hardware verification**: Include evidence of real hardware testing or reference to verified implementations

**Important**: Only examples from official Nintendo documentation, verified test ROMs, or widely recognized authoritative sources (such as official Pan Docs examples) that have been independently verified on real hardware will be included. Third-party implementations or unverified examples will not be added.

## Related Documentation

- [Game Boy Documentation Index](../README.md) - Main Game Boy documentation
- [Game Boy Fundamentals](../fundamentals/) - Core hardware concepts
- [Game Boy Advanced Fundamentals](../advanced_fundamentals/) - Timing and constraints
