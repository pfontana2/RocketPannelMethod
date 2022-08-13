%% Inputs - Geometry
%% Nose Cone
rocket.geom.cone.D=1; %Diametro Maximo
rocket.geom.cone.L=3; %Comprimento Total
rocket.geom.cone.Geom='Ogive'; %'Elips'; %Geometria
rocket.geom.cone.nx=15; %Numero Paineis Axial
rocket.geom.cone.nr=15; %Numero Paineis Radial
%% Fuselage
rocket.geom.Fus.N_Sections=1; %Numero de Secoes
rocket.geom.Fus.Sec1.D_top=1; %Diametro superior
rocket.geom.Fus.Sec1.D_bot=1; %Diametro Inferior
rocket.geom.Fus.Sec1.L=10; %Comprimento Total
rocket.geom.Fus.Sec1.nx=15; %Numero Paineis Axial
rocket.geom.Fus.Sec1.nr=15; %Numero Paineis Radial
%% Fins
rocket.fin.N_sets=2; %Numero de Sets
rocket.fin.Set1.CR=1; %Corda da Raiz
rocket.fin.Set1.CT=0.5; %Corda da Ponta
rocket.fin.Set1.Lambda=30; %Enflechamento LE [º]
rocket.fin.Set1.s=1; %Semi-Envergadura
rocket.fin.Set1.n_fins=4; %Numero de Aletas
rocket.fin.Set1.nc=4; %Paineis Corda 
rocket.fin.Set1.ns=6; %Paineis Semi-Envergadura
rocket.fin.Set1.x_LE=rocket.geom.Fus.Sec1.L+rocket.geom.cone.L-rocket.fin.Set1.CR; %Posicao do LE
rocket.fin.Set1.Rot=45; %Rotacao Aletas [º]

rocket.fin.Set2.CR=0.5;
rocket.fin.Set2.CT=0.25;
rocket.fin.Set2.Lambda=30;
rocket.fin.Set2.s=0.5;
rocket.fin.Set2.n_fins=4;
rocket.fin.Set2.nc=4;
rocket.fin.Set2.ns=6;
rocket.fin.Set2.x_LE=rocket.geom.cone.L+rocket.fin.Set2.CR;
rocket.fin.Set2.Rot=0;
%% Inputs - Methods


%% Inputs - Conditions




