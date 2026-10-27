clear; warning off all;
rbf=@(r,c) sqrt(r.^2+c^2) ; %sqrt(1+(r*c).^2); 
c=1/250; %shape parameter
load dolphin.txt
load int.mat
bdpt=[dolphin(:,1),dolphin(:,2),dolphin(:,3)];

center=(min(dolphin)+max(dolphin))/2;
xc=center(:,1)+1.72; yc=center(:,2)-.41; zc=center(:,3);
[X,Y,Z]=ellipsoid(xc,yc,zc,0.24,0.12,.67,5);

Center=[X(:),Y(:),Z(:)];

intpt=[Center;int];

figure (1)
x1=intpt(:,1); y1=intpt(:,2); z1=intpt(:,3);
plot3(x1,y1,z1,'ro',bdpt(:,1),bdpt(:,2),bdpt(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([0,90]); axis equal; legend('interior','boundary');

mb=length(bdpt(:,1)); 
colpt=[intpt;bdpt]; % interior + boundary points
f=-1*ones(length(x1),1);  %
g=0*ones(mb,1);    
rhs=[f;g];  %RHS 
%%%%%%%%%%%%% coefficient matrix
DM=pdist2(colpt, colpt);
A=rbf(DM,c);
coe=A\rhs; 
%%%%%%%%%% Evaluation points
neval=60;  
bmin=min(bdpt,[],1);  bmax=max(bdpt,[],1);
x=linspace(bmin(1)-.1,bmax(1)+.1,neval);
y=linspace(bmin(2)-.1,bmax(2)+.1,neval);
z=linspace(bmin(3)-.1,bmax(3)+.1,neval);
[xe,ye,ze]=meshgrid(x,y,z);
epoints=[xe(:),ye(:),ze(:)]; %clear xgrid ygrid zgrid 
for iter=1:neval^3
    DM_eval = pdist2(epoints(iter,:),colpt);
    DM=rbf(DM_eval,c);
    pf(iter) = DM*coe;  
end 

figure (2)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','b','EdgeColor','none');
light('Position',[ 0 1 1],'Style','infinite'); 
view([0,90]);  axis equal; axis off