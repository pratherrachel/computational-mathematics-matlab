clear; warning off all;

testfunction=@(x,y,z) 64.*x.*(1-x).*y.*(1-y).*z.*(1-z);

p=haltonset(3);
pts=net(p,800);
q=rescale(pts,0,1);
x=q(:,1);
y=q(:,2);
z=q(:,3);
v=testfunction(x,y,z);

MQ =@(r,c)  sqrt(r.^2+c^2);
k=length(q(:,1));
c=sqrt(18)/(0.8*k^.25);
DM=DistanceMatrix([x,y,z],[x,y,z]);
A=MQ(DM,c);
coef=A\v;

p2=haltonset(3);
pts2=net(p2,1000);
q2=rescale(pts2,0,1);
x2=q2(:,1);
y2=q2(:,2);
z2=q2(:,3);
v2=testfunction(x2,y2,z2);

DM1=DistanceMatrix([x2,y2,z2],[x,y,z]);
E=MQ(DM1, c)*coef;

error=max(abs(E-v2));
disp(['The max absolute error for the interpolation between our two'])
disp(['quasi-random data sets is ',num2str(error)])

figure(1)
[M,N,P]=meshgrid(0:(1/30):1);
s=testfunction(M,N,P);
pfit=patch(isosurface(M,N,P,s,0.1));
isonormals(M,N,P,s,pfit);
set(pfit,'FaceLighting','gouraud','FaceColor','b','EdgeColor','none');
light('Position',[1 0 1],'Style','infinite');
view([50,120]);
axis equal;
axis off;
title('Iso-Surface Corresponding to Volume Data = 0.1')

DM2=DistanceMatrix([M(:) N(:) P(:)],[x y z]);
E2=MQ(DM2,c)*coef;

abserror=abs(E2-s(:));
abserror=reshape(abserror,[31,31,31]);

figure(2)
xslice=[];
yslice=[];
zslice=[0.2,0.4,0.6,0.8];
slice(M,N,P,abserror,xslice,yslice,zslice);
colorbar
title('Slices of Absolute Errors')

