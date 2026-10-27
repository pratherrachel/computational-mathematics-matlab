clear;
%Calling in the desired image
h=imread('harley.jpg');
H=im2double(h);

%Extracting the red, green and blue from image
R=H(:,:,1);  G=H(:,:,2);  B=H(:,:,3);

%Running SVD on the matrices extracted from the image
[m,n]=size(R);

[VecR,ValR]=eig(R'*R);  [VecG,ValG]=eig(G'*G);  [VecB,ValB]=eig(B'*B);
    %Building the S matrix for SVD
ValR=diag(ValR);        ValG=diag(ValG);        ValB=diag(ValB);
[sR,inR]=maxk(ValR,n);  [sG,inG]=maxk(ValG,n);  [sB,inB]=maxk(ValB,n);
sR=diag(sqrt(sR));      sG=diag(sqrt(sG));      sB=diag(sqrt(sB));
sR=sR(1:m,1:n);         sG=sG(1:m,1:n);         sB=sB(1:m,1:n);
    %Building the V matirx for SVD
vR=zeros(n,n);          vG=zeros(n,n);          vB=zeros(n,n);
    %Since RGB are the same size we can run one loop here
    parfor i=1:n 
        vR(:,i)=VecR(:,inR(i));
        vG(:,i)=VecG(:,inG(i));
        vB(:,i)=VecB(:,inB(i)); 
    end
    %Building the U matrix for SVD
uR=zeros(m,m);        uG=zeros(m,m);    uB=zeros(m,m);
    %Since RGB are the same size we can run one loop here
    parfor i=1:m 
        uR(:,i)=1/sR(i,i)*R*vR(:,i);
        uG(:,i)=1/sG(i,i)*G*vG(:,i);
        uB(:,i)=1/sB(i,i)*B*vB(:,i); 
    end

%Completeing compression at rank 300
k1=300;
uR1=uR(:,1:k1);sR1=sR(1:k1,1:k1);vR1=vR(:,1:k1);
uG1=uG(:,1:k1);sG1=sG(1:k1,1:k1);vG1=vG(:,1:k1);
uB1=uB(:,1:k1);sB1=sB(1:k1,1:k1);vB1=vB(:,1:k1);
Rk1=uR1*sR1*vR1';Gk1=uG1*sG1*vG1';Bk1=uB1*sB1*vB1';

%Completeing compression at rank 150
k2=150;
uR2=uR(:,1:k2);sR2=sR(1:k2,1:k2);vR2=vR(:,1:k2);
uG2=uG(:,1:k2);sG2=sG(1:k2,1:k2);vG2=vG(:,1:k2);
uB2=uB(:,1:k2);sB2=sB(1:k2,1:k2);vB2=vB(:,1:k2);
Rk2=uR2*sR2*vR2';Gk2=uG2*sG2*vG2';Bk2=uB2*sB2*vB2';

%Completeing compression at rank 100
k3=100;
uR3=uR(:,1:k3);sR3=sR(1:k3,1:k3);vR3=vR(:,1:k3);
uG3=uG(:,1:k3);sG3=sG(1:k3,1:k3);vG3=vG(:,1:k3);
uB3=uB(:,1:k3);sB3=sB(1:k3,1:k3);vB3=vB(:,1:k3);
Rk3=uR3*sR3*vR3';Gk3=uG3*sG3*vG3';Bk3=uB3*sB3*vB3';

%Completeing compression at rank 50
k4=50;
uR4=uR(:,1:k4);sR4=sR(1:k4,1:k4);vR4=vR(:,1:k4);
uG4=uG(:,1:k4);sG4=sG(1:k4,1:k4);vG4=vG(:,1:k4);
uB4=uB(:,1:k4);sB4=sB(1:k4,1:k4);vB4=vB(:,1:k4);
Rk4=uR4*sR4*vR4';Gk4=uG4*sG4*vG4';Bk4=uB4*sB4*vB4';

%Building the compressed matrix and then printing in one plot
subplot(2,2,1)
Hk1(:,:,1)=Rk1; Hk1(:,:,2)=Gk1; Hk1(:,:,3)=Bk1;
hk1=im2uint8(Hk1);
imshow(hk1)
title('Rank 300')

subplot(2,2,2)
Hk2(:,:,1)=Rk2; Hk2(:,:,2)=Gk2; Hk2(:,:,3)=Bk2;
hk2=im2uint8(Hk2);
imshow(hk2)
title('Rank 150')

subplot(2,2,3)
Hk3(:,:,1)=Rk3; Hk3(:,:,2)=Gk3; Hk3(:,:,3)=Bk3;
hk3=im2uint8(Hk3);
imshow(hk3)
title('Rank 100')

subplot(2,2,4)
Hk4(:,:,1)=Rk4; Hk4(:,:,2)=Gk4; Hk4(:,:,3)=Bk4;
hk4=im2uint8(Hk4);
imshow(hk4)
title('Rank 50')
