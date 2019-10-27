function output=GARCH11_lnl(parv,data,ndx_par_transform,ndx_var_calib,ndx_multiple_output)
% PURPOSE:  
% -----------------------------------------------------
% USAGE: 
% where: 
% NOTE: no dimension checks imposed , 2018_09_17
% -----------------------------------------------------
% RETURNS: 
% 
%
% -----------------------------------------------------
% written by:
% Gianni Amisano, Dept of Economics
% Georgetown University
% gianni.amisano1@gmail.com


%theta(1:nk);  %the conditional mean parameters
%theta(nk+1);  %=ALPHA  (so, a=log(alpha)=log(theta(nk+1))  later )
%theta(nk+2);  %the coefficient for the squared lagged shocks.  theta(nk+2)>=0
%theta(nk+3);  %the coefficient for the lagged variance.  theta(nk+3)>=0
[T,nk]=size(data);
nk=nk-1;
theta=parv;
if ndx_par_transform
   theta=GARCH11_parameter_transform(parv,1);
end
sigmat=zeros(T,1);
uv=(data*[1;-theta(1:nk)]);
uv2=uv.^2;
if ndx_var_calib
    sigma0=theta(nk+1)/(1-theta(nk+2)-theta(nk+3));
else
    sigma0=var(uv);
end
u02=sigma0;
for t=1:T
    sigmat(t)=theta(nk+1)+theta(nk+2)*u02+theta(nk+3)*sigma0;
    sigma0=sigmat(t);
    u02=uv2(t);
end
lnl=-T*log(2*pi)/2;
lnl=lnl-sum(log(sigmat))/2;
lnl=lnl-sum(uv2./sigmat)/2;
lnl=-lnl;
if ndx_multiple_output
    output.lnl=lnl;
    output.sigmat=sigmat;
    output.theta=theta;
else
    output=lnl;
end