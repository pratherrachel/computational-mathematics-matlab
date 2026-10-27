function [x,u]=Question4b(i)
n=2^(i);
x=zeros(n+2,1);

for i=0:n+1
    x(i+1)=-cos(i*pi/(n+1));
end

C=zeros(n+2,n+2);
for i=1:n+2
    for j=1:n+2
        if i==j
            for k=1:n+2
                if k~=j
                    C(i,j)=C(i,j)+1/(x(j)-x(k));
                end
            end
        else
            ai=1;
            aj=1;
            for k=1:n+2
                if k~=i
                    ai=ai*(x(i)-x(k));
                end
                if k~=j
                    aj=aj*(x(j)-x(k));
                end
            end
            C(i,j)=ai/(aj*(x(i)-x(j)));
        end
    end
end

f=ones(n,1);
D2=C^2;
D=C(2:n+1,2:n+1);
D2=D2(2:n+1,2:n+1);
A=-10^(-4)*D2+D;
u=A\f;
plot(x(2:n+1),u);
end
        
% This is my spectral code with Chebyshev points.