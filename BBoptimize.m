function performance = BBoptimize(nbBlock, episodeLength, whichModel, nbSample, vectParam)
    
    % vectParam contains the list of parameters of the studied model
    
    reward_engage_proba = zeros(nbSample,4);
    
    for iii=1:nbSample
        [~, reward_engage_proba(iii,:)] = BBrunTask( vectParam, nbBlock, episodeLength, whichModel );
    end
    
    performance = [mean(reward_engage_proba(:,1)) std(reward_engage_proba(:,1)) mean(reward_engage_proba(:,2)) std(reward_engage_proba(:,2))  mean(reward_engage_proba(:,3)) std(reward_engage_proba(:,3))  mean(reward_engage_proba(:,4)) std(reward_engage_proba(:,4))];
    
    clear reward_engage_proba;
end