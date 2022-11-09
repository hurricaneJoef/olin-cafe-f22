n=32
s = ""
for i in range(n):
    if i == 0:
        s = s+f"in[{n-1-i}:{i}],"
        continue
    if i == n-1:
        s = s+"{"+f"in[{i}],{i}'d0"+"},"
        continue
    s = s+"{"+f"in[{n-1}:{i}],{i}'d0"+"},"
    
print(s)