#!/usr/bin/env python
# coding: utf-8

# In[7]:


# run blast on generated fasta sequences, make sure paths are correct! Sequence input for blast written in dictionary

from Bio import SeqIO
from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML
from Bio import SearchIO
import glob 
import csv


blastdir = "/home/corinn/Documents/sequences/ITS/pops/blast_results/all/"

seq_dict = {}

#appending sequences to dictionary
for seq in SeqIO.parse("/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og_renamed.fasta", "fasta"): 
    _id = seq.id
    #print(_id)
    #print(type(_id))
    s = seq.seq
    seq_dict[_id] = s
    
print(len(seq_dict))

for key, value in seq_dict.items():
    print(key)
    result = NCBIWWW.qblast("blastn", "nt", value)
    with open(blastdir + key + ".xml", "w") as out_handle:
        out_handle.write(result.read())
        result.close()
print("done")


# In[ ]:





# In[ ]:




