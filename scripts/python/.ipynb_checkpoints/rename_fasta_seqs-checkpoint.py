#!/usr/bin/env python
# coding: utf-8

# In[96]:


import pandas as pd
import numpy as np

cols = ['A','B','C','D','E','F','G','H']
box1 = pd.read_csv('/home/corinn/Documents/lab/DNA_extractions/dna_extract_96wellplates_box1.csv', 
            names = cols)
#print(box1)
#if box1.columns =!
box1.A = box1.A.astype(str)
box1.B = box1.B.astype(str)
box1.C = box1.C.astype(str)
box1.F = box1.F.astype(str)
box1.H = box1.H.astype(str)

#box_coords = box1['A'][0]
print(box1)
print(box1.dtypes)


# In[97]:


from Bio import SeqIO
for seq_record in SeqIO.parse('/home/corinn/Documents/sequences/ITS/southern_pops/fasta/full.fasta', 'fasta'):
    #print(seq_record.id)
    box = seq_record.id[3:6]
    if seq_record.id.startswith('FN'):
        coord = seq_record.id.split('_')[4]
        well_col = str(coord[0:1])
        well_row = int(coord[1:])-1
        print(coord, well_col, well_row)
        iso = box1[well_col][well_row]
        print(iso)


# In[ ]:




