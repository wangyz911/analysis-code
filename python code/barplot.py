# -*- coding: utf-8 -*-
"""
Created on Wed Nov 28 11:22:19 2018

@author: Administrator
"""
# Credit: Josh Hemann

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
from collections import namedtuple

# 柱状图实例
n_groups = 5

means_men = (20, 35, -30, 35, 27)
std_men = (2, 3, 4, 1, 2)

means_women = (25, 32, 34, 20, 25)
std_women = (3, 5, 2, 3, 3)

fig, ax = plt.subplots()

index = np.arange(n_groups)
bar_width = 0.35

opacity = 0.4
error_config = {'ecolor': '0.3','capsize':6}

rects1 = ax.bar(index, means_men, bar_width,
                alpha=opacity, color='b',
                yerr=std_men, error_kw=error_config,
                label='Men')

rects2 = ax.bar(index + bar_width, means_women, bar_width,
                alpha=opacity, color='r',
                yerr=std_women, error_kw=error_config,
                label='Women')

ax.set_xlabel('Group')
ax.set_ylabel('Scores')
ax.set_title('Scores by group and gender')
ax.set_xticks(index + bar_width / 2)
ax.set_xticklabels(('A', 'B', 'C', 'D', 'E'))
ax.legend()

fig.tight_layout()
plt.show()


#%% 散点图带误差bar 

n_groups = 5

means_men = (20, 35, -30, 35, 27)
std_men = (2, 3, 4, 1, 2)

means_women = (25, 32, 34, 20, 25)
std_women = (3, 5, 2, 3, 3)
fig, ax = plt.subplots()

index = np.arange(n_groups)
plt.errorbar(index, means_men, yerr=std_men, fmt='o', color='#a2bffe',
             ecolor='lightgray', elinewidth=3, capsize=6);


plt.errorbar(index, means_women, yerr=std_women, fmt='D', color='#69d84f',
             ecolor='lightgray', elinewidth=3, capsize=6);


#%% 做回归散点图
import numpy
import sys
from pandas import read_csv
from matplotlib import pyplot as plt
from sklearn.linear_model import LinearRegression

x = (0.001331,0.002897,0.004668,0.006709,0.009301,0.012028,0.014305,0.016927,0.019625,0.022737,0.026236,0.029257,0.032576,0.035846,0.039905,0.044788,0.048461,0.052660,0.058523,0.067900,0.081455,0.092402,0.101934,0.110978,0.119912,0.131905,0.144245,0.156479,0.167734,0.180753,0.205635,0.227216,0.242944,0.254770,0.270856,0.287661,0.302940,0.326034,0.360129,0.393936,0.428214,0.460803,0.494309,0.527741,0.565193,0.601683,0.684160,0.825006,0.955951,1.316580)
y = (0.164079,0.108148,0.122866,0.130559,0.117257,0.123740,0.137873,0.126917,0.160705,0.105194,0.106471,0.156517,0.135408,0.126163,0.155663,0.145487,0.146039,0.109620,0.093757,0.100647,0.093466,0.066866,0.115678,0.143715,0.084677,0.158468,0.124973,0.096755,0.138159,0.164422,0.103837,0.084664,0.152047,0.110161,0.169354,0.142309,0.157848,0.140937,0.148297,0.168786,0.137521,0.189816,0.123808,0.150548,0.163103,0.168323,0.119274,0.103970,0.164860,0.221843)
fit_y = (0.122365,0.122442,0.122529,0.122629,0.122756,0.122889,0.123001,0.123129,0.123262,0.123414,0.123586,0.123734,0.123896,0.124056,0.124255,0.124495,0.124675,0.124880,0.125168,0.125627,0.126291,0.126828,0.127295,0.127738,0.128176,0.128763,0.129368,0.129967,0.130519,0.131157,0.132376,0.133434,0.134204,0.134784,0.135572,0.136395,0.137144,0.138276,0.139946,0.141603,0.143282,0.144879,0.146521,0.148159,0.149994,0.151782,0.155824,0.162725,0.169142,0.186812)


