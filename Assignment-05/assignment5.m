clear; warning off all;

testfun=@(x,y,z) 64.*x.*(1-x).*y.*(1-y).*z.*(1-z);
rbf =@(r,c)  sqrt(r.^2+c^2);

p=haltonset(3);
pts=net(p,800);
x=pts(:,1);
y=pts(:,2);
z=pts(:,3);

k=length(x);
c=sqrt(18)/(0.8*(k^(1/4)));
DM=pdist2([x,y,z],[x,y,z]);
f=testfun(x,y,z);
A=rbf(DM,c);
b=A\f;

%Question 1

ptest=haltonset(3,'Skip',1e4);
tp=net(p,1000);
xtest=tp(:,1);
ytest=tp(:,2);
ztest=tp(:,3);

K=length(xtest);
C=sqrt(18)/(0.8*(K^(1/4)));
DMtest=pdist2([xtest,ytest,ztest],[x,y,z]);
btest=rbf(DMtest,C)*b;

e=max(abs(testfun(xtest,ytest,ztest)-btest));
disp(['The max absolute error for the interpolation between our two'])
disp(['quasi-random data sets is ',num2str(e)])

%Question 2

figure(1)
n=30;
[X,Y,Z]=meshgrid(0:1/(n-1):1); 
DMtestV=pdist2([X(:),Y(:),Z(:)],[x,y,z]);
mC=sqrt(18)/(0.8*(K^(1/4)));
testV=rbf(DMtestV,mC)*b;
V=reshape(testV,30,30,30);
pfit=patch(isosurface(X,Y,Z,V,0.1));
isonormals(X,Y,Z,V,pfit);
set(pfit,'FaceLighting','gouraud','FaceColor','b','EdgeColor','none');
light('Position',[1 0 1],'Style','infinite');
view([50,120]);
axis equal; axis off;
title('Iso-Surface Corresponding to Volume Data = 0.1')

%Question 3

s=testfun(X,Y,Z);
abserror=abs(testV-s(:));
abserror=reshape(abserror,[30,30,30]);

figure(2)
xslice=[];
yslice=[];
zslice=[0.2,0.4,0.6,0.8];
slice(X,Y,Z,abserror,xslice,yslice,zslice,'cubic')
view([15,15]);
title('Plot of Error at Different Levels')
colorbar
title('Slices of Absolute Errors')
axis equal