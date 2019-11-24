load('data.mat')
%% Standardization
% Before applying DiCCA algorithm, it is necessary to scale columns 
% of the dataset such that variables are centered to have mean 0. 
% It is preferable to also scale the columns to have standard deviation of 1.
data = zscore(data); 
[ns,nv] = size(data);
%% Input DiCCA paramters 
% The autoregression order and number of dynamic latent variables are
% determined by the user.
order = 10;          
nfactor = 5;     
%% Apply DiCCA
[J,W,Beta,P,R,T,Tpred] = DiCCA_SVD(data,order,nfactor);
%% Plot first 2 DLVs
figure
subplot(211)
plot(T(:,1),'LineWidth',1)
xlim([0,ns])
title('DLV 1')
subplot(212)
plot(T(:,2),'LineWidth',1)
xlim([0,ns])
title('DLV 2')
%% Plot AR coefficients, variance of DLVs and R2 values
figure
subplot(311)
plot(Beta)
title('AR coefficients for the DLV models')
xlim([1, order]); grid on
set(gca,'XTick',1:1:order)

subplot(312)
Tvar = diag(T'*T)/(ns-1);
bar(Tvar)
title('Variance captured by each DLV')

subplot(313)
Tlast = T(order+1:end,:);
R2 = diag(corr(Tlast, Tpred));
bar(R2)
title('R2 of each DLV')
