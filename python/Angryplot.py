# -*- coding: utf-8 -*-
"""
Created on Sun Dec  9 23:45:35 2018

@author: jj
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
#%%

import numpy as np
import matplotlib.pyplot as plt
import math

plt.figure(figsize = (8,8),dpi = 100)
x = np.linspace(1.1,22,num=120)
y = 20/(x)

plt.plot(x,y,color = 'k')


plt.xlim(-2,25)
plt.ylim(-0,20)

plt.yticks([2,10],["3","10"])
plt.xticks([2,10],["2","5"])

# 画点
plt.plot(2,10,'o',color = 'royalblue')
plt.plot(10,2,'o',color = 'orange')

#plt.plot(2.23,9,'o',color = 'red')
# 画虚线
Asx = [2,2]
Asy = [-2,10]
Ahx = [-2,2]
Ahy = [10,10]
plt.plot(Asx,Asy,'--',color = 'b')
plt.plot(Ahx,Ahy,'--',color = 'b')

Asx = [10,10]
Asy = [-2,2]
Ahx = [-2,10]
Ahy = [2,2]
plt.plot(Asx,Asy,'--',color = 'gold')
plt.plot(Ahx,Ahy,'--',color = 'gold')

#Asx = [2.23,2.23]
#Asy = [-2,9]
#Ahx = [-2,2.23]
#Ahy = [9,9]
#plt.plot(Asx,Asy,'--',color = 'red')
#plt.plot(Ahx,Ahy,'--',color = 'red')
#hx_x = [2,2.23]
#hx_y = [0.05,0.05]
#hy_x = [-1.9,-1.9]
#hy_y = [9,10]
#plt.plot(hx_x,hx_y,'r-',linewidth = 3)
#plt.plot(hy_x,hy_y,'r-',linewidth = 3)




plt.annotate('A',xy=[2,10],xytext = [3,10],fontsize = 18)
plt.annotate('B',xy = [10,2],xytext =[10,3],fontsize = 18)
#plt.annotate('I1',xy = [15,5],xytext = [15,5],fontsize = 18)



plt.show()


#%%

import numpy as np
import matplotlib.pyplot as plt
import math

plt.figure(figsize = (8,8),dpi = 100)
x = np.linspace(1.1,22,num=120)
y = 20/(x)

plt.plot(x,y,color = 'k')


plt.xlim(-2,25)
plt.ylim(-0,20)

plt.yticks([2,9,10],["3","9","10"])
plt.xticks([2,10],["2","5"])

# 画点
plt.plot(2,10,'o',color = 'royalblue')
plt.plot(10,2,'o',color = 'orange')

plt.plot(2.23,9,'o',color = 'red')
# 画虚线
Asx = [2,2]
Asy = [-2,10]
Ahx = [-2,2]
Ahy = [10,10]
plt.plot(Asx,Asy,'--',color = 'b')
plt.plot(Ahx,Ahy,'--',color = 'b')

Asx = [10,10]
Asy = [-2,2]
Ahx = [-2,10]
Ahy = [2,2]
plt.plot(Asx,Asy,'--',color = 'gold')
plt.plot(Ahx,Ahy,'--',color = 'gold')

Asx = [2.23,2.23]
Asy = [-2,9]
Ahx = [-2,2.23]
Ahy = [9,9]
plt.plot(Asx,Asy,'--',color = 'red')
plt.plot(Ahx,Ahy,'--',color = 'red')
hx_x = [2,2.23]
hx_y = [0.05,0.05]
hy_x = [-1.9,-1.9]
hy_y = [9,10]
plt.plot(hx_x,hx_y,'r-',linewidth = 3)
plt.plot(hy_x,hy_y,'r-',linewidth = 3)




plt.annotate('A',xy=[2,10],xytext = [3,10],fontsize = 18)
plt.annotate('B',xy = [10,2],xytext =[10,3],fontsize = 18)
#plt.annotate('I1',xy = [15,5],xytext = [15,5],fontsize = 18)



plt.show()

#%% 图3

import numpy as np
import matplotlib.pyplot as plt
import math

plt.figure(figsize = (8,8),dpi = 100)
x = np.linspace(1.1,22,num=120)
y = 20/(x)

plt.plot(x,y,color = 'k')


plt.xlim(-2,25)
plt.ylim(-0,20)

plt.yticks([1,2,10],["2","3","10"])
plt.xticks([2,10],["2","5"])

# 画点
plt.plot(2,10,'o',color = 'royalblue')
plt.plot(10,2,'o',color = 'orange')

plt.plot(20,1,'o',color = 'red')
# 画虚线
Asx = [2,2]
Asy = [-2,10]
Ahx = [-2,2]
Ahy = [10,10]
plt.plot(Asx,Asy,'--',color = 'b')
plt.plot(Ahx,Ahy,'--',color = 'b')

Asx = [10,10]
Asy = [-2,2]
Ahx = [-2,10]
Ahy = [2,2]
plt.plot(Asx,Asy,'--',color = 'gold')
plt.plot(Ahx,Ahy,'--',color = 'gold')

Asx = [20,20]
Asy = [-2,1]
Ahx = [-2,20]
Ahy = [1,1]
plt.plot(Asx,Asy,'--',color = 'red')
plt.plot(Ahx,Ahy,'--',color = 'red')
hx_x = [10,20]
hx_y = [0.05,0.05]
hy_x = [-1.9,-1.9]
hy_y = [1,2]
plt.plot(hx_x,hx_y,'r-',linewidth = 3)
plt.plot(hy_x,hy_y,'r-',linewidth = 3)




plt.annotate('A',xy=[2,10],xytext = [3,10],fontsize = 18)
plt.annotate('B',xy = [10,2],xytext =[10,3],fontsize = 18)
#plt.annotate('I1',xy = [15,5],xytext = [15,5],fontsize = 18)



plt.show()