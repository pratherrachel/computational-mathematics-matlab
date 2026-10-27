clear; warning off all;
rbf=@(r,c) sqrt(r.^2+c^2) ; %sqrt(1+(r*c).^2); 
c=(1/150); %shape parameter
load hand2.txt
bdpt=[hand2(:,1),hand2(:,2),hand2(:,3)];
center=(min(bdpt)+max(bdpt))/2;

[X,Y,Z]=sphere(9);
intpt=[X(:),Y(:),Z(:)];
intpt=unique(intpt,'rows');
intpt=intpt*.3+center; 
figure (1)
x1=intpt(:,1); y1=intpt(:,2); z1=intpt(:,3);
plot3(x1,y1,z1,'ro',bdpt(:,1),bdpt(:,2),bdpt(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([30,40]); axis equal; legend('sphere','hand');

mb=length(bdpt(:,1)); 
colpt=[center;intpt;bdpt]; % interior + boundary points
f=1*ones(length(x1),1);  %
g=0*ones(mb,1);    
rhs=[-1;f;g];  %RHS 
%%%%%%%%%%%%% coefficient matrix
DM=pdist2(colpt, colpt);
A=rbf(DM,c);
coe=A\rhs; 
%%%%%%%%%% Evaluation points
neval=30;  
bmin=min(bdpt,[],1);  bmax=max(bdpt,[],1);
x=linspace(bmin(1)-.02,bmax(1)+.02,neval);
y=linspace(bmin(2)-.02,bmax(2)+.02,neval);
z=linspace(bmin(3)-.02,bmax(3)+.02,neval);
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
view([50,120]);  axis equal; axis off


