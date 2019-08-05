whichModel = 7;
nbPaquet = 9; % 27 for model 6 / 45 for model 7
whichCol = 13;
epsilon = 0.0001;
optionstd = 1; % 1 show best-3std, 0 show std
optionhoriz = 1; % 1 horizontal, 0 vertical
optionplotstd = 0; % 1 show std, 0 don't

ligneCourante = 4;

%% paquets par modeles
% model 1; 5 paquets (5 with 1 sample)
% model 2; 24 paquets
% model 3; 19 paquets (11 with 1 sample)
% model 4; 1 paquets
% model 5; 11 paquets: ter, bss, trr, qtt, cqq, sxx, stt, huu, nff, dxx, ozz (OLD, preEWRL, 3 paquets: 0, bis, nov)
% model 6; 27 paquets + 30 (hors boucle) ; OLD : 6 paquets. Start from iii=7
% model 7; 9 paquets + 5 (hors boucle)

%% parametres a chercher

%% MODEL 1; alphaQ odd.

%% MODEL 2; once the correct gamma is found, increase gainSigma > 850 ?, and
%% maybe decrease varObs < 0.005 and eta < 0.005 ? NIET. DONE
% ALREADY LAUNCHED: model 2; gamma 0.81 (vun); gamma 0.80 (vde); gamma 0.79 alphaQ 4:6 (vtr);
% gamma 0.79 alphaQ 7:9 (vqu);

%% MODEL 4 HYBRID ??? gainSigma around 20; tau2 around 10; tau1 < 10

%% MODEL 5; à tester : beta 0.5 ? alphaC > 0.6
% ALREADY LAUNCHED: model 5; mu 0.05 0.025 0.01 0.005 (bss..cqq); tau1 5 (sxx); tau2 5 (stt)
% tau1 2 (huu); tau2 2 (nff); tau1 1 (dxx); tau2 1 (ozz)

%% MODEL 6; rateSigma < 0.4; tau1 < 5 ; tau2 < 40
% ALREADY LAUNCHED: model 6; mu et rateSigma impair (6qua et 6qui);
% mu/rateSigma both odd (6six) tau1 5 (6sep)
% ???
% beta 50 (6qat); idem alphaA 0.25:0.4 (6qin)
% beta 60 (6sei); idem alphaA 0.25:0.4 (6dse)
% all betas with alphaA 0.45:0.6 (6dhu)
% tau1 5 with alphaA 0.05:0.2 (6dne)
% tau1 5 with alphaA 0.25:0.4 (6vin)
% tau1 5 with alphaA 0.45:0.6 (6vun)
% relancer tous les derniers param avec gamma 0.97 ! with alphaA 0.05:0.2 (6vde)
% relancer tous les derniers param avec gamma 0.97 ! with alphaA 0.25:0.4 (6vtr)
% relancer tous les derniers param avec gamma 0.97 ! with alphaA 0.45:0.6 (6vqa)
% relancer dhu avec beta = 0 all tau1s all betas with alphaA 0.45:0.6 (6vci)
% relancer dne avec beta = 0 tau1 5 with alphaA 0.05:0.2 (6vsi)
% relancer vin avec beta = 0 tau1 5 with alphaA 0.25:0.4 (6vse)
% relancer vun avec beta = 0 tau1 5 with alphaA 0.45:0.6 (6vhu)
% gamma 0.965 with alphaA 0.05:0.2 (6vne)
% gamma 0.965 with alphaA 0.25:0.4 (6trn)
% gamma 0.965 with alphaA 0.45:0.6 (6tru)
% gamma 0.96 with alphaA 0.45:0.6 (6trd)
% gamma 0.96 with alphaA 0.25:0.4 (6trt)
% gamma 0.96 with alphaA 0.05:0.2 (6trq)
% gamma 0.955 with alphaA 0.05:0.2 (6trc)
% gamma 0.955 with alphaA 0.25:0.4 (6trx)
% gamma 0.955 with alphaA 0.45:0.6 (6trs)
% gamma 0.955 0.965 0.975 0.985 mu 0.005 with alphaA 0.45:0.6 (6trh)
% gamma 0.955 0.965 0.975 0.985 mu 0.005 with alphaA 0.25:0.4 (6trf)
% gamma 0.955 0.965 0.975 0.985 mu 0.005 with alphaA 0.05:0.2 (6qur)
% gamma 0.96 0.97 0.98 0.99 mu 0.005 with alphaA 0.05:0.2 (6qun)
% gamma 0.96 0.97 0.98 0.99 mu 0.005 with alphaA 0.25:0.4 (6qde)
% gamma 0.96 0.97 0.98 0.99 mu 0.005 with alphaA 0.45:0.6 (6qtr)
% beta 0 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qqu)
% beta 10 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qci)
% beta 20 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qsi)
% beta 30 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qse)
% beta 40 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qhu)
% beta 50 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6qne)
% beta 60 all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6cqt)
% tester rateSigma < 0.4 (0.3 0.35)

