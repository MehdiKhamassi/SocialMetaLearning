%function BBparallelOpti(nom, nbBlock, episodeLength, whichModel, nbSample, pas)

    nom = 'BBopti_mixedRwd';
    nbBlock = 5;
    episodeLength = 1000;
    whichModel = 7;
    nbSample = 10;
    pas = 0.2;
    methode = -1;
    
    %% grid search
    
    alphaC = 0.1:0.1:0.6;
    alphaA = 0.1:0.1:0.5;
    nWorkers = 30; 
    
%     alphaC = 0.3:0.05:0.6;
%     %alphaA = 0.05:0.05:0.2;
%     %alphaA = 0.25:0.05:0.4;
%     alphaA = 0.45:0.05:0.6;
%     nWorkers = 28;

%     alphaC = 0.2:0.05:0.25;
%     alphaA = 0.05:0.05:0.6;
%     nWorkers = 24;
    
    myCluster=parcluster('local'); 
    myCluster.NumWorkers= nWorkers; 
    poolobj = parpool(myCluster,nWorkers); 

    parfor indice = 1:nWorkers
        aa = 1; ac = 1;
        for zoubi = 1:indice
            if (mod(zoubi,length(alphaC)) == 0)
                aa = aa + 1;
                ac = 1;
            else
                ac = ac + 1;
            end
            if (zoubi == nWorkers)
                aa = 1;
            end
        end
        [indice aa ac]
        BBoptimizeParameters([nom '_alphaA-' num2str(alphaA(aa)) '_alphaC-' num2str(alphaC(ac))], nbBlock, episodeLength, whichModel, nbSample, methode, pas, alphaC(ac), alphaA(aa))
    end
    
    delete(poolobj)
    
%     %% gradient descent
%     
%     beta = [1 5 50];
%     gamma = [0.7 0.9 0.99];
%     alphaC = [0.1 0.5 0.9];
%     alphaA = [0.1 0.5 0.9];
%     sigma = [5 15 30]; % QL
%     alphaQ = [0.1 0.5 0.9]; % QL
%     exploreBonus = [5 15 30]; % KALMAN / SIGMA2Q / HYBRID
%     gainSigma = [20 500 1000]; % KALMAN / SIGMA2Q / HYBRID
%     rateSigma = [0.1 0.5 0.9]; % SCHWEIGHOFER
%     tau1 = [10 100 1000]; % /10000 eta for KALMAN
%     tau2 = [10 100 1000]; % = 0.01 kappa for KALMAN
%     mu = [0.1 0.5 0.9]; % /10 varObs for KALMAN
%     
% 
%     nWorkers = 3^6; 
%     myCluster=parcluster('local'); 
%     myCluster.NumWorkers= nWorkers; 
%     poolobj = parpool(myCluster,nWorkers); 
% 
%         parfor aa = 1:length(alphaA)
%             parfor ac = 1:length(alphaC)
%                 %BBoptimizeParameters([nom '_alphaA-' num2str(alphaA(aa)) '_alphaC-' num2str(alphaC(ac))], nbBlock, episodeLength, whichModel, nbSample, methode, pas, alphaA(aa), alphaC(ac))
%                 
%                 %[x, fval] = fminsearch(@(x) BBrunTask(x, nbBlock, episodeLength, whichModel), [4 0.99 0.5 0.2 18.8 0.4])
%                 % , 'MaxFunEvals', 1000*6)
%                 % default MaxFunEvals 200*nbVariables
%                 % , 'MaxIter', 1000*6)
%                 % default MaxIter 200*nbVariables
%             end
%         end
% 
%     delete(poolobj)
    
%end