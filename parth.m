% part h
clear

r=0.02; % risk-free interest rate
S0=326; % current stock price
k=320; % strike price
T=2/12; % time to maturity
sigma=0.4; % volatility
% Black-Scholes-Merton formula
d1=(log(S0/k)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2=d1-sigma*sqrt(T);
c=S0*normcdf(d1)-k*exp(-r*T)*normcdf(d2);
% Put-call parity
p=c+k*exp(-r*T)-S0;