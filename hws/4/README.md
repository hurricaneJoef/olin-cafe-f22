# Homework 4
The written portion is available [here](https://docs.google.com/document/d/1XybXmTD5-NTJ1gfLq3tYb-wUUDJGZS8xgO912DLf50Q/edit?usp=sharing)

Add a pdf of your written answers to this folder, then use `make clean` then `make submission` to submit!

An arithmetic logic unit is a critical building block for a CPU. It does a variety of mathematical operations on two inputs (addition, subtraction, comparison, etc.). The next few problem sets will have us build up the different units inside it. For this phase we will focus on making a 32-bit adder and a 32:1 32-bit mux. The homework folder is a starting point, but you will need to create/edit the following:
a mux32.sv file
an add32.sv file (or an adder_n.sv file that you can parametrize up to N=32).
all submodule files that you used to make the above
testbenches that give you confidence that you implemented them correctly
a Makefile that runs your tests
a README.md file with
A description of how you implemented the modules (you can include pictures or reference notes in your homework pdf)

made a python file to brute force it all for me


A description of how you tested the mux32.

i saw that avinash made a bunch of muxes in parallel so i did that and make sure the values looked good

How to run your tests

`make test_mux32`

`make test_add32` note the correct out has the co as the first bit


You may use any of the basic gates for this task (and, or, xor, nor, nand, not, mux2), and are encouraged to build up any modules you want to reuse. This cannot have any sequential logic. See the examples directory in the git repository for how to approach this!

Bonus: there’s enough code in the examples to make a ripple carry adder, but that’s the slowest way to do this. Instead, implement a faster adder, like Carry Look Ahead!