#画出散点图，求x和y的相关系数
plt.scatter(x,y)
plt.plot(x,fit_y,'b--')


#估计模型参数，建立回归模型
'''
(1) 首先导入简单线性回归的求解类LinearRegression
(2) 然后使用该类进行建模，得到lrModel的模型变量
'''

lrModel = LinearRegression()
#(3) 接着，我们把自变量和因变量选择出来


#模型训练
'''
调用模型的fit方法，对模型进行训练
这个训练过程就是参数求解的过程
并对模型进行拟合
'''
fit_xy = lrModel.fit(x,y)

#对回归模型进行检验
lrModel.score(x,y)

#利用回归模型进行预测
lrModel.predict([[60],[70]])

#查看截距
alpha = lrModel.intercept_[0]

#查看参数
beta = lrModel.coef_[0][0]

alpha + beta*numpy.array([60,70])


#%%  画散点图带不对称误差 fig 2a


import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
plt.figure(figsize=(12,5), dpi=80)
n_groups = 6;
data = (0.08,0.08,0.05,0.23,0.09,0.03)
#yr =np.array( [[0.03,0.08,0.26,0.02,0.04,0.09],
#      [0.03,0.09,0.26,0.02,0.05,0.08]])
yr = (0.08,0.05,0.02,0.26,0.09,0.03)

zero = (0,0)
x0 = (-0.5,6)
index = np.arange(n_groups)

bar_width = 0.35
opacity = 1
error_config = {'ecolor': '0.3','capsize':4}

plt.subplot(1,2,1)
rects1 = plt.barh(index, data, bar_width,
                alpha=opacity, color='royalblue',
                xerr=yr, error_kw=error_config,
                label='coefficient')

A=plt.errorbar( data,index, xerr=yr, fmt='.', 
             ecolor='k', elinewidth=1, capsize=4,markersize=1,label="95% confidence interval");
ax = plt.gca()
         
B=plt.plot(zero,x0,'--',color='k',linewidth=2)
ax.set_title("△ Preference",fontsize=16)
ax.set_yticks(index + bar_width / 2)
ax.set_yticklabels((" △individualism", "△collectivism", "△trust", "△time","△risk2","△risk1"))
ax.set_xticks([0.000,0.100,0.200,0.300,0.400,0.500])
ax.set_xticklabels((" 0.000", "0.100", "0.200", "0.300","0.400","0.500"))

ax.legend(loc='center', bbox_to_anchor=(0.51, -0.15),ncol=2)
plt.ylim(-0.5,6)
#plt.show()

# fig 2b
n_groups2 = 5
#x2 =  [[0],[1],[2],[3],[4]]

data2 = (0.06,0.12,0.06,0.04,0.02)


yr2 = (0.04,0.05,0.03,0.022,0.02)
zero2 = (0,0)
x02 = (-0.5,5)
index2 = np.arange(n_groups2)

bar_width = 0.35
opacity = 1
error_config = {'ecolor': '0.3','capsize':4}

plt.subplot(1,2,2)
rects1 = plt.barh(index2, data2, bar_width,
                alpha=opacity, color='royalblue',
                xerr=yr2, error_kw=error_config,
                label='coefficient')
A=plt.errorbar( data2,index2, xerr=yr2, fmt='.', 
             ecolor='k', elinewidth=1, capsize=4,markersize=1,label="95% confidence interval");
ax = plt.gca()
         
B=plt.plot(zero2,x02,'--',color='k',linewidth=2)
ax.set_title("△ Behavior",fontsize=16)
ax.set_yticks(index + bar_width / 2)
ax.set_yticklabels((" △ donation", "△ neighborhood", "△ alcohol", "△ savings rate","△ entrepreneurship"))
ax.legend(loc='center', bbox_to_anchor=(0.51, -0.15),ncol=2)
plt.xlim(-0.02,0.2)
plt.ylim(-0.5,5)
# 调节子图间距
plt.subplots_adjust(left=None, bottom=None, right=None, top=None,
                wspace=0.4, hspace=None)

