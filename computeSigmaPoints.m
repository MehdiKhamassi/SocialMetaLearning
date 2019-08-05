function [ sigmaPoints, weights ] = computeSigmaPoints( values, covMatrix, kappa )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %Determinitics sampling of sigma-points around the current Q-VAlues of Kalman Q-Learning
    %returns an array of sigma-points and weight
    % See Kalman Temporal Differences: The deterministic case, Geist et al, 2009 for explanation of the method
    
    % init parameters
    n = length(values);
    sigmaPoints = zeros(2 * n + 1, n);
    weights = zeros(2 * n + 1 , 1);
    sigmaPoints(1, :) = values;
    weights(1) = kappa / (n + kappa);
    
    try
        c = chol((n + kappa) * covMatrix)';
        for j = 1 : n
            sigmaPoints(j + 1, :) = values + c(:, j)';
            sigmaPoints(j + n + 1, :) = values - c(:, j)';
        end
        weights(2 : 2 * n + 1) = 1/(2*n+kappa);
    catch ME
        
    end
    
end

