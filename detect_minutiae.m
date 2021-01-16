function [CentroidFinX, CentroidFinY, CentroidSepX, CentroidSepY] = detect_minutiae(img)

fun=@minutie;
L = nlfilter(img, [3,3], fun);
    
% Endpoints
LFin=(L==1);
LFinLab=bwlabel(LFin);
propFin=regionprops(LFinLab, 'Centroid');
CentroidFin=round(cat(1,propFin(:).Centroid));
CentroidFinX=CentroidFin(:,1);
CentroidFinY=CentroidFin(:,2);

% Bifurcations
LSep=(L==3);  
LSepLab=bwlabel(LSep);
propSep=regionprops(LSepLab, 'Centroid', 'Image');
CentroidSep=round(cat(1,propSep(:).Centroid));
CentroidSepX=CentroidSep(:,1);
CentroidSepY=CentroidSep(:,2);

end

