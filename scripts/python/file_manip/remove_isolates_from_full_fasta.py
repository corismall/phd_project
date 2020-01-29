#!/usr/bin/env python
# coding: utf-8

# In[11]:


#remove fasta sequences (from contaminated wells, duplicates, etc)

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

removed_records = ["KY105066.1","344","KP192561.1","119","322", "316", "320", '323', '324', '326', '400', '402', '318', '321', '327', '411', '410', 
                   '340', '342', '343', '414', '77', '84', '82', '170', 'AMRR01002641.1', '100', '99', '95']
kept_records = []

for seq_record in SeqIO.parse('/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_ambiguouswells_dups.fasta', 'fasta'):
    print(seq_record.id)
    if seq_record.id not in removed_records:
        kept_records.append(seq_record)
        print(seq_record.id)
SeqIO.write(kept_records, "/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og.fasta", "fasta")


# In[ ]:




