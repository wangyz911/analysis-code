# _*_ coding:utf-8 _*_ 
"""
Created on Fri Dec  4 16:22:52 2020

@author: wangyz911
"""
# 9-3

def avoids(word, bin_letter):
    for b in bin_letter:
        if b in word:
            return False

    return True
        


per =0
count =0
fin  = open('words.txt')
word = fin.readline()
bin_letter = input("please enter 5 letter banlist:")
  
if len(bin_letter)==5:


    while(len(word)!=0):
        if avoids(word,bin_letter):
            per = per+1
        count = count+1
        word = fin.readline()
    ban_per = (1 - per/count)*100
    
    print("ban_letter exclude %f%% words"%(ban_per))
        

