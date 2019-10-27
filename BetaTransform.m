function [beta1,lnjac]=BetaTransform(beta,indBackward);
% PURPOSE:  
% -----------------------------------------------------
% USAGE: 
% where: 
% NOTE: no dimension checks imposed , 11/06/04
% -----------------------------------------------------
% RETURNS: 
% 
%;
% -----------------------------------------------------
% written by:
% Gianni Amisano, Dept of Economics
% University of Brescia
% amisano@eco.unibs.it
if indBackward~=0
    beta1=exp(beta)/(1+sum(exp(beta)));
    lnjac=-sum(log(beta1))-log(1-sum(beta1));
else
    beta1=log(beta/(1-sum(beta)));
    lnjac=sum(log(beta))+log(1-sum(beta));
end