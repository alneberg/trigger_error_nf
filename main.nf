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
    do
        cp input.fa output_{\$i}.fa
	echo \$i >> output_{\$i}.fa
    done
    """
}
 
/*
 * Count the lines
 */
process count_lines {
 
    input:
    path x
 
    output:
    stdout
 
    """
    sleep $params.sleepTime;
    wc -l $x
    """
}
 
/*
 * Define the workflow
 */
workflow {
    files_ch = createFile(params.in)
    count_lines(files_ch.flatten())
}
