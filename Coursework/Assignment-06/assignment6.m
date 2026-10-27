clear; warning off all;
rbf=@(r,c) sqrt(r.^2+c^2) ; %sqrt(1+(r*c).^2); 
c=.5; %shape parameter
load GeometryEmmi26.mat 
Bpts=Body.pts;
Upts=Uterus.pts;

%Start of abdomen figure part of coding
intpt=[0 0 -100; 0 0 0; 0 0 100];
x1=intpt(:,1); y1=intpt(:,2); z1=intpt(:,3);

figure (1)
plot3(x1,y1,z1,'ro',Bpts(:,1),Bpts(:,2),Bpts(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([110,15]); axis equal; legend('Interior','Boundary');
title('Boundary and Interior Points of an Abdomen');

in=Bpts(:,3)>150;
Bpts(in,:)=[];
mb=length(Bpts(:,1)); 
colpt=[intpt;Bpts]; % interior + boundary points
f=-1*ones(3,1);  %
g=0*ones(mb,1);    
rhs=[f;g];  %RHS 
%%%%%%%%%%%%% coefficient matrix
DM=pdist2(colpt, colpt);
A=rbf(DM,c);
coe=A\rhs; 
%%%%%%%%%% Evaluation points
neval=30; PS=neval*100;  number = floor((neval^3)/PS); 
bmin=min(Bpts,[],1);  bmax=max(Bpts,[],1);
x=linspace(bmin(1),bmax(1),neval);
y=linspace(bmin(2),bmax(2),neval);
z=linspace(bmin(3)-.1,bmax(3)+.1,neval);
[xe,ye,ze]=meshgrid(x,y,z);
epoints=[xe(:),ye(:),ze(:)]; %clear xgrid ygrid zgrid 
DM_eval = pdist2(epoints,colpt);
pf = rbf(DM_eval,c)*coe;    

figure (2)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
isocaps(xe,ye,ze,reshape(pf,neval,neval,neval),0,'below')
set(pfit,'FaceLighting','gouraud','FaceColor','g','EdgeColor','none');
light('Position',[ 1 0 1],'Style','infinite'); 
view([100,25]); colorbar;  axis equal; axis off
title('Iso-Surface of an Abdomen with an Iso-cap')

%Start of uterus figure coding
Intpt=[0 -120 0; 0 -30 0; 0 10 0];
X1=Intpt(:,1); Y1=Intpt(:,2); Z1=Intpt(:,3);

figure (3)
plot3(X1,Y1,Z1,'ro',Upts(:,1),Upts(:,2),Upts(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([110,15]); axis equal; legend('Interior','Boundary');
title('Boundry and Interior Points for a Uterus')

Mb=length(Upts(:,1)); 
Colpt=[Intpt;Upts]; % interior + boundary points
F=-1*ones(3,1);  %
G=0*ones(Mb,1);    
RHS=[F;G];  %RHS 
%%%%%%%%%%%%% coefficient matrix
dm=pdist2(Colpt, Colpt);
a=rbf(dm,c);
Coe=a\RHS; 
%%%%%%%%%% Evaluation points
neval=30; ps=neval*100;  Number = floor((neval^3)/ps); 
Bmin=min(Upts,[],1);  Bmax=max(Upts,[],1);
X=linspace(Bmin(1)-.4,Bmax(1)+.4,neval);
Y=linspace(Bmin(2)-.25,Bmax(2)+.25,neval);
Z=linspace(Bmin(3)-.25,Bmax(3)+.45,neval);
[Xe,Ye,Ze]=meshgrid(X,Y,Z);
Epoints=[Xe(:),Ye(:),Ze(:)]; %clear xgrid ygrid zgrid 
dm_eval = pdist2(Epoints,Colpt);
PF = rbf(dm_eval,c)*Coe;       

figure (4)
pfit=patch(isosurface(Xe,Ye,Ze,reshape(PF,neval,neval,neval),0));
isonormals(Xe,Ye,Ze,reshape(PF,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','g','EdgeColor','none');
light('Position',[ 1 0 1],'Style','infinite'); 
view([115,5]);  axis equal;
title('Iso-surface Image of a Uterus')

%Overlay of abdomen and uterus to create one figure
figure (5)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','b','EdgeColor','none');
alpha(pfit,'0.3');
hold on
pfit=patch(isosurface(Xe,Ye,Ze,reshape(PF,neval,neval,neval),0));
isonormals(Xe,Ye,Ze,reshape(PF,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','r','EdgeColor','none');
light('Position',[ 1 0 1],'Style','infinite'); 
view([110,5]);  axis equal;
hold off
legend('Abdomen','Uterus')
title('Iso-surface of Abdomen with Iso-surface of Uterus Inside')