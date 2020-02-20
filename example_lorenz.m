load('lorenz_data.mat')
data = zscore(lorenz); % Normalize data
order = 1;          
nfactor = 3;     
[J,W,Beta,P,R,T,Tpred] = DiCCAS(data,order,nfactor); % Apply DiCCA
%% Plot original variables and dynamic latent variables
figure
subplot(321);plot(data(:,1));title('Variable X')
subplot(322);plot(T(:,1));title('DLV 1')
subplot(323);plot(data(:,2));title('Variable Y')
subplot(324);plot(T(:,2));title('DLV 2')
subplot(325);plot(data(:,3));title('Variable Z')
subplot(326);plot(T(:,3));title('DLV 3')

figure
subplot(121)
plot(data(:,1),data(:,3));title('Plot of variable X and variable Z')
xlabel('X');ylabel('Z')
subplot(122)
plot(T(:,1),T(:,2));title('Plot of DLV1 and DLV2')
xlabel('DLV 1');ylabel('DLV 2')
%% Plot original data and DiCCA prediction
figure
data_Pred = Tpred/R;
plot3(data(order+1:end,1),data(order+1:end,2),data(order+1:end,3));hold on;
plot3(data_Pred(:,1),data_Pred(:,2),data_Pred(:,3),'r--','LineWidth',1)
legend('Time evolution of Lorenz system','DiCCA prediction')
grid on