fig = plt.gcf()
plt.figtext(0.08,0.9,'a', fontsize=18, fontweight='bold')
plt.figtext(0.54,0.9,'b', fontsize=18, fontweight='bold')
plt.show()

plt.savefig('D:\\fig2b.png',format='png')  #建议保存为svg格式，再用inkscape转为矢量图emf后插入word中
## %% fig 3a
#xm =  [[1],[3],[5],[7],[9],[11]]
#xf =  [[2],[4],[6],[8],[10],[12]]
#x3 = [[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]]
#y_m = [[0.03],[0.03],[-0.14],[0.03],[0.07],[0.01]]
#y_f = [[0.04],[0.13],[-0.35],[0.06],[0.05],[-0.02]]
#
#yr_m=np.array([[0.03,0.1,0.16,0.02,0.06,0.1],
#              [0.04,0.11,0.17,0.02,0.05,0.1]])
#yr_f=np.array([[0.04,0.07,0.27,0.02,0.06,0.15],
#                [0.05,0.08,0.27,0.03,0.07,0.15]])
#zero3 = [0,0,0,0,0,0,0,0,0,0,0,0]
#A_m=plt.errorbar(y_m,xm, xerr=yr_m, fmt='.', color='#548d44',
#             ecolor='gray', elinewidth=2, capsize=6,markersize=1,label="95% confidence_m");
#A_f=plt.errorbar( y_f,xf, xerr=yr_f, fmt='.', color='#fe01b1',
#             ecolor='gray', elinewidth=2, capsize=6,markersize=1,label="95% confidence_f");             
##C_m = plt.scatter(xm,y_m,color='#548d44',label ="male")
##C_f = plt.scatter(xf,y_f,color='#fe01b1',label ="female")                
#B_m=plt.plot(zero3,x3,'--',color='#3e82fc',linewidth=2,label = "zero2")
#plt.xticks(fontsize = 10)
#plt.yticks([1.5,3.5,5.5,7.5,9.5,11.5],
#           ["D_{risk1}", "D_{risk2}", "D_{time}", "D_{trust}", "D_{collectivism}"," D_{individualism}" ],fontsize=10,rotation=0)
#plt.title("Behavior",fontsize=16)
#
##plt.ylim(-0.2, 0.5)
#
#
#xmb= (1,3,5,7,9,11)
#ymb = (0.03,0.03,-0.14,0.03,0.07,0.01)
#xfb = (2,4,6,8,10,12)
#yfb = (0.04,0.13,-0.35,0.06,0.05,-0.02)
#
#plt.barh(xmb,ymb,color='#548d44',label ="male")
#plt.barh(xfb,yfb,color='#fe01b1',label ="female")
#plt.legend()
#
#plt.show()

# %% 柱状图实例  zuizhong fig3a
plt.figure(figsize=(14, 4.5), dpi=300)
n_groups = 6

means_men = (0.01,0.07,0.03,-0.14,0.03,0.03)
std_men = (0.1,0.06,0.02,0.16,0.1,0.03)

means_women = (-0.02,0.05,0.06,-0.35,0.13,0.04)
std_women = (0.15,0.06,0.02,0.27,0.07,0.04)

x3 = [[-0.5],[1],[2],[3],[4],[5],[6]]
zero3 = [0,0,0,0,0,0,0]
plt.subplot(1,2,1)

index = np.arange(n_groups)
bar_width = 0.35

opacity = 0.6
error_config = {'ecolor': '0.3','capsize':4}
rects1 = plt.barh(index+ bar_width, means_men, bar_width,
                alpha=opacity, color='b',
                xerr=std_men, error_kw=error_config,
                label='Male')
rects2 = plt.barh(index, means_women, bar_width,
                alpha=opacity, color='r',
                xerr=std_women, error_kw=error_config,
                label='Female')


B_m=plt.plot(zero3,x3,'--',color='k',linewidth=2)

