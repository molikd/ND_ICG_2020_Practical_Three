#!/usr/bin/env julia         

using ArgParse
using GenomeGraphs
using FASTX
using ReadDatastores

ws=WorkSpace()

fwq=open(FASTQ.Reader, leftRead)
rvq=open(FASTQ.Reader, rightRead)

ds=PairedReads{DNAAlphabet{4}}(fwq, rvq, "ecoli_test_paired", "ecoli_test", 75, 400, 0, FwRv)

add_paired_reads!(ws,ds)

dbg!(ws, BigDNAMer{27}, 10, Symbol("ecoli_test"))

remove_tips!(ws, 200)

GenomeGraphs.Graphs.write_to_gfa1(ws.sdg, parsed_args["out"])
