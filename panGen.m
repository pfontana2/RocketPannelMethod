function [CellsB,CellsW] = panGen(rocket)
%% Inputs
% Nose Cone
Cone_D=rocket.geom.cone.D;
Cone_L=rocket.geom.cone.L;
Cone_Geom= rocket.geom.cone.Geom;
npx_cone=rocket.geom.cone.nx;
npr=rocket.geom.cone.nr;
% Fuselage
Fus_L=rocket.geom.Fus.Sec1.L;
npx_fus=rocket.geom.Fus.Sec1.nx;
%% Pannel Gen - Body

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
end
CellsB=zeros((npx_cone+npx_fus)*npr,12);
n=1;
for i=1:npx_cone+npx_fus
    if i~=1
        for j=1:npr
           CellsB(n,1:4)=[M(3*i-2,j) M(3*i-2,j+1) M(3*(i-1)-2,j+1) M(3*(i-1)-2,j)]; 
           CellsB(n,5:8)=[M(3*i-1,j) M(3*i-1,j+1) M(3*(i-1)-1,j+1) M(3*(i-1)-1,j)]; 
           CellsB(n,9:12)=[M(3*i,j) M(3*i,j+1) M(3*(i-1),j+1) M(3*(i-1),j)];
           CellsB(n,13:15)=[mean(CellsB(n,1:4)),mean(CellsB(n,5:8)),mean(CellsB(n,9:12))];
           n=n+1;
        end
    else 
        for j=1:npr
           CellsB(n,1:4)=[M(3*i-2,j) M(3*i-2,j+1) 0 0]; 
           CellsB(n,5:8)=[M(3*i-1,j) M(3*i-1,j+1) 0 0]; 
           CellsB(n,9:12)=[M(3*i,j) M(3*i,j+1) 0 0];
           CellsB(n,13:15)=[mean(CellsB(n,1:4)),mean(CellsB(n,5:8)),mean(CellsB(n,9:12))];
           n=n+1;
        end
    end    
end
%% Pannel Gen - Wings

[CellsW] = genWings(rocket);

end

function [CellsW] = genWings(rocket)
    for nset=1:rocket.fin.N_sets
        var_name= strcat('Set',num2str(nset));
        Cr=rocket.fin.(var_name).CR;
        Ct=rocket.fin.(var_name).CT;
        Lambda=rocket.fin.(var_name).Lambda;
        s=rocket.fin.(var_name).s;
        n_fins=rocket.fin.(var_name).n_fins;
        nc=rocket.fin.(var_name).nc;
        ns=rocket.fin.(var_name).ns;
        x_LE=rocket.fin.(var_name).x_LE;
        RotSet=rocket.fin.(var_name).Rot;

        RotAng=360/n_fins;
        data.M1=zeros(3*ns,nc);
        for i=1:ns
            y=(i-1)*s/(ns-1);
            data.M1(3*i,:)=y+rocket.geom.cone.D/2;
            c=Cr-(Cr-Ct)*y/s;
            xLEc=y*tand(Lambda);
            for j=1:nc
                data.M1(3*i-2,j)=(j-1)*c/(nc-1)+xLEc+x_LE;
            end
            for n=2:n_fins+1
                Rot=RotAng*(n-1);
                my_field = strcat('M',num2str(n));
                data.(my_field)(3*i-2,:)=data.M1(3*i-2,:);
                data.(my_field)(3*i-1,:)=data.M1(3*i,:)*sind(Rot+RotSet);
                data.(my_field)(3*i,:)=data.M1(3*i,:)*cosd(Rot+RotSet);
            end
        end
        data.M1=data.(my_field);
        for k=1:n_fins
            n=1;
            my_field_Cells = strcat('Wing',num2str(k));
            my_field_M = strcat('M',num2str(k));
            for i=1:ns-1
                    for j=1:nc-1
                       dat.(my_field_Cells)(n,1:4)=[data.(my_field_M)(3*i-2,j) data.(my_field_M)(3*i-2,j+1) data.(my_field_M)(3*(i+1)-2,j+1) data.(my_field_M)(3*(i+1)-2,j)]; 
                       dat.(my_field_Cells)(n,5:8)=[data.(my_field_M)(3*i-1,j) data.(my_field_M)(3*i-1,j+1) data.(my_field_M)(3*(i+1)-1,j+1) data.(my_field_M)(3*(i+1)-1,j)]; 
                       dat.(my_field_Cells)(n,9:12)=[data.(my_field_M)(3*i,j) data.(my_field_M)(3*i,j+1) data.(my_field_M)(3*(i+1),j+1) data.(my_field_M)(3*(i+1),j)]; 
                       dat.(my_field_Cells)(n,13:15)=[mean(dat.(my_field_Cells)(n,1:4)),mean(dat.(my_field_Cells)(n,5:8)),mean(dat.(my_field_Cells)(n,9:12))];
                       n=n+1;
                    end 
            end
        end
        CellsW.(var_name)=dat;
    end
end