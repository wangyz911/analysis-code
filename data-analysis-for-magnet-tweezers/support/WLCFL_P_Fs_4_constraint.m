function [fitresult, gof] = WLCFL_P_Fs_4_constraint(F, l,StartPoint,Lower,Upper)
    
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );  
    opts.Display = 'Off';
    opts.Lower = Lower;
    opts.StartPoint = StartPoint;
    opts.Upper = Upper;

    [xData, yData] = prepareCurveData( F, l );
     fun_=@(L0,P,K,offset,F) L0*(1-0.5*sqrt(138*(273+17)/10000/P./F)+F./K)+offset;
    
%     fun_=@(L0,P,offset,F) L0*(1-0.5*sqrt(138*(273+17)/10000/P./F))+offset;



    ft = fittype(fun_ ,'independent', 'F');

    
    [fitresult, gof] = fit( xData, yData, ft, opts );
end