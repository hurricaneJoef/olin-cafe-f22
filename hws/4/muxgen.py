
from math import floor



n = 32
codestr = "out = "
for i in range(n):
    codestr = codestr + "({N{"
    dividor = n/2
    count = 4
    while dividor >0:
        if floor(i/dividor)%2:
            codestr = codestr + f"select[{count}]  "
        else:
            codestr = codestr + f"select_b[{count}]"
        
        dividor = floor(dividor/2)
        if dividor > 0:
            codestr = codestr + " & "
        count -= 1
    codestr = codestr + "}} & "
    codestr = codestr + f"in{i:02}) | \n"
print(codestr)
