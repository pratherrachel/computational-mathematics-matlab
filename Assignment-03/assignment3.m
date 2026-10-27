clear
t=linspace(0,2*pi, 200);
Xt=cos(t); Yt=sin(t);
[x,y]=meshgrid(-1:.01:1, -1:.01:1);
Z=exp(-81/4*(x.^2+y.^2));
z=griddata(x,y,Z,x,y,'cubic');
in=inpolygon(x,y,Xt,Yt);
z(~in)=NaN;
inX=0.3+0.3*cos(t); inY=0.3+0.3*sin(t);
In=inpolygon(x,y,inX,inY);
z(In)=NaN;
figure(1)
mesh(x,y,z);
xlim([-1,1]);ylim([-1,1]);
view(75,25);
xlabel('X'); ylabel('Y'); zlabel('Z')
title('Plot of f(x,y)')
figure(2);
h=pcolor(x,y,z);
set(h,'EdgeColor','none');
xlabel('X'); ylabel('Y');
title('Top Down View of f(x,y)')