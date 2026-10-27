clear; warning off all;
rbf=@(r,c) sqrt(r.^2+c^2) ; %sqrt(1+(r*c).^2); 
c=1/300; %shape parameter
load Data3D_Bunny2.mat
center=(min(dsites)+max(dsites))/2;

[X,Y,Z]=sphere(9);
intpt=[X(:),Y(:),Z(:)];
intpt=unique(intpt,'rows');
intpt=intpt*.09+center;

figure (1)
x1=intpt(:,1); y1=intpt(:,2); z1=intpt(:,3);
plot3(x1,y1,z1,'ro',dsites(:,1),dsites(:,2),dsites(:,3),'b.','MarkerFaceColor',[1 0 0]);
view([0,90]); axis equal; legend('sphere','dsites');

n=length(x1);
%intpt2=dsites(3:45:end,:)-normals(3:45:end,:)*0.01;
%intpt2=intpt2(1:n,:);
%intpt3=dsites(3:45:end,:)+normals(3:45:end,:)*.004;
%intpt3=intpt3(1:n,:);
mb=length(dsites(:,1)); 
colpt=[center;intpt;dsites]; % center + sphere + boundary points
f=1*ones(n,1);  %
g=0*ones(mb,1);    
rhs=[-1;f;g];  %RHS 
%%%%%%%%%%%%% coefficient matrix
DM=pdist2(colpt, colpt);
A=rbf(DM,c);
coe=A\rhs; 
%%%%%%%%%% Evaluation points
neval=60;  
bmin=min(dsites,[],1);  bmax=max(dsites,[],1);
x=linspace(bmin(1)-.05,bmax(1)+.05,neval);
y=linspace(bmin(2)-.05,bmax(2)+.05,neval);
z=linspace(bmin(3)-.05,bmax(3)+.05,neval);
[xe,ye,ze]=meshgrid(x,y,z);
epoints=[xe(:),ye(:),ze(:)]; %clear xgrid ygrid zgrid 
parfor iter=1:neval^3
    DM_eval = pdist2(epoints(iter,:),colpt);
    DM=rbf(DM_eval,c);
    pf(iter) = DM*coe;  
end
figure (2)
pfit=patch(isosurface(xe,ye,ze,reshape(pf,neval,neval,neval),0));
isonormals(xe,ye,ze,reshape(pf,neval,neval,neval),pfit)
set(pfit,'FaceLighting','gouraud','FaceColor','g','EdgeColor','none');
light('Position',[ 1 0 1],'Style','infinite'); 
view([0,90]);  axis equal; axis off