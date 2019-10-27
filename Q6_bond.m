%%%%%%%%%%%% Exercise 6  GARCH(1,1) for the two series %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% rjpmus%%%%%%%%%%%%%%%%%%%
retv =100*rjpmus
%%
options  =  optimset('fminunc');
% 

%%
theta0=[0 0 var(retv)*.06 .04 .9]';
eta0=GARCH11_parameter_transform(theta0,0);
%%
data=[retv(2:end) ones(length(retv)-1,1) retv(1:end-1)];

%lnl=GARCH11_lnl(eta0,data,1,0);

[eta1,fval,exitflag,output,grad,hess ]=fminunc(@(eta) GARCH11_lnl(eta,data,1,0,0),eta0,options);
%%
theta1=GARCH11_parameter_transform(eta1,1);
H=hessian('GARCH11_lnl',theta1,data,0,0,0);
H=H\eye(size(H,1));
ztest=theta1./sqrt(diag(H));
lnl=GARCH11_lnl(eta0,data,1,0,1);

%Residuals
uv=(data*[1;-theta1(1:2)]);
%Estimating std residuals
stdresid=uv./sqrt(lnl.sigmat);
Fig2=plot(stdresid);
%since we have 14000 obs, it's asymptotically gaussian, too fast to
%converge (takes 32 itirations)
%start very close to the MLE
%eta1 is the vector of parameters that corresponds to maximization- the
%values with log and stuff-notes
%theta1- transforms back to vector of parameters
