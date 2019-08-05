function [BBR, a, probaA, probaPISA] = BBrobotDecides(BBT, BBR, whichModel, s)

    % BBR is a structure containing the Baby Robot
    % s = current state
    % decisionRule = 'rand' / 'softmax' / 'max' / 'matching' / 'epsilon'
    
    % output of the robot learning system
    BBR.Q = s * BBR.wQ;
    BBR.ACT = s * BBR.wA;
    BBR.VC = s * BBR.wC;
    
    % kalman prediction step
    BBR.kalmanNoise = BBR.kalmanCOV * BBR.eta;
    BBR.kalmanCOV = BBR.kalmanCOV + BBR.kalmanNoise;
    
    %% decision of the action to be performed by the robot
    switch(whichModel)
        case 1 %% Q-learning
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.Q, BBR.decisionRule, BBR.beta, 0 );
        case 2 %% Kalman
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.kalmanV + diag(BBR.kalmanCOV)' * BBR.explorationBonus, BBR.decisionRule, BBR.beta, 0 ); % BBR.kalmanV + diag(BBR.kalmanCOV)'.^2
        case 3 %% Sigma2Q
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.Q + BBR.sigma2Q * BBR.explorationBonus, BBR.decisionRule, BBR.beta, 0 );
        case 4 %% Hybrid
            BBR.beta = max(0,BBR.metaparam+2); % meta-learning
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.Q + BBR.sigma2Q * BBR.explorationBonus, BBR.decisionRule, BBR.beta, 0 );
        case 5 %% Schweighofer 1
            BBR.beta = max(0,BBR.metaparam+2); % meta-learning
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.Q, BBR.decisionRule, BBR.beta, 0 );
        case 6 %% Schweighofer 2
            BBR.beta = max(0,BBR.metaparam2+2); % meta-learning
            [ a.action, BBR.PA ] = valueBasedDecision( BBR.Q, BBR.decisionRule, BBR.beta, 0 );
        case 7 %% Kalman original
            [ a.action, BBR.PA ] = valueBasedDecision( diag(BBR.kalmanCOV)', BBR.decisionRule, BBR.beta, 0 );
    end
    probaA = BBR.PA(BBT.optimal);
    
    %% decision of the param of action to be performed
    a.param = BBR.ACT(a.action); % default == exploitation
    if (rand < 0) % set this value >0 to add random exploration
        a.param = rand * 200 - 100;
        probaPISA = 1 / length(BBT.intervalle);
    else if (rand < 1) % set this value <1 to add exploitation
        % Here we will explore by choosing a value around the learned
        % action parameter a.param within a Gaussian distribution of mean =
        % a.param and variance = BBR.sigma.
        % Each model has a different way of determining BBR.sigma.
        %% UPDATING sigma for CACLA actor exploration
        switch(whichModel)
            case {2,7} %% Kalman
                % OLD Kalman: BBR.sigma = BBR.kalmanCOV(a.action, a.action) * BBR.gainSigma; % if cov of Kalman Q-values
                BBR.sigma = 20 / (1 + 19 * exp(-1 * BBR.gainSigma * BBR.kalmanCOV(a.action, a.action))); % if cov of Kalman Q-values
            case 3 %% Sigma2Q
                % OLD SIGMA2Q:
                %BBR.sigma = BBR.sigma2Q(a.action) * BBR.gainSigma; % if sigma2 of QL
                % NEW SIGMA2Q:
                BBR.sigma = 20 / (1 + 19 * exp(-1 * BBR.gainSigma * BBR.sigma2Q(a.action))); % if sigma2 of QL
            case 4 %% Hybrid
                BBR.sigma = 20 / (1 + 19 * exp(-1 * BBR.gainSigma * BBR.sigma2Q(a.action))) + 20 / (1 + 19 * exp(BBR.gainSigma * BBR.metaparam)); % if hybrid (sigma2Q + metaparam)
            case 5 %% Schweighofer 1
                % OLD Schweighofer Doya: BBR.sigma = ((10 * (1 / (1 + exp(BBR.metaparam)) - 0.5)) > -0.25) * ((10 * (1 / (1 + exp(BBR.metaparam)) - 0.5)) + 0.25) * BBR.gainSigma; % if metaparam of schweighofer
                BBR.sigma = 20 / (1 + 19 * exp(BBR.gainSigma * BBR.metaparam));
            case 6 %% Schweighofer 2
                BBR.sigma = 20 / (1 + 19 * exp(BBR.gainSigma * BBR.metaparam2));
            otherwise %% QL or old sigma as fct of variations of wA
                % for QL, BBR.sigma is a fixed parameter.
                %multiplier varACT par 1000 pour l'action concernée et ça donne sigma
                %BBR.sigma = BBR.varACT(a.action) * BBR.gainSigma; % if variation of wA
                %BBR.sigma = exp(17.1049 - 0.1500 / BBR.varDelta); % if varACT == critic's delta
                %%BBR.sigma = 267 - 2 / BBR.varDelta; % if varACT == critic's delta (non exp)
        end
        if (BBR.sigma <= 0.1)
            BBR.sigma = 0.1;
        end
        %% CACLA's original exploration of action parameter
        pisa = exp(- (BBR.intervalle - a.param) .^ 2 ./ (2 * BBR.sigma ^ 2)) ./ (sqrt(2 * pi * BBR.sigma));
        pisa = pisa / sum(pisa);
        % pisa is a pdf centered on a.param with variance = BBR.sigma^2
        a.param = BBR.intervalle(drand01(pisa));
        % we randomly pick a.param from the pisa density function
        probaPISA = pisa(floor(1+(BBT.engMu+100)/5));
    else
        probaPISA = 1 / length(BBT.intervalle);
    end; end
            
end