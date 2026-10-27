function [u]=multigrid2D(A,b)
r=b;
n=sqrt(length(r));
h=1/(n+1);
P=tril(A);
x=zeros(length(r),1);

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
    R=kron(R,R);
    I=4*transpose(R);
    r2=R*r;
    e2=multigrid1D(r2);
    e=I*e2;
end

u=x+e;
end

% This is a modified multigrid solver that works for 2D problems
% using Gauss-Seidel as the smoother