% Cost Volume Aggregation with bilateral  filtering
% Performs per-slice filtering of input cost volume
%
% Syntax: CostAgg = aggregate_cost_guided(Cost, radius, simga);
% Cost - input 3D Cost Volume
% GuideImage - image to guide the filtering of the cost volume slices
% radius - radius of square window (size = radius*2 + 1)

% CostAgg - aggregated cost

%function CostAgg = aggregate_cost_guided(cost, guideImage, radius )

%smoothValueDistance = ? 
%smoothValueColor = ? 
% smoothValueDistance - parameter of Gaussian filter over distance
% smootValueColor - parameter of Gaussian filter over color difference

%end

function CostAgg = aggregate_cost_bilateral(cost, guideImage, radius)
    smoothValueDistance = 10; 
    smoothValueColor = 10; 
    [height, width, ~] = size(cost);
    CostAgg = zeros(height, width, size(cost, 3));

    [dx, dy] = meshgrid(-radius:radius, -radius:radius);
    spatialWeights = exp(-(dx.^2 + dy.^2) / (2 * smoothValueDistance^2));
  
    for d = 1:size(cost, 3)
        for i = 1:height
            for j = 1:width
                iMin = max(i - radius, 1);
                iMax = min(i + radius, height);
                jMin = max(j - radius, 1);
                jMax = min(j + radius, width);
               
                guideWindow = double(guideImage(iMin:iMax, jMin:jMax, :));
                costSlice = double(cost(iMin:iMax, jMin:jMax, d));
                
                guideCenter = double(guideImage(i, j, :));
                colorDiff = guideWindow - guideCenter;
                colorWeights = exp(-sum(colorDiff.^2, 3) / (2 * smoothValueColor^2));
                
                bilateralWeights = spatialWeights((iMin:iMax) - i + radius + 1, (jMin:jMax) - j + radius + 1) .* colorWeights;
                
                CostAgg(i, j, d) = sum(sum(bilateralWeights .* costSlice)) / sum(sum(bilateralWeights));
            end
        end
    end
end

