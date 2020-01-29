#!/usr/bin/env python
# coding: utf-8

# In[5]:


#remove excess headers

from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

renamed_records = []
same_records = []

for seq_record in SeqIO.parse('/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og.fasta', 'fasta'):
    if seq_record.description.endswith('ab1'):
        print(seq_record.description)
        new_description = str(seq_record.id)
        print(new_description)
        seq_record.description = new_description
        #print(seq_record)
        renamed_records.append(seq_record)
    else:
        print(seq_record.description)
        same_records.append(seq_record)

full_records = same_records + renamed_records
SeqIO.write(full_records, "/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og_renamed.fasta", "fasta")
    
print("done")


# In[ ]:





# In[ ]:





# In[ ]:




