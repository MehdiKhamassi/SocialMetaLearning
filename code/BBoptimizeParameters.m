function BBoptimizeParameters(nom, nbBlock, episodeLength, whichModel, nbSample, methode, pas, alphaC, alphaA)
    
    % matlab -nodesktop
    % addpath(genpath('~/Src/matlab-code'),'-end')
    
    time0 = cputime
    
    if (methode > 0)
        
        %% sampling parameter values with pseudo-random generator
        tabResults = zeros(nbSample,10+8);
        vectParam = zeros(1,10);
        
        rand('twister',methode)
        R = rand(nbSample,10); % gen random num

        for iii=1:nbSample
            vectParam(1) = R(iii,1) * 150; % beta
            vectParam(2) = R(iii,2); % gamma
            vectParam(3) = R(iii,3); % alphaC
            vectParam(4) = R(iii,4); % alphaA
            switch(whichModel)
                case 1 %% Q-learning
                    vectParam(5) = R(iii,5) * 25; % sigma
                    vectParam(6) = R(iii,6); % alphaQ
                case {2,7} %% Kalman
                    vectParam(5) = R(iii,5) * 1000; % gainSigma
                    vectParam(6) = R(iii,6) * 20; % explorationBonus
                    vectParam(7) = R(iii,7); % eta
                    vectParam(8) = R(iii,8); % kappa
                    vectParam(9) = R(iii,9); % varObs
                case 3 %% Sigma2Q
                    vectParam(5) = R(iii,5) * 1000; % gainSigma
                    vectParam(6) = R(iii,6) * 20; % explorationBonus
                case 4 %% Hybrid
                    vectParam(5) = R(iii,5) * 1000; % gainSigma
                    vectParam(9) = R(iii,6) * 20; % explorationBonus
                    vectParam(6) = R(iii,7) * 1000; % tau1
                    vectParam(7) = R(iii,8) * 1000; % tau2
                    vectParam(8) = R(iii,9); % mu
                case 5 %% Schweighofer 1
                    vectParam(5) = R(iii,5); % rateSigma
                    vectParam(6) = R(iii,6) * 1000; % tau1
                    vectParam(7) = R(iii,7) * 1000; % tau2
                    vectParam(8) = R(iii,8); % mu
                case 6 %% Schweighofer 2
                    vectParam(5) = R(iii,5); % rateSigma
                    vectParam(6) = R(iii,6) * 1000; % tau1
                    vectParam(7) = R(iii,7) * 1000; % tau2
                    vectParam(8) = R(iii,8); % mu
            end

            performance = BBoptimize(nbBlock, episodeLength, whichModel, 1, vectParam);
            tabResults(iii,:) = [vectParam performance];

            iii = iii + 1;
            prog = (iii-1) * 100 / nbSample;
            if ((iii == 100000)|(iii == 200000)|(iii == 300000)|(iii == 400000)|(iii == 500000)|(iii == 600000)|(iii == 700000)|(iii == 800000)|(iii == 900000))
                progression = [num2str(prog) ' %']
            end
        end
        
        save([nom '_model-' num2str(whichModel) '_nbBlock-' num2str(nbBlock) '_episodeLength-' num2str(episodeLength) '_sample-' num2str(methode) '.mat'], 'tabResults');
        clear tabResults;
        clear vectParam;
        clear R;
        clear prog;
        clear progression;
        clear iii;

    else % if (methode <= 0)
        
        %% grid search on parameter space
        %pas = 0.1;
        
        % common parameters
        beta = [10:10:100 150 200 250]; %0:10:60; %[0 1 2 5 10 exp([2.9:(10*0.1):5.3])]; %
        gamma = 1; %0.955:0.005:0.99; %0.93:(pas/20):0.99; % 0.79; %0.9:(pas/10):1; %0.81; %0.82:0.01:0.95; %0.9:0.01:0.95; %
        %alphaC = 0.05; %0.1:(pas/2):0.6; % commenter pour parallelisme cluster
        %alphaA = 0.1:(pas/2):0.5; % commenter pour parallelisme cluster
        
        switch(whichModel)
            case 1 %% Q-learning
                sigma = [5 10 15 20 25]; %16:19; %5:5:25; % sigma
                alphaQ = 0.1:pas:1; % alphaQ
                tau1 = 0;
                tau2 = 0;
                mu = 0;
            case 2 %% Kalman
                sigma = 550:50:900; %[20 200 500 1000]; % gainSigma
                alphaQ = 7:9; % 4:9; %[0 5 10 15 20]; % explorationBonus
                tau1 = 0.005:(2.5*pas/100):0.025; % eta
                tau2 = 0.01; % kappa
                mu = [0.005 0.01:(2.5*pas/50):0.09]; % varObs
            case 3 %% Sigma2Q
                sigma = 35000:5000:50000; %[20 200 500 1000 1500 2000 5000 10000]; % gainSigma
                alphaQ = [0 5 10 15 20 25]; % explorationBonus
                tau1 = 0;
                tau2 = 0;
                mu = 0;
            case 4 %% Hybrid
                sigma = [20 200 500 1000]; % gainSigma
                alphaQ = [0 5 10 15 20]; % explorationBonus
                tau1 = 10:(200*pas):100; % tau1
                tau2 = 10:(200*pas):100; % tau2
                mu = 0:(pas/2):1; % mu
            case 5 %% Schweighofer 1
                sigma = 0.6:(pas/2):1; % rateSigma
                tau1 = [1 2 5 10:(200*pas):100]; % tau1
                tau2 = [1 2 5 10:(200*pas):100]; % tau2
                alphaQ = 0;
                mu = [0.005 0.01 0.025 0.05 0.1:(pas/2):0.5]; % mu
            case 6 %% Schweighofer 2
                sigma = 0.3:0.05:0.6; %0.1:pas:1; % rateSigma
                tau1 = [1 2 5 10:10:50]; %10:10:30; %10:(200*pas):100; % tau1
                tau2 = 20; %40:10:90; %[10:(200*pas):100 170]; % tau2
                alphaQ = 0;
                mu = [0.005 0.01 0.025 0.05:0.05:0.2]; % mu % [0.01 0.025]; %
            case 7 %% Kalman original
                sigma = 750:50:1000; %[20 200 500 1000]; % gainSigma
                alphaQ = 0; % explorationBonus
                tau1 = [0.005:(2.5*pas/100):0.07 0.08 0.09 0.95]; % eta
                tau2 = 0.01; % kappa
                mu = [0.005 0.01:0.01:0.07]; % varObs
        end
        
        nbParamSet = length(beta)*length(alphaC)*length(alphaA)*length(gamma)*length(sigma)*length(alphaQ)*length(tau1)*length(tau2)*length(mu)
        tabResults = zeros(nbParamSet,10+8);

        iii = 1;
        for b=1:length(beta),
            for g=1:length(gamma),
                for aC=1:length(alphaC),
                    for aA=1:length(alphaA),
                        for s=1:length(sigma),
                            for aQ=1:length(alphaQ),
                                for t1=1:length(tau1),
                                    for t2=1:length(tau2),
                                        for m=1:length(mu),
                                            
                                            % common parameters
                                            vectParam(1) = beta(b);
                                            vectParam(2) = gamma(g);
                                            vectParam(3) = alphaC(aC);
                                            vectParam(4) = alphaA(aA);
                                            vectParam(5) = sigma(s);
                                            vectParam(6) = alphaQ(aQ);
                                            
                                            if ((whichModel == 1)||(whichModel == 3))
                                                vectParam(7:10) = 0;
                                            else if ((whichModel == 5)||(whichModel == 6)) %(whichModel >= 5) % schweighofer
                                                vectParam(6) = tau1(t1);
                                                vectParam(7) = tau2(t2);
                                                vectParam(8) = mu(m);
                                                vectParam(9:10) = 0;
                                            else % models kalman or hybrid
                                                vectParam(7) = tau1(t1);
                                                vectParam(8) = tau2(t2);
                                                vectParam(9) = mu(m);
                                                vectParam(10) = 0;
                                            end; end
                                            
                                            performance = BBoptimize(nbBlock, episodeLength, whichModel, nbSample, vectParam);
                                            tabResults(iii,:) = [vectParam performance];

                                            iii = iii + 1;
                                            prog = (iii-1) * 100 / nbParamSet;
                                            % pas = 0.01 %if ((iii == 700000)|(iii == 1400000)|(iii == 2100000)|(iii == 2800000)|(iii == 3500000)|(iii == 4200000)|(iii == 4900000)|(iii == 5600000)|(iii == 6300000))
                                            %if ((iii == 90000)|(iii == 180000)|(iii == 270000)|(iii == 360000)|(iii == 450000)|(iii == 540000)|(iii == 630000)|(iii == 720000)|(iii == 810000))
                                            if (rem(nbParamSet,iii) == 0)
                                                progression = [num2str(prog) ' %']
                                            end
                                            
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        save([nom '_model-' num2str(whichModel) 'qrc_nbBlock-' num2str(nbBlock) '_episodeLength-' num2str(episodeLength) '_gridSearch.mat'], 'tabResults');
        clear tabResults;
        clear vectParam;
        clear R;
        clear prog;
        clear progression;
        clear iii;
    
    end; % if (methode >= 0)
    
    time1 = cputime
    delta_t = (time1 - time0)
    
end