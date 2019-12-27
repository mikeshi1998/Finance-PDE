% partc
clear

M=200; % 200 equally spaced position
N=200; % 200 equally spaced time period
x=linspace(0,1,M);
t=linspace(0,1,N);
dx=1/(M-1);
dt=1/(N-1);

grid=zeros(M,N); % initialize the grid
grid(:,1)=sin(pi*x); % boundary condition for t=0
grid(1,:)=0; % boundary condition for x=0
grid(end,:)=0; % boundary condition for x=1

% construct the tridiagonal matrix for solving the heat problem
r=dt/(2*dx^2);
one=ones(M-2,1);
alpha=one*2*r+1;
beta=one*-r;
A=diag(alpha)+diag(beta(2:end),-1)+diag(beta(2:end),1);
b=zeros(M-2,1);

for j=2:N
    for i=2:M-1
        b(i-1)=r*grid(i-1,j-1)+(1-2*r)*grid(i,j-1)+r*grid(i+1,j-1); % construct the right hand side
    end
    grid(2:end-1,j)=A\b; % update grid
end

% the heat computed at each grid position through the exact function
true_grid=zeros(M,N);
for i=1:M
    for j=1:N
        true_grid(i,j)=f_heat(x(i),t(j));
    end
end

% compare the error at each grid position
error_grid=abs(grid-true_grid);

% 3D plot
mesh(t,x,grid);colorbar();title('Solving the Heat Equation Using Crank-Nicolson Method')
xlabel('Time');ylabel('Position');zlabel('Temperature')
figure;mesh(t,x,true_grid);colorbar();title('Analytical Solution of the Heat Equation')
xlabel('Time');ylabel('Position');zlabel('Temperature')
figure;mesh(t,x,error_grid);colorbar();title('Absolute Error Between the Numerical Solution and Analytical Solution')
xlabel('Time');ylabel('Position');zlabel('Temperature')