% sigma 0.35 all betas all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6cq1)
% sigma 0.3 all betas all gammas all mus with alphaA 0.05:0.6 alphaC 0.25 0.2 (6cq2)
% sigma 0.35 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cq3)
% sigma 0.35 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cq4)
% sigma 0.35 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cq5)
% sigma 0.3 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cq6)
% sigma 0.3 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cq7)
% sigma 0.3 all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cq8)

% tester tau1 < 5 (1 2)

% tau1 2 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cq9)
% tau1 2 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cct)
% tau1 2 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cc1)
% tau1 2 all sigmas all betas all gammas all mus with alphaA 0.05:0.6 and alphaC 0.25 0.2 (6cc2)

% tau1 1 all sigmas all betas all gammas all mus with alphaA 0.05:0.6 and alphaC 0.25 0.2 (6cc3)
% tau1 1 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cc4)
% tau1 1 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cc5)
% tau1 1 all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cc6)

% tester tau2 < 40 (20 30)

% tau2 30 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cc7)
% tau2 30 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cc8)
% tau2 30 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cc9)
% tau2 30 all tau1s all sigmas all betas all gammas all mus with alphaA 0.05:0.6 and alphaC 0.25 0.2 (6csx)

% tau2 20 all tau1s all sigmas all betas all gammas all mus with alphaA 0.05:0.6 and alphaC 0.25 0.2 (6cs1)
% tau2 20 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.05:0.2 (6cs2)
% tau2 20 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.25:0.4 (6cs3)
% tau2 20 all tau1s all sigmas all betas all gammas all mus with alphaC 0.3:0.6 and alphaA 0.45:0.6 (6cs4)

%% MODEL 7;
% ALREADY LAUNCHED: model 7;
% beta 20:10:50 (ter)
% beta 10 (bis)
% beta 10:50 gainSigma 900:50:1000 (nov)
% beta 10:50 gainSigma 750:50:1000, eta 0.03 (qua)
% beta 10:50 gainSigma 750:50:1000, eta 0.025 (qui)
% NEW
% beta 10:50 gainSigma 750:50:1000, eta 0.035 (six)
% beta 10:50 gainSigma 750:50:1000, eta 0.04 (sep)
% beta 10:50 gainSigma 750:50:1000, eta 0.045 (hui)
% beta 10:50 gainSigma 750:50:1000, eta 0.05 (nff)
% beta 10:50 gainSigma 750:50:1000, eta 0.055 (dix)
% beta 10:50 gainSigma 750:50:1000, eta 0.005:0.055, varObs 0.4 (onz)
% beta 10:50 gainSigma 750:50:1000, eta 0.005:0.055, varObs 0.5 (dou)
% beta 10:50 gainSigma 750:50:1000, eta 0.005:0.055, varObs 0.6 (tre)
% beta 10:50 gainSigma 750:50:1000, eta 0.005:0.055, varObs 0.7 (qat)
% beta 10:50 gainSigma 750:50:1000, eta 0.06, varObs 0:0.7 (qin)
% beta 10:50 gainSigma 750:50:1000, eta 0.065, varObs 0:0.7 (sei)
% beta 10:50 gainSigma 750:50:1000, eta 0.07, varObs 0:0.7 (dse)
% beta 60 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (dhu)
% beta 70 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (dne)
% beta 80 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vin)
% beta 90 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vun)
% beta100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vde)
% gamma 0.84 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vtr)
% gamma 0.85 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vqu)
% gamma 0.86 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.7 (vci)
% gamma 0.80:0.86 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0.8 (vsi)
% gamma 0.80:0.86 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0.9 (vse)
% gamma 0.80:0.86 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0.95 (vhu)
% gamma 0.87 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (vne)
% gamma 0.88 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trn)
% gamma 0.89 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (tru)
% gamma 0.90 beta 10:100 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trd)
% gamma 0.80:0.90 beta 150 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trt)
% gamma 0.80:0.90 beta 200 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trq)
% gamma 0.80:0.90 beta 250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trc)
% gamma 0.91 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trs)
% gamma 0.92 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trp)
% gamma 0.93 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trh)
% gamma 0.94 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (trf)
% gamma 0.95 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qrt)
% gamma 0.96 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qru)
% gamma 0.97 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qrd)
% gamma 0.98 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qro)
% gamma 0.99 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qrq)
% gamma 1 beta 10:250 gainSigma 750:50:1000, eta 0.005:0.07, varObs 0:0.95 (qrc)
% OLD
% beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.15:0.65 (six)
% gamma 0.84:0.87 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.15:0.65 (sep)
% gamma 0.84:0.87 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.1:0.6 (hui)
% gamma 0.88:0.91 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.1:0.6 (nff)
% gamma 0.88:0.91 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.15:0.65 (dix)
% gamma 0.92:0.95 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.15:0.65 (onz)
% gamma 0.92:0.95 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.1:0.6 (dou)
% gamma 0.96:0.99 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.1:0.6 (tre)
% gamma 0.96:0.99 beta 10:50 gainSigma 750:50:1000, eta ALL, alphaC 0.15:0.65 (qat)


