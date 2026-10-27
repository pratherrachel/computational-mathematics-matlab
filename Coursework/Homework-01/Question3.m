function [h,e]=Question3(i)
n=2^(i);
h=1/(n+1);
x=linspace(h,n*h,n);
f=24*ones(n,1);
e=ones(n,1);
c=diffrule([-2,-1,0,1,2],4);
A=spdiags([c(1)*e c(2)*e c(3)*e c(4)*e c(5)*e],-2:2,n,n)/h^4;
A(1,1)=A(1,1)+(1/h^4);
A(n,n)=A(n,n)+(1/h^4);
u=A\f;
u0=transpose(x.^4-2*x.^3+x.^2);
e=norm(u-u0)/norm(u0);
end

%The coding I used on my function was:
%[h1,e1]=Question3(5)
%[h2,e2]=Question3(6)
%[h3,e3]=Question3(7)
%which gave me three different values I could plot.
%Then to create my plot I used 
%loglog([h1,h2,h3],[h1^2,h2^2,h3^2],'--')
%hold on
%loglog([h1,h2,h3],[e1,e2,e3],'-')
%hold off
%xlabel('h')
%ylabel({'error','h^2'})
%This plot verified that I had 2nd order accuracy. 