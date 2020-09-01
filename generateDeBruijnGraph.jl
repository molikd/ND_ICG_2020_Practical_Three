#!/usr/bin/env julia

#Add packages
#import pkg
#Pkg.add("GenomeGraphs")
#Pkg.add("FASTX")
#Pkg.add("ReadDatastores")

#Load packages
using GenomeGraphs
using FASTX
using ReadDatastores

#Set workspace
ws=WorkSpace()

#Retrieve inputs
leftRead=ARGS[1]
rightRead=ARGS[2]
outputGraph=ARGS[3]

#Read input left and right trimmed reads
fwq=open(FASTQ.Reader, leftRead)
rvq=open(FASTQ.Reader, rightRead)

#Prepare reads for graphing
#Use {DNAAlphabet{4}} to handle N's
ds=PairedReads{DNAAlphabet{4}}(fwq, rvq, "ecoli_test_paired", "ecoli_test", 75, 400, 0, FwRv)

#Add reads
add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{27}, 10, Symbol("ecoli_test"))

#Clean up graph
remove_tips!(ws, 200)

#Generate de bruijn graph
GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, outputGraph)