clear; warning off all; 
tic
rbf=@(r,c) sqrt(r.^2+c^2) ; %sqrt(1+(r*c).^2); 
c=1/300; %shape parameter
load dragon3A.mat

%center=(min(dsites)+max(dsites))/2;
%xc=center(:,1); yc=center(:,2); zc=center(:,3);

%[X,Y,Z]=ellipsoid(xc,yc,zc,1.17,.97,.7);
%intpt=[X(:),Y(:),Z(:)];
%intpt=unique(intpt,'rows');
%intpt=dsites+(normals*.001);
intpt=dsites(1:400:end,:)+(normals(1:400:end,:)*.01);

figure (1)
x1=intpt(:,1); y1=intpt(:,2); z1=intpt(:,3);
plot3(x1,y1,z1,'ro',dsites(:,1),dsites(:,2),dsites(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([0,90]); axis equal; legend('interior','dsites');

n=length(x1);
mb=length(dsites(:,1)); 
colpt=[intpt;dsites]; % interior points + boundary points
f=-1*ones(n,1);  %
g=0*ones(mb,1);    
rhs=[f;g];  %RHS 
%%%%%%%%%%%%% coefficient matrix
DM=pdist2(colpt, colpt);
A=rbf(DM,c);
coe=A\rhs; 
%%%%%%%%%% Evaluation points 
neval=200;  
bmin=min(dsites,[],1);  bmax=max(dsites,[],1);
x=linspace(bmin(1)-.04,bmax(1)+.04,neval);
y=linspace(bmin(2)-.04,bmax(2)+.04,neval);
z=linspace(bmin(3)-.04,bmax(3)+.04,neval);
[xe,ye,ze]=meshgrid(x,y,z);
epoints=[xe(:),ye(:),ze(:)]; %clear xgrid ygrid zgrid 
parfor iter=1:neval^3
    DM_eval = pdist2(epoints(iter,:),colpt);
    DM=rbf(DM_eval,c);
    pf(iter) = DM*coe; 
end

sp=length(dsites); %Number of surface points

S=sum(sign(pf)==-1);
volume=S/length(pf)*(bmax(1)-bmin(1))*(bmax(2)-bmin(2))*(bmax(3)-bmin(3));

figure (2)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','#EDB120','EdgeColor','none');
light('Position',[ 1 0 1],'Style','infinite'); 
view([0,90]);  axis equal; axis off

figure (3)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','#EDB120','EdgeColor','none');
light('Position',[ -1 0 -1],'Style','infinite'); 
view([180,270]);  axis equal; axis off
toc