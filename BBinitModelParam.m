function BBR = BBinitModelParam( BBR, vectParam, whichModel )
    % whichModel = 1 QL 2 kalman 3 sigma2Q 4 hybrid 5 schweig1 6 schweig2
    % vectParam contains the list of parameters of the studied model
    % BBR = structure containing the baby robot
    
    % set model parameters for the baby robot
    switch(whichModel)
        case 1 %% Q-learning
            BBR.beta = vectParam(1);
            BBR.gamma = vectParam(2);
            BBR.alphaC = vectParam(3);
            BBR.alphaA = vectParam(4);
            BBR.sigma = vectParam(5);
            BBR.alphaQ = vectParam(6);
        case {2,7} %% Kalman
            BBR.beta = vectParam(1);
            BBR.gamma = vectParam(2);
            BBR.alphaC = vectParam(3);
            BBR.alphaA = vectParam(4);
            BBR.gainSigma = vectParam(5);
            BBR.explorationBonus = vectParam(6);
            BBR.eta = vectParam(7);
            BBR.kappa = vectParam(8);
            BBR.varObs = vectParam(9);
        case 3 %% Sigma2Q
            BBR.beta = vectParam(1);
            BBR.gamma = vectParam(2);
            BBR.alphaC = vectParam(3);
            BBR.alphaA = vectParam(4);
            BBR.gainSigma = vectParam(5);
            BBR.explorationBonus = vectParam(6);
        case 4 %% Hybrid
            BBR.beta = vectParam(1);
            BBR.gamma = vectParam(2);
            BBR.alphaC = vectParam(3);
            BBR.alphaA = vectParam(4);
            BBR.gainSigma = vectParam(5);
            BBR.explorationBonus = vectParam(6);
            BBR.tau1 = vectParam(7);
            BBR.tau2 = vectParam(8);
            BBR.mu = vectParam(9);
        case {5,6} %% Schweighofer 1 & 2
            BBR.beta = vectParam(1);
            BBR.gamma = vectParam(2);
            BBR.alphaC = vectParam(3);
            BBR.alphaA = vectParam(4);
            BBR.rateSigma = vectParam(5);
            BBR.tau1 = vectParam(6);
            BBR.tau2 = vectParam(7);
            BBR.mu = vectParam(8);
    end
    
end