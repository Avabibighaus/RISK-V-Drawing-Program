.equ CLEAR,   0x2100100c
.equ PRESENT, 0x21001008
.equ DEV,     0x40000000
.equ LED,     0x00
.equ SW,      0x04
.equ KEYHIT,  0x2c
.equ WIDTH,   192
.equ HEIGHT,  144

.data
msg: .string "WASD moves the cursor. C clears the screen.\n"

.text
main:
    # Print instructions
    la   a0, msg
    li   a7, 4
    ecall

    li   s0, DEV
    li   s1, 96          # cursor x
    li   s2, 72          # cursor y

    # Clear the screen once at startup
    lw   t0, SW(s0)
    andi t2, t0, 63
    addi t2, t2, 2
    li   t3, CLEAR
    sw   t2, 0(t3)
    li   t3, PRESENT
    sw   t3, 0(t3)

loop:
    # Mirror switches to LEDs
    lw   t0, SW(s0)
    sw   t0, LED(s0)

    # Read a key; 0 means no key is waiting
    lw   t0, KEYHIT(s0)
    beqz t0, loop

    li   t1, 'c'
    beq  t0, t1, clear_screen

    li   t1, 'w'
    beq  t0, t1, move_up
    li   t1, 's'
    beq  t0, t1, move_down
    li   t1, 'a'
    beq  t0, t1, move_left
    li   t1, 'd'
    beq  t0, t1, move_right
    j    loop

move_up:
    beqz s2, loop
    addi s2, s2, -1
    j    loop

move_down:
    li   t1, HEIGHT-1
    bgeu s2, t1, loop
    addi s2, s2, 1
    j    loop

move_left:
    beqz s1, loop
    addi s1, s1, -1
    j    loop

move_right:
    li   t1, WIDTH-1
    bgeu s1, t1, loop
    addi s1, s1, 1
    j    loop

clear_screen:
    lw   t2, SW(s0)
    andi t2, t2, 63
    addi t2, t2, 2
    li   t3, CLEAR
    sw   t2, 0(t3)
    li   t3, PRESENT
    sw   t3, 0(t3)
    j    loop