switch(whichModel)
    case 8 % old 7
        RES_DIR = 'resultsPostEWRL2016/kalman_model7_wrongEtaVarObs/';
        lesAlphaA = 0.1:0.1:0.6;
        lesAlphaC = 0.1:0.1:0.5;
    case 6
        RES_DIR = 'resultsOptiSummer2016/';
        lesAlphaA = 0.3:0.05:0.6;
        lesAlphaC = 0.05:0.05:0.2;
    case {1,3,4}
        RES_DIR = 'resultsOptiSummer2016/';
        lesAlphaA = 0.1:0.1:0.6;
        lesAlphaC = 0.1:0.1:0.5;
    otherwise
        RES_DIR = 'resultsPostEWRL2016/';
        lesAlphaA = 0.1:0.1:0.6;
        lesAlphaC = 0.1:0.1:0.5;
end

if ((whichModel == 1)||(whichModel == 3))
    load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) '_nbBlock-5_episodeLength-1000_gridSearch.mat'])
    tabResults2 = tabResults;
    iii = 2;
    while (iii <= nbPaquet)
        switch(iii)
            case 2
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'bis_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 3
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'ter_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 4
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'qua_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 5
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'qui_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 6
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'six_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 7
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'sep_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 8
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'oct_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 9
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'nov_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 10
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'dix_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 11
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'onz_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 12
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'dou_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 13
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'tre_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 14
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'qat_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 15
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'qin_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 16
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'sei_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 17
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'dse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 18
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'dhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
            case 19
                load([RES_DIR 'BBopti_mixedRwd_model-' num2str(whichModel) 'dne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
        end
        tabResults2 = [tabResults2 ; tabResults];
        iii = iii + 1;
    end
else % models 2, 4, 5, 6
    tabResults2 = [];
    for alphaA = lesAlphaA;
        for alphaC = lesAlphaC;
            if (whichModel == 6)
                iii = 7; %pour le modèle 6 !!!
            else
                iii = 1;
            end
            while (iii <= nbPaquet)
                switch(iii)
                    case 1
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) '_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'ter_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 2
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'bss_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'bis_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 3
                        switch(whichModel)
                            case {2,7}
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'nov_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trr_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaA) '_alphaC-' num2str(alphaC) '_model-' num2str(whichModel) 'nov_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 4
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qtt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qua_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 5
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cqq_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qui_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 6
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'sxx_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            %case 7
                            %    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'hui_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'six_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 7
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'stt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            % 7
                            %    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'nff_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'sep_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 8
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'huu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            case {6,7}
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'hui_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            %case 7
                            %    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dou_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'oct_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 9
                        switch(whichModel)
                            case {5,7}
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'nff_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            %case 7
                            %    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'tre_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'nov_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 10
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dxx_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dix_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 11
                        switch(whichModel)
                            case 5
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'ozz_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'onz_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 12
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qat_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dou_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 13
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'sei_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'tre_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 14
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qat_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 15
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vde_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qin_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 16
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vsi_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'sei_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 17
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 18
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trq_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 19
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trc_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 20
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qur_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vin_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 21
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qun_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vun_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 22
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq3_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vde_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 23
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq8_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vtr_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 24
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq9_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vqu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 25
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc4_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            case 7
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vci_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq9_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 26
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc9_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            case 7
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vsi_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq9_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 27
                        switch(whichModel)
                            case 6
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cs2_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            case 7
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                            otherwise
                                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq9_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                        end
                    case 28
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 29
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 30
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trn_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 31
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'tru_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 32
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trd_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 33
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 34
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trq_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 35
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trc_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 36
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trs_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 37
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trp_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 38
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trh_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 39
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trf_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 40
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qrt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 41
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qru_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 42
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qrd_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 43
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qro_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 44
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qrq_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    case 45
                        load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qrc_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                end
                tabResults2 = [tabResults2 ; tabResults];
                iii = iii + 1;
            end
            if (whichModel == 6)
                % alphaC 0.25:0.05:0.4
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dou_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'tre_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qin_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vin_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vtr_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trn_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trx_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trf_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qde_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq4_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq7_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cct_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc5_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc8_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cs3_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                % alphaC 0.45:0.05:0.6
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'dhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vun_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vqa_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vci_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'vhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'tru_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trd_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trs_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'trh_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'qtr_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq5_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cq6_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc1_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc6_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cc7_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA) '_model-' num2str(whichModel) 'cs4_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                tabResults2 = [tabResults2 ; tabResults];
                % alphaC 0.2 0.25 alphaA 0.05:0.6
                if (alphaA <= 0.35)
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qqu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qqu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qqu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qci_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qci_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qci_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qsi_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qsi_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qsi_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qse_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qhu_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'qne_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cqt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cqt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cqt_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cq1_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cq1_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cq2_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cq2_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cc2_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cc2_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cc3_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cc3_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'csx_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'csx_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.2) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cs1_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                    load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC+0.4) '_alphaC-' num2str(alphaA-0.1) '_model-' num2str(whichModel) 'cs1_nbBlock-5_episodeLength-1000_gridSearch.mat'])
                    tabResults2 = [tabResults2 ; tabResults];
                end
            end
%             if (whichModel == 7)
%                 load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA+0.05) '_model-' num2str(whichModel) 'six_nbBlock-5_episodeLength-1000_gridSearch.mat'])
%                 tabResults2 = [tabResults2 ; tabResults];
%                 load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA+0.05) '_model-' num2str(whichModel) 'sep_nbBlock-5_episodeLength-1000_gridSearch.mat'])
%                 tabResults2 = [tabResults2 ; tabResults];
%                 load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA+0.05) '_model-' num2str(whichModel) 'dix_nbBlock-5_episodeLength-1000_gridSearch.mat'])
%                 tabResults2 = [tabResults2 ; tabResults];
%                 load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA+0.05) '_model-' num2str(whichModel) 'onz_nbBlock-5_episodeLength-1000_gridSearch.mat'])
%                 tabResults2 = [tabResults2 ; tabResults];
%                 load([RES_DIR 'BBopti_mixedRwd_alphaA-' num2str(alphaC) '_alphaC-' num2str(alphaA+0.05) '_model-' num2str(whichModel) 'qat_nbBlock-5_episodeLength-1000_gridSearch.mat'])
%                 tabResults2 = [tabResults2 ; tabResults];
%             end
        end
    end
