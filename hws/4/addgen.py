c = ""

for i in range(32):
    c = c + f"axb[{i}] = ina[{i}] ^ inb[{i}];\n"
    c = c + f"c[{i+1}] = (ina[{i}] & inb[{i}]) | (axb[{i}] & c[{i}];\n"
    c = c + f"out[{i}] = axb[{i}] ^ c[{i}];\n"
    c = c + "\n"

print(c)