% Cost Volume Aggregation with block averaging
% Performs per-slice averaging of input cost volume
%
% Syntax: confidenceMap = comp_confidence(cost)
% Cost - input 3D Cost Volume
% confidenceMap - 2D map of confidence values for the disparity estimates

function confidenceMap = comp_confidence(cost)
    
    lowConfidenceThreshold = 0.1; 
       
    [height, width, ~] = size(cost);
    confidenceMap = zeros(height, width);

    for i = 1:height
        for j = 1:width
            disparityCosts = squeeze(cost(i, j, :));
            % Invert disparity costs to use findpeaks to find the minima
            invertedCosts = -disparityCosts;
            [peaks, locs] = findpeaks(invertedCosts);
            peaks = abs(peaks);
            if length(peaks) >= 2
                [sortedPeaks, sortedIndices] = sort(peaks, 'descend');
                minA = sortedPeaks(sortedIndices(end-1)); % second smallest cost
                minB = sortedPeaks(sortedIndices(end));   % smallest cost
                PR = abs(minA - minB) / minA;
                confidenceMap(i, j) = PR;
            elseif length(peaks) == 1
                confidenceMap(i, j) = 3;
            else
                confidenceMap(i, j) = 0; 
            end
        end
    end

    confidenceMap(confidenceMap < lowConfidenceThreshold) = 0;
end