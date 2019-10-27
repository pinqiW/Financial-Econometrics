%% Problem Set 1 %%

%% Prepare the workspace
% Clean up before starting
clear all
close all
clc

%% Data and Returns
% Start by loading the data and constructing returns.  It is usually a good
% idea to use 100 * returns which helps numerical stability 
% read data
ps1data = readtable('ECON_593_PS_01_data.xlsx');
rjpmus = 100 * table2array(ps1data(:,4));
rmscius = 100 * table2array(ps1data(:,7));
reuro = 100 * table2array(ps1data(:,10));
dates = datenum(table2array(ps1data(:,1)));


%% Question 1 %%

% correlograms for rjpmus, rmscius, reuro
Z = [rjpmus rmscius reuro]
cm = correlogramMat(Z,100)
figure; plot(cm(:,1));
figure; plot(cm(:,2));
figure; plot(cm(:,3));

% correlograms for squared rjpmus, rmscius, reuro
rjpmus_sq = rjpmus.^2 ;
rmscius_sq = rmscius.^2;
reuro_sq = rmscius.^2 ;

Z_sq = [rjpmus_sq rmscius_sq reuro_sq];
cm_sq = correlogramMat(Z_sq,100);
figure; plot(cm_sq(:,1));
figure; plot(cm_sq(:,2));
figure; plot(cm_sq(:,3));

% JB tests
chi2cdf(jbtest(rjpmus),3994);
chi2cdf(jbtest(rmscius),3994);
chi2cdf(jbtest(reuro),3994);
chi2cdf(jbtest(rjpmus_sq),3994);
chi2cdf(jbtest(rmscius_sq),3994);
chi2cdf(jbtest(reuro_sq),3994);



%% Question 2 %%

% p_values for Castellan and Siegel Tests
% H null:statistical independence
% We need to not reject H null for ARCH and GARCH
% We should obtain p values greater than 5%
CS_rjpmus = main_Castellan_Siegel(rjpmus)
CS_rmscius = main_Castellan_Siegel(rmscius)
CS_reuro = main_Castellan_Siegel(reuro)


%% Question 3 %%

% rjpmus ARCH Estimation
[rjpmus_p, rjpmus_ll, rjpmus_ht, rjpmus_vcvr, rjpmus_vcv] = tarch(rjpmus,3,0,0);

% rjpmus parameters
disp('GARCH parameters')
disp(rjpmus_p)

% rjpmus T-stats
disp('Non-robust   Robust T-stats')
rjpmus_t = [rjpmus_p./sqrt(diag(rjpmus_vcv)) rjpmus_p./sqrt(diag(rjpmus_vcvr))]

% rmscius p values
pval_rjpmus = 1 - normcdf(rjpmus_t)


%% rmscius ARCH Estimation
[rmscius_p, rmscius_ll, rmscius_ht, rmscius_vcvr, rmscius_vcv] = tarch(rmscius,3,0,0);


% rmscius parameters
disp('ARCH parameters')
disp(rmscius_p)

% rmscius t-stats
disp('Non-robust   Robust T-stats')
rmscius_t = [rmscius_p./sqrt(diag(rmscius_vcv)) rmscius_p./sqrt(diag(rmscius_vcvr))]

% rmscius p values
pval_rmscius = 1 - normcdf(rmscius_t)

%% Question 4 %%

% Calculate the residuals
u_rmscius = rmscius(1:end-1) - rmscius_p(1)-rmscius_p(2)*rmscius(2:end)
u_rjpmus = rjpmus(1:end-1) - rjpmus_p(1)-rjpmus_p(2)*rjpmus(2:end)

% Engel arch test
[H,engelpval,ARCHtest,cv]= archtest(u_rmscius)
[H,engelpval,ARCHtest,cv]= archtest(u_rjpmu)