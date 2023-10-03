# MIPS_pipelined
- The same single cycle MIPS processor modified to 5 stages (Fetch, Decode, Execute, Memory, Write Back). 
- The RAW data hazard has been solved by bypassing data from memory and write back stages and also solved by stalling fetch and decode stages and flushing execute stage. 
- The control hazard has been solved by stalling. The hazard unit was designed to control all the hazards. The simulation was performed on Modelsim using the following two programs written in machine code following MIPS ISA: GCD of 120 and 180, Factorial Number of 7.
- Some draft explaining the GCD machine code in MIPS_P.pdf to make you understand more while you try to trace in modelsim waveform.
