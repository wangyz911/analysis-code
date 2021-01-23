# -*- coding:UTF-8 -*- 
# -*- coding: gbk -*-
#此python脚本用于提取拱坝坝体部分S22和S33时程 , 得到的txt文件中，第一列为单元编号，第二列该frame中的损伤值
import os, os.path, sys
from odbAccess import *
from abaqusConstants import *
from numpy import *

def Dtiqu(odbname, tpath, tname, *blockNum):
	oname = odbname + '.odb'
	oPath = os.path.join(tpath, oname)
	o = session.openOdb(name=oPath)
	elementlable=[]

	step=o.steps.values()[1]
	for frame in step.frames:
		
		fop = frame.fieldOutputs
		fopD = fop['DAMAGET']

		

		for bnELE in blockNum:
			elementlable.append(bnELE)


		for i in range(len(elementlable)):
			numb=elementlable[i]
			inst1 = o.rootAssembly.instances['PART-1-1']
			ele1 = inst1.getElementFromLabel(label=numb)
			fopDFromEle = fopD.getSubset(region=ele1)
			damaget=[]

			for j in range(len(fopDFromEle.values)):
				damaget.append(fopDFromEle.values[j].data)      
				DAMAGE=mean(damaget)
            
			oFile.write('%d, %11.4E  ' % (elementlable[i].label,DAMAGE))
			oFile.write('\n')
		oFile.close()
		o.close()



if __name__=="__main__":
	Dtiqu('14feng_nomal', 'E:/abaqus/Results/14feng+nomal', 'G1', '39607','447','39608')
    
