# Colors and Drawing Tools
.equ TOOLS_FB,      0x20000000
.equ TOOLS_CLEAR,   0x2100100c
.equ TOOLS_PRESENT, 0x21001008
.equ TOOLS_WIDTH,   192
.equ TOOLS_HEIGHT,  144

.data
.align 2
cur_color:  .word 1      # white
erase_mode: .word 0      # 0 = draw, 1 = erase

.text
# a0 = color index
set_color:
    andi a0, a0, 0xFF
    la   t0, cur_color
    sw   a0, 0(t0)
    la   t0, erase_mode
    sw   zero, 0(t0)
    ret

clear_screen:
    li   t0, TOOLS_CLEAR
    sw   zero, 0(t0)
    li   t0, TOOLS_PRESENT
    sw   zero, 0(t0)
    ret

# a0 = x, a1 = y
erase_pixel:
    li   t0, TOOLS_WIDTH
    bgeu a0, t0, erase_done
    li   t1, TOOLS_HEIGHT
    bgeu a1, t1, erase_done

    mul  t1, a1, t0
    add  t1, t1, a0
    li   t0, TOOLS_FB
    add  t1, t1, t0       # FB + y * WIDTH + x
    sb   zero, 0(t1)
    li   t0, TOOLS_PRESENT
    sw   zero, 0(t0)
erase_done:
    ret

toggle_mode:
    la   t0, erase_mode
    lw   t1, 0(t0)
    xori t1, t1, 1        # switch between 0 and 1
    sw   t1, 0(t0)
    ret

# a0 = key; 1-7 colors, e eraser, c clear
handle_tool_key:
    li   t0, 'c'
    beq  a0, t0, clear_screen
    li   t0, 'e'
    beq  a0, t0, toggle_mode
    li   t0, '1'
    bltu a0, t0, tools_done
    li   t0, '7'
    bltu t0, a0, tools_done
    addi a0, a0, -48      # ASCII to number
    j    set_color

tools_done:
    ret
