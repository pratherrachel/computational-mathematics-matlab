clear;
R =@(t) (cos(3.*t)+sqrt(2-(sin(3.*t).^2))).^(1/3);
tic
t=linspace(0,2*pi, 200);
x=R(t).*cos(t);   y=R(t).*sin(t);
a=min(x);   b=max(x);
c=min(y);   d=max(y);
n=30000;
p=haltonset(2,'Skip',250,'Leap',100);
pts=net(p,n);
pts(:,1)=pts(:,1)*(b-a)+a;
pts(:,2)=pts(:,2)*(d-c)+c;
[theta, rr]=cart2pol(pts(:,1),pts(:,2));
X=R(theta).*cos(theta);
Y=R(theta).*sin(theta);
[Theta, r]=cart2pol(X(:),Y(:));
in=rr<=r;
m=sum(in);
area=(d-c)*(b-a)*(m/n);
display(area);
toc
