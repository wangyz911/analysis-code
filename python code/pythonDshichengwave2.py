# -*- coding:UTF-8 -*- 
# -*- coding: gbk -*-
#´Ëpython½Å±¾ÓÃÓÚÌáÈ¡¹°°Ó°ÓÌå²¿·ÖS22ºÍS33Ê±³Ì , µÃµ½µÄtxtÎÄ¼þÖÐ£¬µÚÒ»ÁÐÎªµ¥Ôª±àºÅ£¬µÚ¶þÁÐÎªS22 µÚÈýÁÐÎªS33
import os, os.path, sys
from odbAccess import *
from abaqusConstants import *
from numpy import *

def Dtiqu(odbname, tname, tpath=None):
    if tpath==None:
        tpath = os.getcwd()  # 返回当前工作目录
    tname0 = tname + '.txt'  #文件名加后缀
    oname = odbname+'.odb'   # odb文件名加后缀
    tFile=os.path.join(tpath,tname0)  # 路径拼接，类似strcat
    oPath=os.path.join(tpath,oname)   # 同上
    f = open(tFile, 'w')             # 打开（创建）txt文件，准备写入
    # oPath = os.path.join(tpath,oname) #怎么又拼接了一遍

#    o = openOdb(path=oPath)
    o = session.openOdb(name=oPath)  # 按oPath路径打开odb文件
    setXE = o.rootAssembly.elementSets['EBATI'] # 与循环无关, 搬出循环
    element = setXE.elements[0]                 # element 取上面的第一项
    inst1 = o.rootAssembly.instances['PART-1-1']               # 与循环无关，inst1 是odb 文件中的根组装实例['PART-1-1']项对应的值（同样是字典）
    step=o.steps.values()[2]         # step赋值为odb文件o中steps的值，即从odb文件中提取步数
    for frame in step.frames:        # 从step 中提取帧数，作为循环次数，frame作为循环变量
        fop = frame.fieldOutputs    # 每帧中的场输出数据赋值给fop.
        fopD = fop['DAMAGET']        # fop是字典，这里fopd得到fop中的DAMAGET项对应的值 

        for i in range(len(element)):                                  # 测量element的长度.
            numb=element[i].label                                      # numb 是第i个元素的label
            ele1 = inst1.getElementFromLabel(label=numb)               # ele1 是inst1中方法的标记
            fopDFromEle = fopD.getSubset(region=ele1)                  # 从fopD 中提取getsubset                                                            
            fDFEv = fopDFromEle.values
            damaget=[0]*len(fDFEv)                       # 创建damaget数租为空，后面添加值（这里非常耗时间，最好是预先设置好数组大小）
            for j in range(len(fDFEv)):                   # 测量fopDFromEle 值的长度，作为循环次数
                damaget[j]=fDFEv[j].data             # 在每个values后面附上数据，既然每次都清空，不能直接等于嘛？
            DAMAGE=mean(damaget)                                       # DAMAGE 等于这么多damaget的均值？
            
            f.write('%d, %11.4E  ' % (numb,DAMAGE))        # 向文件中写入第i个元素.标签，然后是DAMAGE值
            f.write('\n')                                             # 回车！
    f.close()
    o.close()



if __name__=="__main__":
    Dtiqu(odbname='30feng_wave1_1', tname='wave10DT1')
    Dtiqu(odbname='30feng_wave1_2', tname='wave10DT2')
    Dtiqu(odbname='30feng_wave1_3', tname='wave10DT3')
    Dtiqu(odbname='30feng_wave1_4', tname='wave10DT4')
    Dtiqu(odbname='30feng_wave1_5', tname='wave10DT5')
    Dtiqu(odbname='30feng_wave1_6', tname='wave10DT6')
    Dtiqu(odbname='30feng_wave1_7', tname='wave10DT7')
    Dtiqu(odbname='30feng_wave1_8', tname='wave10DT8')
    Dtiqu(odbname='30feng_wave1_9', tname='wave10DT9')
    Dtiqu(odbname='30feng_wave1_10', tname='wave10DT10')
    Dtiqu(odbname='30feng_wave1_11', tname='wave10DT11')
    Dtiqu(odbname='30feng_wave1_12', tname='wave10DT12')
