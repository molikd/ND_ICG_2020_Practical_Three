#!/usr/bin/env julia

#$ -M msievert@nd.edu
#$ -m abe
#$ -N Julia_db

using ArgParse
using GenomeGraphs
using FASTX
using ReadDatastores
using Graphs


s = ArgParseSettings()
@add_arg_table! s begin
        "--fw"
        "--rv"
        "--graph"
end


parsed_args = parsed_args(ARGS, s)

forward_read = parsed_args["fw"]
reverse_read = parsed_args["rv"]
graph = parsed_args["graph"]

ws=WorkSpace()

fwq=open(FASTQ.Reader, forward_read)
rvq=open(FASTQ.Reader, reverse_read)

ds=PairedReads{DNAAlphabet{4}}(fwq, rvq, "ecoliPaired", "ecoliTest", 100, 200, 0, FwRv)

add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{50}, 10, Symbol("ecoliTest"))

remove_tips!(ws, 200)

GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, graph)