end
tabResults = tabResults2;
clear tabResults2;

%%%%%%%%%%%%%%%%%%%%%%%
%% BEST PERFORMANCE
%%%%%%%%%%%%%%%%%%%%%%%
theBestI = argmax(tabResults(:,whichCol));
theBest = tabResults(theBestI,:);
num2str(theBest)

%%%%%%%%%%%%%%%%%%%%%%%
%% FIGURE
%%%%%%%%%%%%%%%%%%%%%%%
switch (whichModel)
    case {1,3}
        nbLigne = 4; %3; % everyone the same for good alignment
    otherwise
        nbLigne = 4;
end

%close all
%figure

%% BETA x GAMMA
syms beta gamma mu
switch (whichModel)
    case {4}
        indexB = 9;
    case {5,6}
        indexB = 8;
    otherwise
        indexB = 1;
end
lesBetas = unique(tabResults(:,indexB))';
lesGammas = unique(tabResults(:,2))';
mabg = zeros(length(lesBetas),length(lesGammas));
mabgstd = zeros(length(lesBetas),length(lesGammas));
for b=1:length(lesBetas)
    for g=1:length(lesGammas)
        [boubou, indeks] = max(tabResults((tabResults(:,indexB)>=(lesBetas(b)-epsilon))&(tabResults(:,indexB)<=(lesBetas(b)+epsilon))&(tabResults(:,2)<=(lesGammas(g)+epsilon))&(tabResults(:,2)>=(lesGammas(g)-epsilon)),whichCol));
        mabg(b,g) = boubou;
        if (optionstd == 1)
            mabgstd(b,g) = boubou - 3 * tabResults(indeks,whichCol+1);
        else
            mabgstd(b,g) = tabResults(indeks,whichCol+1);
        end
    end
