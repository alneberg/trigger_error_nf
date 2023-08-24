#!/usr/bin/env nextflow
 
params.in = "$baseDir/data/sample.fa"
 
/*
 * Split a fasta file into multiple files
 */
process createFile {
 
    input:
    path 'input.fa'
 
    output:
    path 'output_*.fa'
 
    """
    for i in {1..$params.numFiles}
        cp input.fa output_{i}.fa
    """
}
 
/*
 * Reverse the sequences
 */
process reverse {
 
    input:
    path x
 
    output:
    stdout
 
    """
    wc -l $x
    """
}
 
/*
 * Define the workflow
 */
workflow {
    splitSequences(params.in) \
      | reverse \
      | view
}