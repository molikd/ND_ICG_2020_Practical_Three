#!/bin/bash
#$ -M nvincen2@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N BIOS60132_Practical_Three

module load bio/2.0
module load julia
julia ./juliascript.jl --left "SRR2584863_1.trim.fastq" --right "SRR2584863_2.trim.fastq" --out "deBruijnGraph"

