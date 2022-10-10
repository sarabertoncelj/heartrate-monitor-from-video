function [RGBDataMerged, RGBDataMergedNorm] = fnMergeRGBData(RGBData, Segments)

S = size(RGBData);
lX = length(Segments.Nx) ; lY = length(Segments.Ny); 
RGBDataMerged = zeros(S(1),S(4)); RGBDataMergedNorm = zeros(S(1),S(4));
if lX > 0 && lY > 0
    if lX~=lY
        disp('Length of X and Y must be the same!');
    else  
        if max(Segments.Nx) > S(2) || max(Segments.Ny) > S(3)
            disp('Defined ROI exceeds the FaceMap!');
        else
            for i=1:lX
                RGBDataMerged = RGBDataMerged + squeeze(RGBData(:,Segments.Nx(i),Segments.Ny(i),:));
                %RGBDataMergedNorm = RGBDataMergedNorm + fnNormalizeData(squeeze(RGBData(:,Segments.Nx(i),Segments.Ny(i),:)),0);
            end
            RGBDataMerged = RGBDataMerged./lX;
            %RGBDataMergedNorm = RGBDataMergedNorm./lX;
            RGBDataMergedNorm = fnNormalizeData(RGBDataMerged,0);
        end
    end
end