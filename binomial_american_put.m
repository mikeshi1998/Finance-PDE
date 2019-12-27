function price = binomial_american_put(r,sigma,k,S0,T,N)

dt=T/N;
u=exp(sigma*sqrt(dt));
d=exp(-sigma*sqrt(dt));
a=exp(r*dt);
p=(a-d)/(u-d);
grid=zeros;

for j=0:N
    grid(j+1,N+1)=max(k-S0*u^j*d^(N-j), 0);
end

for i=N-1:-1:0
    for j=0:i
        grid(j+1,i+1)=max(k-S0*u^j*d^(i-j), exp(-r*dt)*(p*grid(j+2,i+2)+(1-p)*grid(j+1,i+2)));
    end
end
price=grid(1,1);
