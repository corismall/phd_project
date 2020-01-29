#!/usr/bin/env python
# coding: utf-8

# In[2]:


from Bio.Align.Applications import MafftCommandline

mafft_exe = "/usr/bin/mafft"
in_file = "/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og_renamed.fasta"
mafft_cline = MafftCommandline(mafft_exe, input = in_file)
mafft_cline.adjustdirection = True
mafft_cline.globalpair = True
print(mafft_cline)
stdout, stderr = mafft_cline()
output_loc = "/home/corinn/Documents/sequences/ITS/pops/fasta/"
output_prefix = in_file.split("/")[-1].split(".")[0]
output = output_loc + output_prefix + "mafft.fasta"
with open(output, 'w') as handle:
    handle.write(stdout)
print("DONE")


# In[ ]:




