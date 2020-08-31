#!/bin/bash
#$ -M sweaver4@nd.edu
#$ -m abe
#$ -N BIOS60132_Practical_Three

module load bio/2.0
module load julia

julia juliascript.jl --input1 "SRR11623243_1.fastq" \
	--input2 "SRR11623243_2.fastq" \
	--output1 "c_elegans_paired" \
	--output2 "my_c_elegans" \
	--output3 "dbg_c_elegans"
