# -*- coding: utf-8 -*-
"""
Created on Fri Dec  4 15:00:35 2020

@author: wangyz911
"""


fin  = open('words.txt')
word = fin.readline()
count = 0
per = 0
while len(word)!=0:
    count = count+1
    if 'e' in word:
        pass
    else:
       print (word)
       per = per+1
    word = fin.readline()
no_e_per = per/count
print('there are  %f words that have no e ' %(no_e_per))



    


