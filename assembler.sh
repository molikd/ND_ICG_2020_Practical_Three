#!/bin/bash
#$ -M svandext@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N BIOS60132_Practical_Three

module load bio/2.0

for infile in /afs/crc.nd.edu/user/s/svandext/Private/ICG2020/ICG_18_Aug/*_1.fastq.gz
do
        base = $(basename ${infile} _1.fastq.gz) \
        trimmomatic PE -threads 8 ${infile} ${base}_2.fastq.gz \
        ${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
        ${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
        SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
done

#!/bin/env julia

using FASTX
using GenomeGraphs
using ReadDatastores
using ArgParse

function parse_commandline()
        s = ArgParseSettings()
        @add_arg_table! s begin
                "--Forward_Read"
                help = "*_1.trim.fastq"
                "--Reverse_Read"
                help = "*_2.trim.fastq"
                "--out"
                help = "output file name"
        end

        return parse_args()
end

parsed_args = parse_commandline()
println("Parsed args:")
    for (arg,val) in parsed_args
        println("  $arg  =>  $val")
    end
println(typeof(parsed_args))
println(parsed_args["left"])
println(parsed_args["right"])
println(parsed_args["out"])

ws = WorkSpace()

fwq = open(FASTQ.Reader, parsed_args["Forward_Read"])
rvq = open(FASTQ.Reader, parsed_args["Reverse_Read"])

ds = PairedReads{DNAAlphabet{4}}(fwq, rvq, "ecoli-test-paired", "my-ecoli-test", 75, 400, 0, FwRv)

