function [LL, reward_engage_proba] = BBrunTask( vectParam, nbBlock, episodeLength, whichModel )
    % whichModel = 1 QL 2 kalman 3 sigma2Q 4 hybrid 5 schweig1 6 schweig2
    % vectParam contains the list of parameters of the studied model
    
    % BBT = task used for Baby Robot learning
    % BBR = structure containing the baby robot
    % s = state vector in which the robot was
    % a = structure containing [executed action, action parameter]
    
    % define Task
    BBT = BBsetTask();
    % define baby robot
    BBR = BBrobot(BBT);
    
    % set model parameters for the baby robot
    BBR = BBinitModelParam( BBR, vectParam, whichModel );
    
    % initial state
    s = BBT.P0;
    % initial action by the robot
    [BBR, a, probaA, probaPISA] = BBrobotDecides(BBT, BBR, whichModel, s);
    % init LOGS (engagement and reward)
    LOG_FILES = zeros(nbBlock * episodeLength,4);
    LOG_FILES(1,:) = [BBT.cENG 0 probaA probaPISA];

    %% RUN TASK
    for bbb=1:nbBlock
        for iii=1:episodeLength
            [ BBT, BBR, s, a, logs ] = BBrunTrial( BBT, BBR, whichModel, s, a );
            LOG_FILES( (bbb - 1) * episodeLength + iii + 1, : ) = [logs.engagement logs.reward logs.probaA logs.probaPISA];
        end
        if (BBT.optimal == 2)
            BBT.optimal = 6;
            BBT.engMu = -50;
        else
            BBT.optimal = 2;
            BBT.engMu = 50;
        end
    end
    
    % output
    LL1 = -1 * sum(log(LOG_FILES(:,3)));
    LL2 = -1 * sum(log(LOG_FILES(:,4)));
    reward_engage_proba = [mean(LOG_FILES(:,2)) mean(LOG_FILES(:,1)) (-1 * LL1) (-1 * LL2)];
    LL = LL1 + LL2; %-1 * reward_engage_proba(1);
    % comment the following lines to free memory during parameter optimization
    %clear LOG_FILES;
    %clear BBT;
    %clear BBR;
    
end