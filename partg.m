% part g
clear 

r=0.02; % risk-free interest rate
S0=326; % current stock price
k=320; % strike price
T=2/12; % time to maturity
sigma=0.4; % volatility
N=50; % number of partitions of time

price = binomial_european_call(r,sigma,k,S0,T,N);
