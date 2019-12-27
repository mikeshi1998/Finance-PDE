function price = finite_difference_european_put(r, sigma, k, S0, T, Smax, M, N)

ds=Smax/M;
dt=T/N;

jlist=0:ds:Smax;
ilist=0:dt:T;

grid=zeros(M+1, N+1);
grid(1,:)=k;
grid(end,:)=0;
grid(:,end)=max(0,k-jlist);

j=1:M-1;
alpha=0.5*r*dt*j-0.5*sigma^2*dt*j.^2;
beta=1+sigma^2*dt*j.^2+r*dt;
gamma=-0.5*r*dt*j-0.5*sigma^2*dt*j.^2;
A=diag(beta)+diag(alpha(2:end),-1)+diag(gamma(1:end-1),1);

for int=N:-1:1
    b=grid(2:end-1,int+1);
    b(1)=b(1)-alpha(1)*k;
    grid(2:end-1,int)=A\b;
    % we no longer update grid by the early exercise
end

price=grid(((Smax-S0)/ds)+1,1);