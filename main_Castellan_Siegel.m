function main_Castellan_Siegel= CS(xv)

tau=mean(xv);
% compute number of runs
NR=1;
yv=xv-tau;
T=length(yv);
for it=2:length(yv)
    if yv(it)*yv(it-1)<=0
        NR=NR+1;
    end
end
T0=sum(yv>0);
T1=T-T0;
SC= (NR-(1+2*T0*T1/T))/ ...
    sqrt(2*T0*T1*(2*T0*T1-T)/(T^2*(T-1)))
main_Castellan_Siegel = [SC, 2*(1-normcdf(abs(SC)))]