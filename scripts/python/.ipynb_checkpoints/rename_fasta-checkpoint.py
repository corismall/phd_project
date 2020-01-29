import glob 
import os 

files = glob.glob("~/Documents/sequences/ITS/southern_pops/fasta/*.fasta")
strains = 

for file in files:
	path_split = file.split("/")
	strain = path_split[-1].split(".fa")[0]  
	
	old_fasta = open(file, "r")
	old_fastaR = old_fasta.readlines()
	old_fasta.close()
	new_fasta = open(strain + "_formated.fa", "a")
	
	for line in old_fastaR:
		if ">" in line: 
			split1 = line.split(" ")
			head = split1[4] 
			number = split1[5].split(",")[0]
			new_line = ">" + head + number + "\n"
			print new_line
			new_fasta.write(new_line)
			 
		else: 
			new_fasta.write(line)
			pass
		
		print("done") 
			

