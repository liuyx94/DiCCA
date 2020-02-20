load('process_data.mat')
%% Standardization
% Before applying DiCCA algorithm, it is necessary to scale columns 
% of the dataset such that variables are centered to have mean 0. 
% It is preferable to also scale the columns to have unit standard deviation.
data = zscore(process_data); 
[ns,nv] = size(data);
%% Input DiCCA parameters 
% The autoregression order and number of dynamic latent variables are
% determined by user.
order = 10;          
nfactor = 8;     
%% Apply DiCCA
[J,W,Beta,P,R,T,Tpred] = DiCCAS(data,order,nfactor);
%% Plot 5 DLVs
figure
for k = 1:5
    subplot(5,1,k)
    plot(T(:,k),'LineWidth',1)
    xlim([0,ns])
    title(['DLV ',num2str(k)])
end
%% Plot weights and loadings of first 5 DLVs
figure
for k = 1:5
    subplot(5,2,k*2-1)
    bar(abs(R(:,k)))
    title(['Weights of DLV ',num2str(k)])
    subplot(5,2,2*k)
    bar(abs(P(:,k)))
    title(['Loadings of DLV ',num2str(k)])
end
%% Plot AR coefficients, weights and loadings of all DLVs
figure
subplot(311)
plot(Beta,'LineWidth',1,'Marker','o')
title('AR coefficients of all DLVs')
xlabel('Order')
ylabel('Beta')

subplot(312)
plot(abs(R),'LineWidth',1,'Marker','o')
xlim([1, nv]) 
title('Weights of all DLVs')
xlabel('Variable')
ylabel('Abs(R)')


subplot(313)
plot(abs(P),'LineWidth',1,'Marker','o')
xlim([1, nv]) 
title('Loadings of all DLVs')
xlabel('Variable')
ylabel('Abs(P)')
%% Plot AR coefficients, variance of DLVs and R2 values
figure
subplot(311)
hold on
for k = 1:5
    plot(Beta(:,k),'LineWidth',1.5,'Marker','d','DisplayName',['DLV ',num2str(k)])
end
hold off
legend show
title('AR coefficients of first 5 DLV models')
xlim([1, order]); 
set(gca,'XTick',1:1:order)

subplot(312)
Tvar = diag(T'*T).*diag(P'*P)/(ns-1);
bar(Tvar)
title('Variance captured by each DLV')

subplot(313)
R2 = J.^2;
bar(R2)
title('R2 of each DLV')