A_f=plt.errorbar( means_women,index, xerr=std_women, fmt='.',
                 ecolor='0.3', elinewidth=1, capsize=4,markersize=1,label="95% confidence interval");  
#ax.set_xlabel('Group')
#ax.set_ylabel('Scores')
ax = plt.gca()
ax.set_title("△ Preference",fontsize=16)
ax.set_xticks([-0.6,-0.4,-0.2,-0.0,0.2])
ax.set_xticklabels(("-0.60","-0.40","-0.20","-0.00","0.20"))
ax.set_yticks(index + bar_width / 2)
ax.set_yticklabels((" △ individualism", "△ collectivism", "△ trust", "△ time","△ risk2","△ risk1"))
ax.legend(loc='center left', bbox_to_anchor=(-0.03, -0.2),ncol=3)
plt.gcf()
ax.annotate("**",(0.25,2.1),fontsize = "16",rotation = 90)
ax.annotate("]",(0.2,2),fontsize = "24")
ax.annotate("**",(0.25,3.1),fontsize = "16",rotation = 90)
ax.annotate("]",(0.2,3),fontsize = "24")
plt.xlim(-0.65,0.3)
plt.ylim(-0.5, 6)
fig.tight_layout()
#plt.show()
fig = plt.gcf()
plt.figtext(0.08,0.9,'a', fontsize=18, fontweight='bold')
plt.figtext(0.54,0.9,'b', fontsize=18, fontweight='bold')
#%  fig 3b 
n_groups = 5


#y_m = [[0.02],[0.03],[0.02],[0.07],[0.05]]
y_m = (0.05,0.07,0.02,0.03,0.02)
#y_f = [[0.04],[0.05],[0.07],[0.15],[0.04]]
y_f = (0.04,0.15,0.07,0.05,0.04)

yr_m=(0.04,0.06,0.04,0.02,0.02)

yr_f=(0.05,0.07,0.03,0.02,0.06)

index = np.arange(n_groups)
zero3 = (0,0)
x3 = (-1,5.5)
bar_width = 0.35

opacity = 0.6
error_config = {'ecolor': '0.3','capsize':4}
plt.subplot(1,2,2)
rects1 = plt.barh(index+ bar_width, y_m, bar_width,
                alpha=opacity, color='b',
                xerr=yr_m, error_kw=error_config,
                label='Male')
rects2 = plt.barh(index, y_f, bar_width,
                alpha=opacity, color='r',
                xerr=yr_f, error_kw=error_config,
                label='Female')
A_f=plt.errorbar( y_f,index, xerr=yr_f, fmt='.',
                 ecolor='0.3', elinewidth=1, capsize=4,markersize=1,label="95% confidence interval");  
      
#C_m = plt.scatter(xm,y_m,color='#548d44',label ="male")
#C_f = plt.scatter(xf,y_f,color='#fe01b1',label ="female")                
B_m=plt.plot(zero3,x3,'--',color='k',linewidth=2)
             
ax=plt.gca()             
ax.set_title("△ Behavior",fontsize=16)
ax.set_yticks(index + bar_width / 2)
ax.set_yticklabels((" △ donation", "△ neighborhood", "△ alcohol", "△ savings rate","△ entrepreneurship"))

ax.annotate("**",(0.25,1.1),fontsize = "16",rotation = 90)
ax.annotate("]",(0.23,1),fontsize = "24")
ax.annotate("**",(0.25,2.1),fontsize = "16",rotation = 90)
ax.annotate("]",(0.23,2),fontsize = "24")
ax.legend(loc='center left', bbox_to_anchor=(-0.03, -0.2),ncol=3)
plt.ylim(-1,5.5)
plt.xlim(-0.04,0.29)
#plt.ylim(-0.2, 0.5)
plt.subplots_adjust(left=None, bottom=None, right=None, top=None,
                wspace=0.5, hspace=None)

foo_fig = plt.gcf() # 'get current figure'
foo_fig.savefig('fig3.svg', format='svg', dpi=300)

plt.show()


#%% 图片格式转换











             
