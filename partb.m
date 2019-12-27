% part b
clear
% the part is the same as part a except we do not check whether early
% exercise is optimal because it is an European put option
r=0.1;
sigma=0.4;
k=50;
S0=50;
T=5/12;
Smax=100;
M=20;
N=10;
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

% Black-Scholes-Merton formula
d1=(log(S0/k)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2=d1-sigma*sqrt(T);
p=k*exp(-r*T)*normcdf(-d2)-S0*normcdf(-d1); % European put option price

% 3D plot of option prices
mesh(ilist,jlist,grid);colorbar();title('European Put Option Price by Implicit Finite Difference Method')
xlabel('Time (years)');ylabel('Stock Price (dollars)');zlabel('Option Price (dollars)')
