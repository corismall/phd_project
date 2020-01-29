#!/bin/bash

HOME=/mnt/corinn/
REF=/mnt/AlternariaSolaniReferences/NL03003.fasta
READS=/mnt/RawSamples/
STRAIN=$HOME/AlternariaRawSeq/*/
ALN_F=$HOME/AlternariaMapped/
MAP_B=$HOME/AlternariaMapped/*.bam
STRAIN_ready=$HOME/Samples.Bam.and.vcf.files/sortedbams


#align reads to reference
for folder in $STRAIN;do
	NAME=$(basename "$folder")
	echo $NAME
	echo $folder
	OUTPUT=aln_$NAME.sam
	echo $OUTPUT
	bwa mem -t 34 -R '@RG\tID:As_{$NAME}\tSM:As_{$NAME}' $REF $folder/*_1.fq.gz $folder/*_2.fq.gz > $OUTPUT
	mv $OUTPUT $ALN_F
done
echo "Reads aligned to reference"



#sam to bam conversion
for file in $MAP_F;do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.sam}.bam
	echo $OUTPUT
	samtools view -S -b $file > $OUTPUT
done
echo "Sam files converted to bam files"

#mark duplicates
for FILE in $STRAINS; do
	NAME=$(basename "$FILE")
	NAME=${NAME%.sorted.bam}
	echo $NAME
	gatk MarkDuplicatesSpark -I $FILE -O marked_duplicates.bam
done 
echo "Duplicates marked"

#sorting duplicate-marked bam files
for file in $MAP_B;do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.bam}.dedup.sorted.bam
	echo $OUTPUT
	java -jar /home/ubuntu/tools/picard/build/libs/picard.jar SortSam R=$REF O=$OUTPUT
done
echo "Bam files sorted"      


 
####indel realignment/base recalibration not needed for alternaria

#index reference
NAME=$(basename "$REF")
NAME=${NAME%.fasta}
echo $NAME
samtools faidx NL03003.fasta

#run gatk haplotypecaller, gvcfs
for FILE in $STRAIN;do
	NAME=$(basename "$FILE")
	NAME=${NAME%.dedup.sorted.bam}
	echo $NAME
	java -jar GenomeAnalysisTK.jar -R $REF -T HaplotypeCaller -I sample1.bam [-I sample2.bam ...][--dbsnp dbSNP.vcf][-stand_call_conf 30][-L targets.interval_list] -o output.raw.snps.indels.vcf

	#gatk --java-options "-Xmx16G" HaplotypeCaller --ploidy 1 --max-alternate-alleles 6 --native-pair-hmm-threads 10 -R $REF -I $FILE -O $NAME.raw.vcf 
done
java -jar GenomeAnalysisTK.jar -R reference.fasta -T HaplotypeCaller -I sample1.bam [-I sample2.bam ...][--dbsnp dbSNP.vcf][-stand_call_conf 30][-L targets.interval_list] -o output.raw.snps.indels.vcf
#merge gvcfs
