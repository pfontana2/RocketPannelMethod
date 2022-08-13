clc
clear all
close all
rocket_def;
[CellsB,CellsW] = panGen(rocket);
% [geomDataB,geomDataW] = geomProc(CellsB,CellsW);
plot_geom(true,rocket,CellsB,CellsW);





function plot_geom(p,rocket,CellsB,CellsW)
if p
    figure
    for i=1:length(CellsB)
        p=fill3(CellsB(i,1:4),CellsB(i,5:8),CellsB(i,9:12),'b');
        p.FaceAlpha = 0.5;
        hold on
%         plot3(CellsB(i,13),CellsB(i,14),CellsB(i,15),'.y')
    end
    axis equal

    for k=1:rocket.fin.N_sets
        var_name= strcat('Set',num2str(k));
        for i=1:rocket.fin.(var_name).n_fins 
            my_field_M = strcat('Wing',num2str(i));
            for j=1:length(CellsW.(var_name).Wing1)
                p=fill3(CellsW.(var_name).(my_field_M)(j,1:4),CellsW.(var_name).(my_field_M)(j,5:8),CellsW.(var_name).(my_field_M)(j,9:12),'r');
                p.FaceAlpha = 0.5;
                hold on
%                 plot3(CellsW.(var_name).(my_field_M)(j,13),CellsW.(var_name).(my_field_M)(j,14),CellsW.(var_name).(my_field_M)(j,15),'.y')
            end

        end
    end
end
end