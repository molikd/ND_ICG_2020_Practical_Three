#!/usr/bin/env julia
using ArgParse
using GenomeGraphs
using FASTX
using ReadDatastores
#argparse commandline arguments
function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--left"
            help = "trimmed paired fastq file 1"
            required = true
        "--right"
            help = "trimmed paired fastq file 2"
            required = true
        "--out"
            help = "output filename for GFA and fasta"
            required = true
    end

    return parse_args(s)
end


parsed_args = parse_commandline()
println("Parsed args:")
for (arg,val) in parsed_args
  println("  $arg =>  $val")
end
println(typeof(parsed_args))
println(parsed_args["left"])
println(parsed_args["right"])
println(parsed_args["out"])
#end argparse

ws = WorkSpace()
fwq = open(FASTQ.Reader, parsed_args["left"])
rvq = open(FASTQ.Reader, parsed_args["right"])

ds = PairedReads{DNAAlphabet{4}}(fwq, rvq, "ecoli-test-paired", "my-ecoli-test", 75, 400, 0, FwRv)

add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{27}, 10, Symbol("my-ecoli-test"))

remove_tips!(ws, 200)

GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, parsed_args["out"])
