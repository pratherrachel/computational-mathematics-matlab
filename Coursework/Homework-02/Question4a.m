function [x,u]=Question4a(i)
n=2^(i)-1;
h=1/(n+1);
x=linspace(h,n*h,n);
f=ones(n,1);
e=ones(n,1);
C1=diffrule([-1,1],1);
D1=spdiags([C1(1)*e 0*e C1(2)*e],-1:1,n,n)/h;
D2=spdiags([1*e -2*e 1*e],-1:1,n,n)/h^2;
A=-10^-4*D2+D1;
u=A\f;
plot(x,u)
end

% For this code I tried running this code with values of 6, 8 and 10.
% When I tried 6, I got a graph that oscillated across the domain.
% However, as the values for i got larger, we can see that the oscillation
% becomes more and more restricted to the right hand side of the domain.
% This is because there is a discontinuity point.