end

if (optionhoriz == 1)
    subplot(5,nbLigne,1+ligneCourante*4)
else
    subplot(nbLigne,2,1)
end
switch (whichModel)
    case {4}
        imagesc(lesBetas,lesGammas,mabg')
        xlabel(texlabel(mu))
    case {5,6}
        imagesc(lesBetas,lesGammas,mabg')
        xlabel(texlabel(mu))
    otherwise
        %imagesc(1:length(lesBetas),lesGammas,mabg')
        imagesc(lesBetas,lesGammas,mabg')
        xlabel(texlabel(beta))
end
ylabel(texlabel(gamma))
axis square
set(gca,'YDir','normal') % ,'XTick',[]
caxis([0 10])
colorbar
[min(min(mabg)) max(max(mabg))]
if (optionplotstd == 1)
    title('mean reward')
end
if (optionplotstd == 1)
    if (optionhoriz == 1)
        subplot(5,nbLigne,nbLigne+1+ligneCourante*4)
    else
        subplot(nbLigne,2,2)
    end
    switch (whichModel)
        case {4}
            imagesc(lesBetas,lesGammas,mabgstd')
            xlabel(texlabel(mu))
        case {5,6}
            imagesc(lesBetas,lesGammas,mabgstd')
            xlabel(texlabel(mu))
        otherwise
            imagesc(1:length(lesBetas),lesGammas,mabgstd')
            xlabel(texlabel(beta))
    end
    axis square
    set(gca,'YDir','normal') % ,'XTick',[]
    colorbar
    title('std reward')
end % end of if plot std

%% ALPHAC x ALPHAA
syms alpha2 alpha3
lesAC = unique(tabResults(:,3))';
lesAA = unique(tabResults(:,4))';
% if (whichModel == 6)
%     lesAC(end) = [];
%     lesAA(end) = [];
% end
mabg = zeros(length(lesAC),length(lesAA));
mabgstd = zeros(length(lesAC),length(lesAA));
for b=1:length(lesAC)
    for g=1:length(lesAA)
        [boubou, indeks] = max(tabResults((tabResults(:,3)>=(lesAC(b)-epsilon))&(tabResults(:,3)<=(lesAC(b)+epsilon))&(tabResults(:,4)<=(lesAA(g)+epsilon))&(tabResults(:,4)>=(lesAA(g)-epsilon)),whichCol));
        mabg(b,g) = boubou;
        if (optionstd == 1)
            mabgstd(b,g) = boubou - 3 * tabResults(indeks,whichCol+1);
        else
            mabgstd(b,g) = tabResults(indeks,whichCol+1);
        end
    end
end

if (optionplotstd == 1)
    if (optionhoriz == 1)
        subplot(5,nbLigne,2+ligneCourante*4)
    else
        subplot(nbLigne,2,3)
    end
else % don't plot std
    if (optionhoriz == 1)
        subplot(5,nbLigne,2+ligneCourante*4)
    else
        subplot(nbLigne,2,2)
    end
end
imagesc(lesAC,lesAA,mabg')
axis square
set(gca,'YDir','normal') % ,'XTick',[]
caxis([0 10])
colorbar
[min(min(mabg)) max(max(mabg))]
xlabel(texlabel(alpha2)) %xlabel('alphaC')
ylabel(texlabel(alpha3)) %ylabel('alphaA')
if (optionplotstd == 1)
    if (optionhoriz == 1)
        subplot(5,nbLigne,nbLigne+2+ligneCourante*4)
    else
        subplot(nbLigne,2,4)
    end
    imagesc(lesAC,lesAA,mabgstd')
    axis square
    set(gca,'YDir','normal') % ,'XTick',[]
    colorbar
    xlabel(texlabel(alpha2)) %xlabel('alphaC')
end

%% SIGMA x ALPHAQ
syms sigma phi tau1 tau2 alpha1 nu
switch (whichModel)
    case {5,6}
        indexSI = 6;
        indexAQ = 7;
    otherwise
        indexSI = 5;
        indexAQ = 6;
end
lesSI = unique(tabResults(:,indexSI))';
lesAQ = unique(tabResults(:,indexAQ))';
mabg = zeros(length(lesSI),length(lesAQ));
mabgstd = zeros(length(lesSI),length(lesAQ));
for b=1:length(lesSI)
    for g=1:length(lesAQ)
        [boubou, indeks] = max(tabResults((tabResults(:,indexSI)>=(lesSI(b)-epsilon))&(tabResults(:,indexSI)<=(lesSI(b)+epsilon))&(tabResults(:,indexAQ)>=(lesAQ(g)-epsilon))&(tabResults(:,indexAQ)<=(lesAQ(g)+epsilon)),whichCol));
        mabg(b,g) = boubou;
        if (optionstd == 1)
            mabgstd(b,g) = boubou - 3 * tabResults(indeks,whichCol+1);
        else
            mabgstd(b,g) = tabResults(indeks,whichCol+1);
        end
    end
end

if (optionplotstd == 1)
    if (optionhoriz == 1)
        subplot(5,nbLigne,3+ligneCourante*4)
    else
        subplot(nbLigne,2,5)
    end
else % don't plot std
    if (optionhoriz == 1)
        subplot(5,nbLigne,3+ligneCourante*4)
    else
        subplot(nbLigne,2,3)
    end
end
imagesc(lesSI,lesAQ,mabg')
axis square
set(gca,'YDir','normal') % ,'XTick',[]
caxis([0 10])
colorbar
[min(min(mabg)) max(max(mabg))]
switch (whichModel)
    case 1
        xlabel(texlabel(sigma)) %xlabel('sigma')
        ylabel(texlabel(alpha1)) %ylabel('alphaQ')
    case {2,3,4,7}
        xlabel(texlabel(nu)) %xlabel('gainSigma')
        ylabel(texlabel(phi)) %ylabel('explor bonus')
    case {5,6}
        xlabel(texlabel(tau1)) %xlabel('rateSigma')
        ylabel(texlabel(tau2)) %ylabel('mu')
end
if (optionplotstd == 1)
    if (optionhoriz == 1)
        subplot(5,nbLigne,nbLigne+3+ligneCourante*4)
    else
        subplot(nbLigne,2,6)
    end
    imagesc(lesSI,lesAQ,mabgstd')
    axis square
    set(gca,'YDir','normal') % ,'XTick',[]
    colorbar
    switch (whichModel)
        case 1
            xlabel(texlabel(sigma)) %xlabel('sigma')
        case {2,3,4,7}
            xlabel(texlabel(nu)) %xlabel('gainSigma')
        case {5,6}
            xlabel(texlabel(tau1)) %xlabel('rateSigma')
    end
end

%% TAU1 x TAU2
syms tau1 tau2 eta kappa
if ((whichModel == 2)||(whichModel == 4)||(whichModel == 7))
    switch (whichModel)
        case {5,6}
            indexT1 = 6;
            indexT2 = 7;
        case 4
            indexT1 = 7;
            indexT2 = 8;
        otherwise
            indexT1 = 9;
            indexT2 = 7;
    end
    lesT1 = unique(tabResults(:,indexT1))';
    lesT2 = unique(tabResults(:,indexT2))';
    mabg = zeros(length(lesT1),length(lesT2));
    mabgstd = zeros(length(lesT1),length(lesT2));
    for b=1:length(lesT1)
        for g=1:length(lesT2)
            [boubou, indeks] = max(tabResults((tabResults(:,indexT1)>=(lesT1(b)-epsilon))&(tabResults(:,indexT1)<=(lesT1(b)+epsilon))&(tabResults(:,indexT2)>=(lesT2(g)-epsilon))&(tabResults(:,indexT2)<=(lesT2(g)+epsilon)),whichCol));
            mabg(b,g) = boubou;
            if (optionstd == 1)
                mabgstd(b,g) = boubou - 3 * tabResults(indeks,whichCol+1);
            else
                mabgstd(b,g) = tabResults(indeks,whichCol+1);
            end
        end
    end
    
    if (optionplotstd == 1)
        if (optionhoriz == 1)
            subplot(5,nbLigne,4+ligneCourante*4)
        else
            subplot(nbLigne,2,7)
        end
    else % don't plot std
        if (optionhoriz == 1)
            subplot(5,nbLigne,4+ligneCourante*4)
        else
            subplot(nbLigne,2,4)
        end
    end
    imagesc(lesT1,lesT2,mabg')
    axis square
    set(gca,'YDir','normal') % ,'XTick',[]
    caxis([0 10])
    colorbar
    [min(min(mabg)) max(max(mabg))]
    switch (whichModel)
        case {2,7}
            xlabel(texlabel(kappa)) %xlabel('varObs')
            ylabel(texlabel(eta)) %ylabel('eta')
        case {4,5,6}
            xlabel(texlabel(tau1)) %xlabel('tau1')
            ylabel(texlabel(tau2)) %ylabel('tau2')
    end
    if (optionplotstd == 1)
        if (optionhoriz == 1)
            subplot(5,nbLigne,nbLigne+4+ligneCourante*4)
        else
            subplot(nbLigne,2,8)
        end
        imagesc(lesT1,lesT2,mabgstd')
        axis square
        set(gca,'YDir','normal') % ,'XTick',[]
        colorbar
        switch (whichModel)
            case {2,7}
                xlabel(texlabel(kappa)) %xlabel('varObs')
            case {4,5,6}
                xlabel(texlabel(tau1)) %xlabel('tau1')
        end
    end % end of if plot std
end

colormap gray
FigHandle = gcf;
set(FigHandle, 'Position', [100, 300, 700, 250]);
%print('-bestfit','BestFitFigure','-dpdf')



% %%%%%%%%%%%
% %% FIGURE 2 : child engagement
% 
% figure
% verti = 1000;
% while (verti <= 4999)
%     plot([verti verti], [0 10], '--k', 'LineWidth', 2)
%     hold on
%     verti = verti + episodeLength;
% end
% 
% 
% switch (whichModel)
%     case 1
%         listeData = [44 55:63];
%     case 2
%         listeData = 106:115; %95:104; %70:79;
%     case 5
%         listeData = 45:54;
%     otherwise
%         listeData = [];
% end
% 
% engagement = zeros(5001,size(listeData,2));
% compteur = 1;
% for iii = listeData
%     iii
%     load(['postOptimResultsForEWRL_sept2016/experiment' num2str(iii) '_model' num2str(whichModel) '.mat'])
%     engagement(:,compteur) = LOG_FILES(:,16);
%     compteur = compteur + 1;
% end
% 
% mean(mean(engagement))
% 
% %errorfill(1:5001,smooth(mean(engagement'),'sgolay')',smooth(std(engagement')./sqrt(10),'sgolay')','b')
% errorfill(1:5001,mean(engagement'),std(engagement')./sqrt(size(engagement,2)),'1')
% 
% axis([0 5001 0 10.2])
% xlabel('timesteps') %('blue: model 1; green: model 2; red: model 5')
% ylabel('simulated engagement (a.u.)')
% alpha 0.5
