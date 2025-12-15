# Real Hardware Considerations

## System Applicability

**This document applies to:**
- ✅ **: Fully applicable (same hardware, different cartridge connector)


## Flashcarts


### Common Flashcarts

* **Everdrive N8: Popular, supports most mappers
* **PowerPak: Older, still functional
* **N8 Pro: Updated version of Everdrive N8

### Flashcart Usage

1. **Copy ROM to SD card: Place `.nes` file on SD card
2. **Insert SD card: Into flashcart

### Flashcart Limitations

* **Mapper support: Not all mappers supported (check compatibility)
* **Save data: Some flashcarts support battery-backed SRAM
* **CHR RAM: Some flashcarts support CHR RAM games

## Power-On State Differences

**Real hardware power-on state** differs from emulators:

| Component | Real Hardware | Many Emulators |
|-----------|---------------|----------------|
| RAM | Random values | Often zeroed |
| PPU registers | Uninitialized | Often zeroed |
| APU registers | Uninitialized | Often zeroed |
| Stack pointer | Random | Often $FF |

**Implications:
* **Always initialize RAM: Clear RAM in reset handler
* **Always initialize PPU: Set $2000, $2001 in reset
* **Always initialize APU: Disable channels, set frame counter
* **Always initialize stack: Set SP to $FF

**Correct initialization:
```asm
reset:
    SEI
    CLD
    LDX #$FF
    TXS          ; Initialize stack pointer
    
    ; Disable PPU
    LDX #0
    STX $2000
    STX $2001
    STX $4010
    
    ; Wait for PPU
    BIT $2002
vblank_wait1:
    BIT $2002
    BPL vblank_wait1
    
    ; Clear RAM
    LDA #0
clear_ram:
    STA $0000,X
    STA $0100,X
    STA $0200,X
    STA $0300,X
    STA $0400,X
    STA $0500,X
    STA $0600,X
    STA $0700,X
    INX
    BNE clear_ram
```

## Emulator vs Hardware Mismatches

### Common Mismatches

**VRAM Access Timing:
* **Emulator: May allow VRAM writes during rendering (lenient)
* **Hardware: VRAM writes during rendering cause corruption
* **Fix: Only write VRAM during VBlank or forced blanking

**PPU Register Timing:
* **Emulator: May not enforce register write timing
* **Hardware: Some registers must be written in specific order
* **Fix: Follow exact register write sequences

**OAM Corruption:
* **Emulator: May not corrupt OAM during sprite evaluation
* **Hardware: Reading $2002 during rendering can corrupt OAM
* **Fix: Only read $2002 during VBlank

**Audio Timing:
* **Emulator: May not be cycle-accurate for audio
* **Hardware: Audio requires precise timing
* **Fix: Use cycle-accurate audio updates

**Controller Timing:
* **Emulator: May not require exact strobe sequence
* **Hardware: Strobe must be 1 then 0
* **Fix: Follow exact strobe sequence

### Testing on Real Hardware

**Always test on real hardware** before considering a game "complete":
2. **Observe: Check for visual glitches, audio issues, input problems
3. **Compare: Compare behavior to emulator, note differences
4. **Fix: Address hardware-specific issues

## Power Consumption

* **Voltage: 9V DC (adapter)
* **Current: ~850 mA
* **Power: ~7.65 W

**Flashcart power:
* **Additional current: ~50–100 mA
* **Total: ~900–950 mA

**Considerations:
* Ensure adequate power supply for flashcart
* Power issues can cause crashes or glitches

## Video Output

* **Composite: Standard composite video (yellow RCA)
* **RF: Radio frequency (channel 3/4)

**Modern displays:
* **CRT: Best compatibility, original experience
* **LCD: May have input lag, scaling issues
* **Upscalers: Framemeister, OSSC can improve LCD experience

## Audio Output

* **Mono: Single audio channel (white/gray RCA)

**Audio quality:
* **CRT: May have audio interference
* **LCD: Usually cleaner audio
* **Headphones: Best audio quality

## Controller Considerations

* **D-pad: May be worn, less responsive
* **Buttons: May stick or require more force
* **Cable: May be damaged or short

**Modern controllers:
* **USB adapters: Allow modern controllers (may have input lag)
* **Wireless: 8BitDo controllers (low latency)
* **Original: Best compatibility, authentic feel

## Temperature

* **Normal: 40–60°C (console gets warm)
* **Overheating: >70°C (may cause crashes)

**Considerations:
* Ensure adequate ventilation
* Don't block console vents
* Extended play sessions may cause heat buildup

## Cartridge Contacts

**Cartridge contact issues:
* **Dirty contacts: Clean with isopropyl alcohol
* **Bent pins: May cause read errors
* **Oxidation: May cause intermittent failures

**Maintenance:
* Clean cartridge contacts regularly
* Clean console cartridge slot
* Use contact cleaner if needed

## Cross-References

- Related Advanced Fundamentals: 2.1 (CPU Timing), 2.2 (NMI & VBlank), 2.3 (PPU Rendering Rules)
- Related Tooling: 6.2 (Emulators & Debuggers)
