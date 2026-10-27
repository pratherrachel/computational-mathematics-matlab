function [u]=multigrid1D(r)
b=r;
n=length(r);
h=1/(n+1);
e=ones(n,1);
A=spdiags([-1*e 2*e -1*e],-1:1,n,n)/h^2;
P=spdiags([-1*e 2*e],-1:0,n,n)/h^2;
x=zeros(n,1);

for i=1:200
    d=P\r;
    x=x+d;
    r=b-A*x;
end

h2=2*h;
n2=1/h2-1;

if n<100
    e=A\r;
else
    R=sparse(n2,n);
    for i=1:n2
        R(i,2*i-1:2*i+1)=[1/4,1/2,1/4];
    end
    I=2*transpose(R);
    r2=R*r;
    e2=multigrid1D(r2);
    e=I*e2;
end

u=x+e;
end

% This was my multigrid using Gauss-Seidel as my smoother
% Here r is equal to f from Question 2, which can be seen in Question6