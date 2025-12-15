# System Applicability Guide (SNES)

This guide clarifies where SNES documentation is considered authoritative within the S-NES-BOY Learning & Development Framework.

## Scope

- SNES documentation under `docs/snes/` is written for SNES hardware only.
- Other systems are documented in their own directories and are out of scope here.
- This framework maintains strict system isolation.

## Coverage

- Fundamentals (1.1–1.5) describe SNES hardware and execution behavior.
- Advanced fundamentals (2.1–2.7) describe SNES timing, constraints, and failure modes.
- Core concepts (3.1–3.5) describe SNES architectural patterns and data flow.
- Cheatsheets (4.x) provide SNES-focused tabular references.
- Techniques (5.x) apply to SNES subsystems and patterns.

## Usage

When working on SNES development using this framework, treat `docs/snes/` as the primary written source of truth for SNES behavior, together with the external references listed in `docs/snes/references/REFERENCES.md`.
