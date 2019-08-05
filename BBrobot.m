function BBR = BBrobot(BBtask)

    % BBtask is a structure containing the Baby Robot learning task
    % Number of dimensions of the state vector of the robot:
    nS = BBtask.nS;
    % Number of actions available to the robot:
    nA = BBtask.nA;
    
    % Initialize model-free Q-learning (to decide which action to make)
    wQ = zeros(nS, nA) * 0.01; % Q-learning weights
    Q = zeros(1, nA); % Q-values
    RPEQ = zeros(1, nA); % delta for Q-learning
    sigma2Q = ones(1, nA); % square of variance of RPE in Q-learning
    alphaQ = 0.4; % Q-learning learning rate
    gamma = 0.99; % discount factor (time horizon for reward prediction)
    beta = 50; % exploration rate (inverse temperature)
    % 4 for sigma2Q & QL / 6 for hybrid & schweighofer / 20 or 100 for kalman
    
    % Initialize CACLA Actor-Critic (to learn parameters of actions) 
    delta = 0; % reward-prediction error (reinforcement signal)
    wC = zeros(nS, 1); % critic weights
    wA = zeros(nS, nA); % actor weights
    VC = 0; % critic value at time t in state s
    PA = ones(1, nA) / nA; % actor proba distrib
    ACT = zeros(1, nA); % actor output
    alphaC = 0.5; % critic learning rate
    alphaA = 0.2; % actor learning rate
    sigma = 18.8; % Gaussian width for exploration of action parameter (0-100)
    intervalle = BBtask.intervalle; % interval of possible action parameters
    decisionRule = 'softmax';
    
    % parameters for active exploration on sigma
    varDelta = 0.012; % variance of delta (uncertainty/convergence measure)
    varACT = ones(1, nA) * 0.2; % variance of wA (uncertainty/convergence measure)
    rateSigma = 0.001; % learning rate of low-pass filter on delta/wA
    gainSigma = 100; % gain of transformation of sigma. 100 for wA. 200 for kalmanCOV
    % 20 for hybrid & schweighofer / 200 for kalman / 500 for sigma2Q
    
    % Initialize Kalman TD
    eta = 0.005; % variance of evolution noise v / Same as the original article
    kappa = 0.01; % unscentered transform parameters / Not mentionned in the original article
    varObs = 0.07; % variance of observation noise n / Same as the original article
    initCov = 1; % initialization of covariance matrix
    kalmanV = zeros(1, nA); % action values (TODO later: nS, nA)
    kalmanCOV = eye(nA) * initCov; % covariance matrix (TODO later: eye(nS*nA))
    kalmanNoise = eye(nA) * initCov * eta;
    explorationBonus = 10; % weighting of covariance in bonus added to action value for decision
    % 4 for sigma2Q & hybrid / 10 for kalman
    
    % Initialize Schweighofer meta-learning
    tau1 = 100; % short-term time constant
    tau2 = 1000; % long-term time constant
    star = 0; % short-term running average
    mtar = 0; % mid-term running average
    ltar = 0; % long-term running average
    mu = 0.5; % learning rate of meta-parameter
    metaparam = 0; % meta-parameter to be tuned
    metaparam2 = 0; % meta-parameter to be tuned
    metaseuil = -0.25; % threshold for active exploration
    
    % build a structure for the hybrid robot
    BBR = struct('nS', nS, 'nA', nA, 'alphaC', alphaC, 'alphaA', alphaA, 'beta', beta, 'gamma', gamma, 'sigma', sigma, 'eta', eta, 'kappa', kappa, 'varObs', varObs, 'initCov', initCov, 'explorationBonus', explorationBonus, 'intervalle', intervalle, 'alphaQ', alphaQ, 'rateSigma', rateSigma, 'gainSigma', gainSigma, 'tau1', tau1, 'tau2', tau2, 'mu', mu, 'metaseuil', metaseuil, 'wC', wC, 'wA', wA, 'VC', VC, 'PA', PA, 'ACT', ACT, 'varACT', varACT, 'delta', delta, 'varDelta', varDelta, 'decisionRule', decisionRule, 'wQ', wQ, 'Q', Q, 'RPEQ', RPEQ, 'sigma2Q', sigma2Q, 'kalmanV', kalmanV, 'kalmanCOV', kalmanCOV, 'kalmanNoise', kalmanNoise, 'star', star, 'mtar', mtar, 'ltar', ltar, 'metaparam', metaparam, 'metaparam2', metaparam2);

end