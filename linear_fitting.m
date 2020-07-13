function [rate, error] = linear_fitting(x, y)
  [xData, yData] = prepareCurveData( x, y );  
  [linear, gof] = fit( xData, yData, 'poly1');
  mdl = fitlm(xData, yData);
  error = table2array(mdl.Coefficients(2, 2));
  rate = -2*linear.p1
  
