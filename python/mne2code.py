def format1(opcode, funct = 0b00000):
    r1 = int(raw_input("r1: "))
    r2 = int(input("r2: "))
    shamt = int(raw_input("shamt: "))
    empty = 0

    opcode = format(opcode, '06b')
    r1 = format(r1, '05b')
    r2 = format(r2, '05b')
    shamt = format(shamt, '05b')
    empty = format(empty, '06b')
    funct = format(funct, '05b')
    
    instr = str(opcode) + str(r1) + str(r2) + str(shamt) + str(empty) + str(funct)
    return instr

def format2(opcode, funct = 0b00000):
    r1 = int(raw_input("r1: "))
    imm16 = int(raw_input("imm16: "))

    opcode = format(opcode, '06b')
    r1 = format(r1, '05b')
    imm16 = format(imm16, '016b')
    funct = format(funct, '05b')

    instr = str(opcode) + str(r1) + str(imm16) + str(funct)
    return instr

def format3(opcode, funct = ''):
    r1 = int(raw_input("r1: "))
    r2 = int(raw_input("r2: "))
    desl = int(raw_input("desl: "))

    opcode = format(opcode, '06b')
    r1 = format(r1, '05b')
    r2 = format(r2, '05b')
    desl = format(desl, '016b')

    instr = str(opcode) + str(r1) + str(r2) + str(desl)
    return instr

def funknown():
    print('ERROR: method unknown')
    return 'ERROR'

if __name__ == '__main__':
    c = 'c'
    
    isa = {
    'add':  (format1, 0b000001, 0b00001),
    'sub': (format1, 0b000001, 0b00010),
    'addi': (format2, 0b000001, 0b00011),
    'subi': (format2, 0b000001, 0b00100),
    'less': (format1, 0b000011, 0b00001),
    'grand': (format1, 0b000011, 0b00010),
    'eq': (format1, 0b000011, 0b00011),
    'neq': (format1, 0b000011, 0b00100),
    'leq': (format1, 0b000011, 0b00101),
    'geq': (format1, 0b000011, 0b00110),
    'lessi': (format2, 0b000011, 0b00111),
    'grandi': (format2, 0b000011, 0b01000),
    'eqi': (format2, 0b000011, 0b01001),
    'neqi': (format2, 0b000011, 0b01010),
    'leqi': (format2, 0b000011, 0b01011),
    'geqi': (format2, 0b000011, 0b01100),
    'mv': (format3, 0b000100, 0b00000),
    'mvi': (format2, 0b000101, 0b00000),
    'sw': (format3, 0b000110, 0b00000),
    'lw': (format3, 0b000111, 0b00000),
    'jump': (format3, 0b001010, 0b00000),
    'jal': (format3, 0b001011, 0b00000),
    'jc': (format3, 0b001100, 0b00000),
    'branch': (format3, 0b001101, 0b00000),
    'bal': (format3, 0b001110, 0b00000),
    'bc': (format3, 0b001111, 0b00000),
    'get': (format3, 0b010000, 0b00000),
    'print': (format3, 0b010001, 0b00000)
    }
    
    code = []
    while(c != 'q'):
        f, op, funct = isa.get(raw_input('func: '), (funknown, 0b0, ''))
        code.append(f(op, funct))
        c = raw_input('end? ')
        
    print('-'*50 + 'CODE' + '-'*50)
    for line in code:
        print(line)
