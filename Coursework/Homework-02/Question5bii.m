function [h,e]=Question5bii(i)
n=2^(i);
h=(2*pi)/n;

a=[1         0           -1     0    0    0;
   1        -1            0     0    0    0;
   0         1           -1     0    0    0;
   0         0           2*pi  -1    0    1;
   (pi/2) -(pi/2)        0     1    -1    0;
   0       (3*pi)/2 (-3*pi)/2  0    1    -1;
   (pi^2)/8 pi^2    (7*pi^2)/8 pi/2 pi pi/2];
b=[2*pi;-pi;3*pi;2*pi^2;-(pi^2)/4;(9*pi^2)/4;(-pi^3)/4];
c=a\b;

x=linspace(h,n*h,n);
e=ones(n,1);

u0=polyval([-1/2,c(2),c(5)],x);
u0(x<pi/2)=polyval([1/2,c(1),c(4)],x(x<pi/2));
u0(x>(3*pi)/2)=polyval([1/2,c(3),c(6)],x(x>(3*pi)/2));
u0=transpose(u0);
u0=u0-(transpose(e)*u0)/(transpose(e)*e)*e;

f=zeros(n,1);
for i=1:n
    if x>=(pi/2)
        if x<=(3*pi/2)
            f(i)=1;
        end
    else
        f(i)=-1;
    end
end

A=spdiags([-e 2*e -e],-1:1,n,n)/h^2;
A(1,n)=-1/h^2;
A(n,1)=-1/h^2;
u=A\f;
u=u-(transpose(e)*u)/(transpose(e)*e)*e;

e=norm(u-u0)/norm(u0);
end

%The coding I used on my function was:
%[h1,e1]=Question2(10)
%[h2,e2]=Question2(11)
%[h3,e3]=Question2(12)
%which gave me three different values I could plot.
%Then to create my plot I used 
%loglog([h1,h2,h3],[h1^2,h2^2,h3^2],'--')
%hold on
%loglog([h1,h2,h3],[e1,e2,e3],'-')
%hold off
%xlabel('h')
%This shows that we have a code with a convergence rate lower than
%2nd order because of the discontinuity.