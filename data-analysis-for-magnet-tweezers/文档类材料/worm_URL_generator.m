clc;
%% 所有URL 都相同的部分如下
head_string = 'http://zzys.agri.gov.cn/nongqingxm_result.aspx?year=2016,2015,2014,2013,2012,2011,2010,2009,2008,2007,2006,2005,2004,2003,2002,2001,2000,1999,1998,1997,1996,1995,1994,1993,1992,1991,1990,1989,1988,1987,1986,1985,1984,1983,1982,1981,1980,1979,1978,1977,1976,1975,1974,1973,1972,1971,1970,1969,1968,1967,1966,1965,1964,1963,1962,1961,1960,1959,1958,1957,1956,1955,1954,1953,1952,1951,1950,1949&prov=13%20%20%20';
end_string = '&item=01&type=1&radio=1&order1=year_code&order2=area_code&order3=item_code';
display('请输入第一县市编号')
pro_start = str2double(input('p. = ','s'));
display('请输入最后的县市编号')
pro_end = str2double(input('p NO. = ','s'));
p_no = pro_end - pro_start +1;
zuo_wu = 1;
n = 0;
p_cell = cell(p_no,1);

for i = 1:p_no
    p_cell{i,1} = strcat(head_string,'&area=',num2str(pro_start),end_string);

    pro_start = pro_start+1;
end



