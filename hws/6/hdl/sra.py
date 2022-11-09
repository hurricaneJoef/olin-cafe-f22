n=32
s = ""
for i in (range(n)):
    if i == 0:
        s = s+f"in[{n-1-i}:{i}],"
        continue
    if i == n-1:
        s = s+"{"*2+str(i)+"{in["+str(n-1)+"]}"+"}"+f",in[{i}]"+"},"
        continue
    s = s+"{"*2+str(i)+"{in["+str(n-1)+"]}"+"}"+f",in[{n-1}:{i}]"+"},"
    
print(s)