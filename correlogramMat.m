function cm=correlogramMat(xm,q);
% PURPOSE:  
% -----------------------------------------------------
% USAGE: 
% where: 
% NOTE: no dimension checks imposed , 01/09/04
% -----------------------------------------------------
% RETURNS: 
% 
%
% -----------------------------------------------------
% written by:
% Gianni Amisano, Dept of Economics
% University of Brescia
% amisano@eco.unibs.it
[M,k]=size(xm);
cm=zeros(q,k);
for ik=1:k
    xv=xm(:,ik);
    for iq=1:q;
        a=corrcoef([xv(iq+1:M) xv(1:M-iq)]);
        cm(iq,ik)=a(2,1);
    end
end