# assembler.py

# Our ISA Dictionary
opcodes = {
    "MVR": "0", "LDB": "1", "STB": "2", "RDS": "3",
    "NOT": "8", "AND": "9", "ORA": "A", "ADD": "B",
    "SUB": "C", "XOR": "D", "INC": "E"
}

with open("program.txt", "r") as f_in, open("machine_code.hex", "w") as f_out:
    for line in f_in:
        parts = line.replace(",", "").split()
        if not parts: continue
        
        command = parts[0]
        
        # LDB r1, 42  ->  1142
        if command == "LDB":
            r1 = parts[1].replace("r", "")
            data = parts[2]
            f_out.write(f"{opcodes[command]}{r1}{data}\n")

        # MVR r1, r2  ->  0112
        elif command == "MVR":
            r_dest = parts[1].replace("r", "")
            r_src  = parts[2].replace("r", "")
            f_out.write(f"{opcodes[command]}{r_dest}{r_src}0\n")

        # ALU 3-reg: ADD r3, r1, r2  ->  B312
        elif command in ["ADD", "SUB", "AND", "ORA", "XOR"]:
            r_dest = parts[1].replace("r", "")
            r_src1 = parts[2].replace("r", "")
            r_src2 = parts[3].replace("r", "")
            f_out.write(f"{opcodes[command]}{r_dest}{r_src1}{r_src2}\n")

        # ALU 2-reg: INC r7, r6  ->  E760  |  NOT r1, r2  ->  8120
        elif command in ["INC", "NOT"]:
            r_dest = parts[1].replace("r", "")
            r_src  = parts[2].replace("r", "")
            f_out.write(f"{opcodes[command]}{r_dest}{r_src}0\n")

        # STB r8  ->  2800
        elif command == "STB":
            r_src = parts[1].replace("r", "")
            f_out.write(f"{opcodes[command]}{r_src}00\n")

        # RDS r1  ->  3100
        elif command == "RDS":
            r_dest = parts[1].replace("r", "")
            f_out.write(f"{opcodes[command]}{r_dest}00\n")

print("Assembly complete! Generated machine_code.hex")
