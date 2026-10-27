clear
load intpts.txt;
x=intpts(:,1);  y=intpts(:,2);  z=intpts(:,3);
a=min(x);   b=max(x);
c=min(y);   d=max(y);
[xq,yq]=meshgrid(a:.1:b, c:.1:d);
zq=griddata(x,y,z,xq,yq,'cubic');
in=isnan(zq);
zq(in)=0;
figure(1)
surf(xq,yq,zq)
view(75,15);colorbar; xlabel('X'); ylabel('Y'); zlabel('Z')
title('Interpolated Data Points from intpts.txt Plotted as a Surface')
figure(2)
plot3(x,y,z,'b*')
view(75,15);
xlabel('X'); ylabel('Y'); zlabel('Z')
title('Scatterplot of Data Points from intpts.txt')
xlim([-3 3])
ylim([-3 3])
