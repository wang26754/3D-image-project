%function [ filledfill_blanks ] = fill_blanks( Disp, outliers, Conf ) 
%UNTITLED Summary of this function goes here
%   Disp - Disparity map to be filtered
%   outliers - binary mask of pixels that should be filled
%   Conf - confidence values for the disparity map, if too low -> also fill
function [filledDisp] = fill_blanks(Disp, outliers, Conf)
    
    filledDisp = Disp;
    threshold = 0;   
    for iter = 1:5
        for i = 2:size(Disp, 1) - 1
            for j = 2:size(Disp, 2) - 1
                if outliers(i, j) || Conf(i, j) < threshold
                    neighborhood = Disp(i-1:i+1, j-1:j+1);
                    filteredNeighborhood = neighborhood(~outliers(i-1:i+1, j-1:j+1) & Conf(i-1:i+1, j-1:j+1) >= threshold);
                    
                    if ~isempty(filteredNeighborhood)
                        filledDisp(i, j) = median(filteredNeighborhood(:));
                    end
                end
            end
        end
    end
end





