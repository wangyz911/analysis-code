function [ pmol ] = ng_to_pmol( ng, kb )

%��������������PCR �Ƴ���DNA ��Ũ�Ȼ��㣬��ng/uL ����Ϊpmol/L
%  ���廻�㹫ʽ�ǣ���1kb��˫��DNA��1ng/uL = 1ug/mL = 1.52pmol/mL = 1600pmol/L =1600pM
pmol = ng*1520/kb;

end

