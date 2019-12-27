% part a 
clear

r=0.1; % risk-free interest rate
sigma=0.4; % volatility
k=50; % strike price
S0=50; % current stock price
T=5/12; % time to maturity
Smax=100;
M=20; % number of equally spaced stock prices
N=10; % number of equally spaced time intervals
ds=Smax/M;
dt=T/N;

jlist=0:ds:Smax; % list of stock prices
ilist=0:dt:T; % list of time intervals

grid=zeros(M+1, N+1); % initialize the grid
grid(1,:)=k; % boundary condition for stock price=0
grid(end,:)=0; % boundary condition for stock price=Smax
grid(:,end)=max(0,k-jlist); % boundary condition for t=T

% construct the tridiagonal matrix to solve the option price at each iteration
j=1:M-1;
alpha=0.5*r*dt*j-0.5*sigma^2*dt*j.^2;
beta=1+sigma^2*dt*j.^2+r*dt;
gamma=-0.5*r*dt*j-0.5*sigma^2*dt*j.^2;
A=diag(beta)+diag(alpha(2:end),-1)+diag(gamma(1:end-1),1);
% iterate backwards
for int=N:-1:1
    b=grid(2:end-1,int+1); % construct the right hand side
    b(1)=b(1)-alpha(1)*k;
    grid(2:end-1,int)=A\b; % update grid by the computed option price
    for count=2:M
        if grid(count,int)<k-(count-1)*ds % determine whether early exercise is optimal
            grid(count,int)=k-(count-1)*ds; % update grid if early exercise is optimal
        end
    end
end

% 3D plot of option prices
mesh(ilist,jlist,grid);colorbar();title('American Put Option Price by Implicit Finite Difference Method')
xlabel('Time (years)');ylabel('Stock Price (dollars)');zlabel('Option Price (dollars)')

