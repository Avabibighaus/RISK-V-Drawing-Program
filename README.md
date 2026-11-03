# RISK-V-Drawing-Program
# CPE 2300 — Etch / Paint Project

## Project Description
This project is an interactive drawing program written in RISC-V assembly language. Users will be able to move a cursor using keyboard controls, draw pixels and lines, change colors, erase pixels, and clear the screen. The program will run in MustyV-Playground, a browser-based RISC-V emulator.

## Implementation
The project will use several advanced assembly concepts, including:
- **Functions:** Organize drawing, keyboard input, and color controls into separate routines.
- **Memory-Mapped I/O (MMIO):** Read keyboard input and display pixels on the screen.
- **Bitwise Operations:** Process input flags and manipulate color values.
- **Loops and Branches:** Handle continuous user input and drawing operations.

## Project Files
- `main.s` — Main program that connects all components.
- `drawing.s` — Pixel and line drawing.
- `input.s` — Keyboard controls and cursor movement.
- `tools.s` — Color selection, erasing, and clearing the screen.

## Development Tools
- **Language:** RISC-V Assembly (RV32IM)
- **Emulator:** MustyV-Playground
- **Version Control:** GitHub

## AI Usage
AI was used to assist with project planning and documentation. All final RISC-V assembly code will be written manually by team members.
