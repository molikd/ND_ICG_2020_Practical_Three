#!/usr/bin/env julia         


#$ -M sweaver4@nd.edu
#$ -m abe
#$ -N Julia_dbj_assem


using ArgParse
using FASTX
using GenomeGraphs
using ReadDatastores
using Graphs


s = ArgParseSettings()
@add_arg_table! s begin
	"--input1"
	"--input2"
	"--output1"
	"--output2"
	"--output3"
end

parsed_args = parse_args(ARGS, s)

input_file_1 = parsed_args["input1"]
input_file_2 = parsed_args["input2"]
output_file_1 = parsed_args["output1"]
output_file_2 = parsed_args["output2"]
output_file_3 = parsed_args["output3"]

ws = WorkSpace()

fwq = open(FASTQ.Reader, input_file_1)
rvq = open(FASTQ.Reader, input_file_2)

ds = PairedReads{DNAAlphabet{4}}(fwq, rvq, output_file_1, output_file_2, 100, 200, 0, FwRv)

add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{50}, 10, Symbol(output_file_2))

remove_tips!(ws, 200)

GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, output_file_3)

