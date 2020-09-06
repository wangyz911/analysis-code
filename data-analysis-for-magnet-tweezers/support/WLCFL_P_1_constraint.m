
function [fitresult, gof] = WLCFL_P_1_constraint(F, z,StartPoint,Lower,Upper)
    
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );  
    opts.Display = 'Off';
    opts.Lower = Lower;
    opts.StartPoint = StartPoint;
    opts.Upper = Upper;

    [xData, yData] = prepareCurveData( z, F );
     fun_=@(P,z) 4.13./P*(1./(4*(1.-z).^2)-1/4 + z);
    

    ft = fittype(fun_ ,'independent', 'z');

    
    [fitresult, gof] = fit( xData, yData, ft, opts );
end

