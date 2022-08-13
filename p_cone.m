function[px_cone,py_cone]=p_cone(Cone_L,Cone_D,Cone_Geom,np_cone)
    t=linspace(pi/2,pi,np_cone);
    px_cone=Cone_L+Cone_L*cos(t);
if Cone_Geom == 'Elips'
    py_cone=Cone_D*sin(t)/2;
elseif Cone_Geom == 'Ogive'
    rho=(Cone_L^2+(Cone_D/2)^2)/Cone_D;
    py_cone=sqrt(rho^2-(Cone_L-px_cone).^2)+Cone_D/2-rho;
elseif Cone_Geom == 'Conic'
    py_cone=px_cone*Cone_D/(2*Cone_L)
end
px_cone=flip(px_cone);
py_cone=flip(py_cone);
end