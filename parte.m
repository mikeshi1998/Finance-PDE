% part e
clear

r=0.1; % risk-free interest rate
sigma=0.4; % volatility
k=50; % strike price
S0=50; % current stock price
T=5/12; % time to maturity
N=50; % number of partitions of time

price = binomial_american_put(r,sigma,k,S0,T,N);

