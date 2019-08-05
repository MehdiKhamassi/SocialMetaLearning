function [ BBT, BBR, s, a, logs ] = BBrunTrial( BBT, BBR, whichModel, s, a )
    
    % BBT = task used for Baby Robot learning
    % BBR = structure containing the baby robot
    % whichModel = 1 QL 2 kalman 3 sigma2Q 4 hybrid 5 schweig1 6 schweig2
    % s = state vector in which the robot was
    % a = structure containing [executed action, action parameter]
    
    %% UPDATING THE TASK STATE
    % Perform a step of the TASK by executing the action decided outside the
    % function
    % for the moment, only the pointing action can increase the child's
    % engagement
    %[y,r] = BBtaskStep(BBT, s, a); % y = new state ; r = new reward
    y = s; % new state
    r = 0; % reward
    olds = s; % storing s
    olda = a; % storing a
    
    %% UPDATING THE CHILD ENGAGEMENT
    % storing the old engagement
    oldEng = BBT.cENG;
    % computing the new engagement
    if (a.action == BBT.optimal)
%         %% restrictive child engagement
%         if ((a.param >= -20) && (a.param <= 20))
%             BBT.cENG = BBT.cENG + BBT.reeng * (BBT.maxENG - BBT.cENG);
%         else
%             BBT.cENG = BBT.cENG + BBT.forget * (BBT.minENG - BBT.cENG);
%         end
%         % (a.param >= 50) maintains engagement around 0.5
%         % (a.param >= 60) * (a.param <= 70) maintains eng around 0.1
        
        %% gaussian child engagement
        % probaEng is between -1 (disengagement) and 1 (reengagement)
        probaEng = (exp((- (a.param - BBT.engMu) ^ 2) / (2 * BBT.engSig ^ 2)) - 0.5) * 2;
        if (probaEng >= 0)
            BBT.cENG = BBT.cENG + probaEng * BBT.reeng * (BBT.maxENG - BBT.cENG);
        else
            BBT.cENG = BBT.cENG - probaEng * BBT.forget * (BBT.minENG - BBT.cENG);
        end
    else % the robot performed a non-optimal action
        BBT.cENG = BBT.cENG + BBT.forget * (BBT.minENG - BBT.cENG);
    end
    %% setting the reward as a function of the difference in engagement
    %r = BBT.cENG - oldEng; % reward = variations in child engagement
    %r = (BBT.cENG - 5) / 20; % reward = (child engagement - 5) / 5
    r = (1 - BBT.lambdaRwd) * (BBT.cENG - 5) / 5 + BBT.lambdaRwd * 2 * (BBT.cENG - oldEng); % mixed reward function
    
    %% HAVE THE ROBOT LEARN FROM THIS OUTCOME
    deltaACT = BBR.ACT;
    BBR = BBrobotLearns( BBR, s, a, y, r );
    deltaACT = (s * BBR.wA) - deltaACT;

    %% NEXT STATE
    if (r > 0), % If game completed, reset the game
        s = BBT.P0;
    else, % Otherwise, the next state becomes the current state
        s = y;
    end;
    
    %% HAVE THE ROBOT MAKE A DECISION
    [BBR, a, probaA, probaPISA] = BBrobotDecides( BBT, BBR, whichModel, s );
    
    % LOGS
    % logs nécessaires à l'optimisation
    logs.reward = r;
    logs.engagement = BBT.cENG;
    logs.probaA = probaA;
    logs.probaPISA = probaPISA;
    % logs nécessaires pour le main et l'affichage des figures
    logs.s = olds;
    logs.oldaction = olda.action;
    logs.oldparam = olda.param;
    logs.y = y;
    logs.action = a.action;
    logs.param = a.param;
    logs.delta = BBR.delta;
    logs.VC = BBR.VC;
    logs.ACT = BBR.ACT;
    logs.PA = BBR.PA;
    logs.deltaACT = deltaACT;
    logs.Q = BBR.Q;
    logs.RPEQ = BBR.RPEQ(olda.action);
    logs.varDelta = BBR.varDelta;
    logs.sigma = BBR.sigma;
    logs.dwA = BBR.varACT;
    logs.kalmanV = BBR.kalmanV;
    logs.kalmanCOV = diag(BBR.kalmanCOV)';
    logs.sigma2Q = BBR.sigma2Q(olda.action);
    logs.star = BBR.star;
    logs.ltar = BBR.ltar;
    logs.meta = BBR.metaparam;
%     %logs
    
end