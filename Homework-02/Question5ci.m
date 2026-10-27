function [h,e]=Question5ci(i)
n=4*(i);
h=(2*pi)/n;
x=linspace(h,n*h,n);
f=transpose(sin(x)+5*sin(18*x)+5*sin(20*x));
e=ones(n,1);
A=zeros(n,n);
for i=1:n
    for j=1:n
        if i==j
            A(i,j)=-(pi^2/(3*(h^2)))-(1/6);
        else
            A(i,j)=(((-1)^(j-i+1))/2)*(csc(((j-i)*h)/2)^2);
        end
    end
end
u=pinv(-A)*f;
u0=transpose(sin(x)+(5/324)*sin(18*x)+(1/80)*sin(20*x));
e=norm(u-u0)/norm(u0);
end

%The coding I used on my function was:
%[h1,e1]=Question2(4)
%[h2,e2]=Question2(6)
%[h3,e3]=Question2(8)
%which gave me three different values I could plot.
%Then to create my plot I used 
%loglog([h1,h2,h3],[h1^2,h2^2,h3^2],'--')
%hold on
%loglog([h1,h2,h3],[e1,e2,e3],'-')
%hold off
%xlabel('h')
%This shows that we have a code that is faster than 2nd order
%and that we actually have a logarithmic convergence.