% part f
clear

r=0.1; % risk-free interest rate
sigma=0.4; % volatility
k=50; % strike price
S0=50; % current stock price
T=5/12; % time to maturity

prices=zeros(1,50);
for N=1:50
    prices(N)=binomial_american_put(r,sigma,k,S0,T,N);
end
N=1:50;

plot(N,prices,'-b')
title('Convergence of the Price of American Put Option Using Binomial Tree Approach')
xlabel('Price (dollars)');ylabel('Number of Partitions of time')


