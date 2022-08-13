% close all
% clc
% clear
%% Inputs
% Nose Cone
Cone_D=1;
Cone_L=3*Cone_D;
Cone_Geom= 'Elipsoid';
npx_cone=20;
npr=20;
% Fuselage
Fus_L=5*Cone_D;
npx_fus=20;
% Fins
Cr=1;
Ct=0.5;
Lambda=45;
s=1;
n_fins=3;
nc=4;
ns=6;
x_LE=Fus_L+Cone_L-Cr;

%% Pannel Gen

theta=linspace(0,2*pi,npr+1);
[px_cone,pr_cone]=p_cone(Cone_L,Cone_D,Cone_Geom,npx_cone);
M=zeros(3*npx_cone,npr+1);
for i=1:npx_cone+npx_fus
    if i<=npx_cone
        M(3*i-2,:)=px_cone(i);
        M(3*i-1,:)=cos(theta')*pr_cone(i);
        M(3*i,:)=sin(theta)*pr_cone(i);
    else
        M(3*i-2,:)=Cone_L+(i-npx_cone)*Fus_L/npx_fus;
        M(3*i-1,:)=cos(theta')*Cone_D/2;
        M(3*i,:)=sin(theta)*Cone_D/2;
    end
%     plot3(M(3*i-2,:),M(3*i-1,:),M(3*i,:),'or')
    hold on
end
axis equal
Cells=zeros((npx_cone+npx_fus)*npr,12);
n=1;
% figure
for i=1:npx_cone+npx_fus
    if i~=1
        for j=1:npr
           Cells(n,1:4)=[M(3*i-2,j) M(3*i-2,j+1) M(3*(i-1)-2,j+1) M(3*(i-1)-2,j)]; 
           Cells(n,5:8)=[M(3*i-1,j) M(3*i-1,j+1) M(3*(i-1)-1,j+1) M(3*(i-1)-1,j)]; 
           Cells(n,9:12)=[M(3*i,j) M(3*i,j+1) M(3*(i-1),j+1) M(3*(i-1),j)]; 
           p=fill3(Cells(n,1:4),Cells(n,5:8),Cells(n,9:12),'b');
           p.FaceAlpha = 0.5;
           hold on
           n=n+1;
        end
    else 
        for j=1:npr
           Cells(n,1:4)=[M(3*i-2,j) M(3*i-2,j+1) 0 0]; 
           Cells(n,5:8)=[M(3*i-1,j) M(3*i-1,j+1) 0 0]; 
           Cells(n,9:12)=[M(3*i,j) M(3*i,j+1) 0 0]; 
           p=fill3(Cells(n,1:4),Cells(n,5:8),Cells(n,9:12),'b');
           p.FaceAlpha = 0.5;
           hold on
           n=n+1;
        end
    end    
end
axis equal



M1=zeros(3*ns,nc);
% figure
for i=1:ns
    y=(i-1)*s/(ns-1);
    M1(3*i,:)=y+Cone_D/2;
    c=Cr-(Cr-Ct)*y/s;
    xLEc=y*tand(Lambda);
    for j=1:nc
        M1(3*i-2,j)=(j-1)*c/(nc-1)+xLEc+x_LE;
    end
    for n=1:n_fins
        if n==1
%             plot3(M1(3*i-2,:),M1(3*i-1,:),M1(3*i,:),'-or')
            hold on
        elseif n==2
            M2(3*i-2,:)=M1(3*i-2,:);
            M2(3*i-1,:)=M1(3*i,:)*sind(120);
            M2(3*i,:)=M1(3*i,:)*cosd(120);
%             plot3(M2(3*i-2,:),M2(3*i-1,:),M2(3*i,:),'-or')
            hold on
        elseif n==3
            M3(3*i-2,:)=M1(3*i-2,:);
            M3(3*i-1,:)=M1(3*i,:)*sind(-120);
            M3(3*i,:)=M1(3*i,:)*cosd(-120);
%             plot3(M3(3*i-2,:),M3(3*i-1,:),M3(3*i,:),'-or')
            hold on            
        end
    end
end

n=1;
for i=1:ns-1
        for j=1:nc-1
           CellsA1(n,1:4)=[M1(3*i-2,j) M1(3*i-2,j+1) M1(3*(i+1)-2,j+1) M1(3*(i+1)-2,j)]; 
           CellsA1(n,5:8)=[M1(3*i-1,j) M1(3*i-1,j+1) M1(3*(i+1)-1,j+1) M1(3*(i+1)-1,j)]; 
           CellsA1(n,9:12)=[M1(3*i,j) M1(3*i,j+1) M1(3*(i+1),j+1) M1(3*(i+1),j)]; 
           p=fill3(CellsA1(n,1:4),CellsA1(n,5:8),CellsA1(n,9:12),'r');
           p.FaceAlpha = 0.5;
           hold on
           n=n+1;
        end 
end
n=1;
for i=1:ns-1
        for j=1:nc-1
           CellsA2(n,1:4)=[M2(3*i-2,j) M2(3*i-2,j+1) M2(3*(i+1)-2,j+1) M2(3*(i+1)-2,j)]; 
           CellsA2(n,5:8)=[M2(3*i-1,j) M2(3*i-1,j+1) M2(3*(i+1)-1,j+1) M2(3*(i+1)-1,j)]; 
           CellsA2(n,9:12)=[M2(3*i,j) M2(3*i,j+1) M2(3*(i+1),j+1) M2(3*(i+1),j)]; 
           p=fill3(CellsA2(n,1:4),CellsA2(n,5:8),CellsA2(n,9:12),'r');
           p.FaceAlpha = 0.5;
           hold on
           n=n+1;
        end 
end
n=1;
for i=1:ns-1
        for j=1:nc-1
           CellsA3(n,1:4)=[M3(3*i-2,j) M3(3*i-2,j+1) M3(3*(i+1)-2,j+1) M3(3*(i+1)-2,j)]; 
           CellsA3(n,5:8)=[M3(3*i-1,j) M3(3*i-1,j+1) M3(3*(i+1)-1,j+1) M3(3*(i+1)-1,j)]; 
           CellsA3(n,9:12)=[M3(3*i,j) M3(3*i,j+1) M3(3*(i+1),j+1) M3(3*(i+1),j)]; 
           p=fill3(CellsA3(n,1:4),CellsA3(n,5:8),CellsA3(n,9:12),'r');
           p.FaceAlpha = 0.5;
           hold on
           n=n+1;
        end 
end
axis equal

