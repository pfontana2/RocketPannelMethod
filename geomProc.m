function [geomDataB,geomDataW] = geomProc(CellsB,CellsW)
for i=1:length(CellsB)
    geomDataB.centroid(i,1:3)=[mean(CellsB(i,1:4)),mean(CellsB(i,5:8)),mean(CellsB(i,9:12))];   
end


end