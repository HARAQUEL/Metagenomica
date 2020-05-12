## Tutorial de AMPtk con datos de ITS2 (hongos) generados por Illumina MiSeq
##Raquel Hernández Austria Mayo de 2020

#Conectarnos al cluster de CONABIO ssh -p 45789 cirio@200.12.166.164
#Desde nuestra carpeta, en mi caso "raquelha" trabajaremos con los datos que están en metagenomica/fastq

#1. Pre-processing FASTQ files

#En ese paso se ensamblan los reads forward y reverse, además de eliminar los primers y secuencias cortas.

amptk illumina -i ../metagenomica/fastq -o amptk/ -f GTGARTCATCRARTYTTTG -r CCTSCSCTTANTDATATGC -l 300 --min_len 200 --full_length --cleanup

#-i, input folder with FASTQ files

#-o, output name

#-f, forward primer sequence (here: gITS7ngs)

#-r, -reverse primer sequence (here: ITS4ngsUni)

#-l, lenght of reads (here: 300 bp)

#--min_len, minimum length to keep a sequence (here: 200 pb)

#--full_length, keep only full length sequences

#--cleanup, remove intermediate files

#2. Clustering at 97% similarity with UPARSE
#En ese paso se hace un filtro de calidad y se agrupan las secuencias en OTUs

amptk cluster -i amptk.demux.fq.gz -o cluster -m 2 --uchime_ref ITS

#-i, input folder with paired sequences

#-o, output name

#-m, minimum number of reads for valid OTU to be retained (singleton filter)

#--uchime_ref, run chimera filtering (ITS, LSU, COI, 16S, custom path)

#3. Filtering the OTU table (index bleed)
#Index bleed = reads asignados a la muestra incorrecta durante el proceso de secuenciación; 
#es frecuente y además con un grado variable entre varios runs. En ese paso, 
#se puede usar un control positivo (mock) artificial para medir el grado de index bleed dentro de un run. 
#Si el run no incluyó un mock artificial, este umbral se puede definir manualmente (en general se usa 0,005%).

amptk filter -i cluster.otu_table.txt -o filter -f cluster.cluster.otus.fa -p 0.005 --min_reads_otu 2

#-i, input OTU table

#-o, output name

#-f, fasta file with reference sequence for each OTU

#-p, % index bleed threshold between samples (if not calculated)

#--min_reads_otu, minimum number of reads for valid OTU to be retained (singleton filter)

#4. Assign taxonomy to each OTU
#AMPtk utiliza la base de datos de secuencias de UNITE (https://unite.ut.ee/) para asignar la taxonomía de los OTUs. 
#Dado que es una base de datos curada, en general da resultados mucho mejores que GenBank (por ejemplo usando QIMME).

amptk taxonomy -i filter.final.txt -o taxonomy -f filter.filtered.otus.fa -m ../metagenomica/amptk.mapping_file.txt -d ITS2 --tax_filter Fungi

#-i, input OTU table

#-o, output name

#-f, fasta file with reference sequence for each OTU

#-m, mapping file with meta-data associated with the samples

#-d, pre-installed database [ITS1, ITS2, ITS, 16S LSU, COI]

#--tax_filter, remove OTUs that do not match filter, i.e. Fungi to keep only fungi
