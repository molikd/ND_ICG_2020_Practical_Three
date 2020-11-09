#!/usr/bin/env julia         

#$ -M nvincen2@nd.edu
#$ -m abe
#$ -N julia-debruijn

using ArgParse
using GenomeGraphs
using FASTX
using ReadDatastores
using Graphs

s = ArgParseSettings()
@add_arg_table! s begin
	"--left"
	"--right"
	"--pwork1"
	"--pwork2"
	"--out"
end

parsed_args = parse_args(ARGS, s)

left_read = parsed_args["left"]
right_read = parsed_args["right"]
working1 = parsed_args["pwork1"]
working2 = parsed_args["pwork2"]
output = parsed_args["out"]

ws=WorkSpace()

fwq=open(FASTQ.Reader, left_read)
rvq=open(FASTQ.Reader, right_read)

ds=PairedReads{DNAAlphabet{4}}(fwq, rvq, working1, working2, 75, 400, 0, FwRv)

add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{27}, 10, Symbol(working2))

remove_tips!(ws, 200)

GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, output)
