# System Applicability Guide (NES)

This guide clarifies where NES documentation is considered authoritative within the S-NES-BOY Learning & Development Framework.

## Scope

- NES documentation under `docs/nes/` is written for NES hardware only.
- Other systems are documented in their own directories and are out of scope here.
- This framework maintains strict system isolation.

## Coverage

- Fundamentals (1.1–1.5) describe NES hardware and execution behavior.
- Advanced fundamentals (2.1–2.7) describe NES timing, constraints, and failure modes.
- Core concepts (3.1–3.5) describe NES architectural patterns and data flow.
- Cheatsheets (4.x) provide NES-focused tabular references.
- Techniques (5.x) apply to NES subsystems and patterns.

## Usage

When working on NES development using this framework, treat `docs/nes/` as the primary written source of truth for NES behavior, together with the external references listed in `docs/nes/references/REFERENCES.md`.
