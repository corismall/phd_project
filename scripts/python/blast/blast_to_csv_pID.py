#!/usr/bin/env python
# coding: utf-8

# In[1]:


###write genus and species top hit from xml files to pooled csv file with Query ID, Top hit ID and ID percentage

from Bio.Blast import NCBIXML
from Bio import SearchIO
import glob 
import csv

FILES = glob.glob("/home/corinn/Documents/sequences/ITS/pops/blast_results/all/*.xml")
TEST = glob.glob("/home/corinn/Documents/sequences/ITS/pops/blast_results/S_chilense/*.xml")

with open("/home/corinn/Documents/sequences/ITS/pops/blast_results/all/all_blastresults.csv", mode="w") as output:
    fieldnames = ['Query_ID', 'TopHit_genus', 'TopHit_species', 'Hit_pid']
    writer = csv.DictWriter(output, fieldnames = fieldnames)
    writer.writeheader()
    
    for file in FILES:
        name = file.split("/")[-1].split(".x")[0]
        print(name)
            
        blast_qresult = SearchIO.read(file, "blast-xml")
       # print(blast_qresult)
        tophit = blast_qresult[0]
        tophit_id = tophit.description
        id_ = tophit_id.split(' ')[0:4]
        print(id_)
        genus = id_[0:1][0]
        cf_check = id_[1:2][0]
        if cf_check == 'cf.':
            species = [''.join(id_[1:3])][0]
            print(species)
        else:
            species = id_[1:2][0]
            print(species)
        #print(type(genus))
        #print(type(species))
        
###calculating %id       
        blast_hsp = blast_qresult[0][0]
        #print(blast_hsp)
        alspan = blast_hsp.aln_span
        _id = blast_hsp.ident_num
        gaps = blast_hsp.gap_num
        pid = (_id/(alspan+gaps))*100
        #print(pid)
        
###writing info to csv file
        writer.writerow({'Query_ID':name, 'TopHit_genus':genus, 'TopHit_species':species, 'Hit_pid':pid})
        
print('DONE')    


# In[ ]:




