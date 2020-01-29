file=aln_test.sam	
mv "$file" "${file//aln/As}" 

for file in aln_*.sam ; do 
	mv "$file" "${file//aln/As}" 
done
