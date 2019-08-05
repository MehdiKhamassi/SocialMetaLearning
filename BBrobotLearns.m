function BBR = BBrobotLearns( BBR, s, a, y, r )
    
    % BBR = structure containing the baby robot
    % s = state where the robot was
    % a = executed action (has 2 components, number and param)
    % y = state where the robot found himself after doing action u
    % r = reward obtained by the robot when arriving in state y
    % eng = level of engagement of the child

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Learning in Schweighofer meta-learning
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % computing short-term average reward
    BBR.star = BBR.star + (r - BBR.star) / BBR.tau1;
    % computing mid-term average reward (Schweighofer 1)
    BBR.mtar = BBR.mtar + (BBR.star - BBR.mtar) / BBR.tau2;
    % updating the meta-parameter (Schweighofer 1)
    BBR.metaparam = BBR.metaparam + BBR.mu * (BBR.star - BBR.mtar);
    % computing mid-term average reward (Schweighofer 2)
    BBR.ltar = BBR.ltar + (r - BBR.ltar) / BBR.tau2;
    % updating the meta-parameter (Schweighofer 2)
    BBR.metaparam2 = BBR.metaparam2 + BBR.mu * (BBR.star - BBR.ltar);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Learning in Kalman TD
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % computing sigma points
    [sigmaPoints, weights] = computeSigmaPoints(BBR.kalmanV, BBR.kalmanCOV, BBR.kappa);
    % predicting reward
    rewardsPredicted = zeros(size(sigmaPoints, 1), 1);
    for j = 1 : size(sigmaPoints, 1)
        rewardsPredicted(j) = sigmaPoints(j,a.action) - BBR.gamma * max(sigmaPoints(j, :));
    end
    rewardPredicted = rewardsPredicted' * weights;
    % determining the gain of update in kalman filter
    covValuesRewards = 0; covRewards = BBR.varObs;
    for j = 1 : size(sigmaPoints, 1)
        covValuesRewards = covValuesRewards + weights(j) * (sigmaPoints(j,:) - BBR.kalmanV) * (rewardsPredicted(j) - rewardPredicted);
        covRewards = covRewards + weights(j) * (rewardsPredicted(j) - rewardPredicted) ^ 2;
    end
    kalmanGain = covValuesRewards / covRewards;
    % updating action values and covariance matrix
    BBR.kalmanV = BBR.kalmanV + kalmanGain * (r - rewardPredicted);
    BBR.kalmanCOV = BBR.kalmanCOV - (kalmanGain' * covRewards) * kalmanGain;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Learning action values with Q-learning
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % computing Q-values in the new state y
    newQvalues = y * BBR.wQ;
    % computing reward prediction error
    BBR.RPEQ(a.action) = r + BBR.gamma * max(newQvalues) - BBR.Q(a.action);
    % updating sigma^2 in Q-learning
    BBR.sigma2Q(a.action) = (1 - BBR.alphaQ) * BBR.sigma2Q(a.action) + BBR.alphaQ * BBR.RPEQ(a.action) ^ 2;
    % updating wQ weights through Q-learning
    BBR.wQ(:, a.action) = BBR.wQ(:, a.action) + BBR.alphaQ * BBR.RPEQ(a.action) * s';
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Learning action parameters in the CACLA Actor-Critic
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% UPDATING THE CRITIC
    % Compute the critic value function in the new state y
    value = y * BBR.wC;
    % Compute reinforcement signal (temporal-difference error)
    delta = r + BBR.gamma * value - BBR.VC;
    % Update exploration param sigma
    %BBR.sigma = (1 - BBR.rateSigma) * BBR.sigma + BBR.rateSigma * 100 * abs(delta - BBR.delta);
    BBR.varDelta = (1 - BBR.rateSigma) * BBR.varDelta + BBR.rateSigma * abs(delta);
    % Store the critic delta
    BBR.delta = delta;
    % Store the critic value for the next timestep
    BBR.VC = value;
    % Update the critic weights with TD-Learning
    BBR.wC = BBR.wC + BBR.alphaC * BBR.delta * s';
    
    %% UPDATING THE ACTOR
    % only when delta > 0 according to van Hasselt & Wiering 2007
    %if (BBR.delta > 0)
        % recomputing the action output
        %ACT = s * BBR.wA;
        % updating only for action performed a.action
        BBR.wA(:, a.action) = BBR.wA(:, a.action) + BBR.alphaA * BBR.delta * (a.param - BBR.ACT(a.action)) * s'; 
        %BBR
    %end
    
    %% MEASURING variations of wA in CACLA actor
    % useful to dynamically tune sigma (explore param) based on var(wA)
    newACT = s * BBR.wA;
    BBR.varACT(a.action) = (1 - BBR.rateSigma) * BBR.varACT(a.action) + BBR.rateSigma * abs(newACT(a.action) - BBR.ACT(a.action));
    
        
end