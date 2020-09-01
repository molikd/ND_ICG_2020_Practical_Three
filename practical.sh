#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N BIOS60132_Practical_Three

#Load modules
module load bio/2.0
module load julia

#Set inputs
leftRead="SRR2584863_1.trim.fastq"
rightRead="SRR2584863_2.trim.fastq"

#Set output
outputGraph="ecoli_deBruijnGraph"

#Run julia script for generating a
# genome de bruijn graph
julia ./generateDeBruijnGraph.jl $leftRead $rightRead $outputGraph