% sensitivity analysis
clear

r=0.1;
sigma=0.4;
k=50;
S0=50;
T=5/12;
Smax=100;
M=20;
price=zeros;
analytical=zeros;

d1=(log(S0/k)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2=d1-sigma*sqrt(T);
p=k*exp(-r*T)*normcdf(-d2)-S0*normcdf(-d1); % European put option price

for i=1:50
    N=i;
    price(i)=finite_difference_european_put(r, sigma, k, S0, T, Smax, M, N);
end
error=abs(price-p);
i=1:50;

plot(i,error);
title('Absolute Error vs Number of Partitions of Time');
xlabel('Number of Partitions of Time');
ylabel('Absolute Error');
