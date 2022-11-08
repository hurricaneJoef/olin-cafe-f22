from random import Random, random




cs = "" 

disp = """    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);\n"""



testnumbs = [0,0xffffffff,0x55555555,0xaaaaaaaa]
testcis = [0,1]
for cin in testcis:
    for i in testnumbs:
        for j in testnumbs:
            cs = cs + f"""    ci = 1'd{cin}; ina = 32'd{i}; inb = 32'd{j}; correctout = 33'd{i+j+cin};\n"""
            cs = cs + disp

print(cs)
