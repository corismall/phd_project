#!/usr/bin/env python
# coding: utf-8

# In[54]:


import pandas as pd
import numpy as np

cols = ['A','B','C','D','E','F','G','H']
box1 = pd.read_csv('/home/corinn/Documents/lab/DNA_extractions/dna_extract_96wellplates_box1.csv', 
            names = cols)
box2 = pd.read_csv('/home/corinn/Documents/lab/DNA_extractions/dna_extract_96wellplates_box2.csv', 
            names = cols)

box1 = box1.astype(str)
box2 = box2.astype(str)

#box_coords = box1['A'][0]
print("done")

#print(box1)
#print(box2)
#print(box1.dtypes)
#print(box2.dtypes)


# In[56]:


from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

renamed_records = []
same_records = []

for seq_record in SeqIO.parse('/home/corinn/Documents/sequences/ITS/southern_pops/fasta/full.fasta', 'fasta'):
    box = seq_record.id[3:6]
    if seq_record.id.startswith('FN_pl1'):
        #print(seq_record)
        coord = seq_record.id.split('_')[4]
        well_col = str(coord[0:1])
        well_row = int(coord[1:])-1
        iso1 = box1[well_col][well_row]
        print("box1" + coord, well_col, well_row, iso1)
        seq_record.id = iso1
        #print(seq_record.id)
        #print(seq_record)
        renamed_records.append(seq_record)
        
    elif seq_record.id.startswith('FN_pl2'):
        #print(seq_record)
        coord = seq_record.id.split('_')[4]
        well_col = str(coord[0:1])
        well_row = int(coord[1:])-1
        iso2 = box2[well_col][well_row]
        print("box2" + coord, well_col, well_row, iso2)
        seq_record.id = iso2
        #print(seq_record.id)
        #print(seq_record)
        renamed_records.append(seq_record)
    
    
    else: 
        same_records.append(seq_record)
                
full_records = same_records + renamed_records
SeqIO.write(full_records, "/home/corinn/Documents/sequences/ITS/southern_pops/fasta/full_renamed.fasta", "fasta")

#print("Full " + "\n" + str(full_records))
#print("Renamed " + "\n" + str(renamed_records))
#print("Same" + "\n" + str(same_records))
print("done") 


# In[ ]:




