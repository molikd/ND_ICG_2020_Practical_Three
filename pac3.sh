#!/bin/bash
#$ -M msievert@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N pac3

module load bio/2.0
module load julia
julia ./ass.jl --fw "SRR2584863_1.trim.fastq" --rv "SRR2584863_2.trim.fastq" --graph "graph"
