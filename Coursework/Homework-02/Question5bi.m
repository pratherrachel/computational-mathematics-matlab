function [h,e]=Question5bi(i)
n=2^(i);
h=(2*pi)/n;
x=linspace(h,n*h,n);
f=transpose(sin(x)+5*sin(18*x)+5*sin(20*x));
e=ones(n,1);
A=spdiags([-e 2*e -e],-1:1,n,n)/h^2;
A(1,n)=-1/h^2;
A(n,1)=-1/h^2;
u=A\f;
u=u-(transpose(e)*u)/(transpose(e)*e)*e;
u0=transpose(sin(x)+(5/324)*sin(18*x)+(1/80)*sin(20*x));
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
%ylabel({'error','h^2'})
%This verified that I had 2nd order accuracy. 