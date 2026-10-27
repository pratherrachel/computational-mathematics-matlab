n=2^(15)-1;
h=1/(n+1);
x=linspace(h,n*h,n);
phi=transpose(9*pi*x.^2);
phix=transpose(18*pi*x);
phixx=18*pi;
f=transpose(sin(9*pi*x.^2).*(18*pi*x).^2-cos(9*pi*x.^2)*18*pi);
e=ones(n,1);
A=spdiags([-1*e 2*e -1*e],-1:1,n,n)/h^2;
u1=A\f;
[u2]=multigrid1D(f);
u0=transpose(sin(9*pi*x.^2));
error1=norm(u1-u0)/norm(u0);
error2=norm(u2-u0)/norm(u0);

% This was created to compare the error from multigrid1D to the
% finite difference from Question 2