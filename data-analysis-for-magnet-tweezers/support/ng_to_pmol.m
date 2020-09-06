function [ pmol ] = ng_to_pmol( ng, kb )

%本函数用来计算PCR 制出的DNA 的浓度换算，从ng/uL 换算为pmol/L
%  具体换算公式是，对1kb的双链DNA，1ng/uL = 1ug/mL = 1.52pmol/mL = 1600pmol/L =1600pM
pmol = ng*1520/kb;

end

