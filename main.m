%% main

%clear all
close all
%clc

whichModel = 5;
runOptimizedModels = 1;
episodeLength = 1000;
vertiBars = true;

% define Task
BBT = BBsetTask();

% define baby robot
BBR = BBrobot(BBT);

% initialize model optimized parameters
if (runOptimizedModels)
    load('figuresOptiSummer2016/bestModelsOptiSummer2016.mat')
    BBR = BBinitModelParam( BBR, bestModels(whichModel,1:10), whichModel );
end

% initial state
s = BBT.P0;

% initial action by the robot
[BBR, a] = BBrobotDecides(BBT, BBR, whichModel, s);

% init LOGS
LOG_FILES = [s a.action a.param 0 s a.action a.param BBT.cENG BBR.delta BBR.VC BBR.ACT BBR.PA zeros(1, BBR.nA) zeros(1, BBR.nA) 0 BBR.varDelta BBR.sigma BBR.varACT BBR.kalmanV diag(BBR.kalmanCOV)' BBR.sigma2Q(1) 0 0 0];

%% RUN TASK
for iii=1:episodeLength
    [ BBT, BBR, s, a, logs ] = BBrunTrial( BBT, BBR, whichModel, s, a );
    LOG_FILES = [LOG_FILES ; [logs.s logs.oldaction logs.oldparam logs.reward logs.y logs.action logs.param logs.engagement logs.delta logs.VC logs.ACT logs.PA logs.deltaACT logs.Q logs.RPEQ logs.varDelta logs.sigma logs.dwA logs.kalmanV logs.kalmanCOV logs.sigma2Q logs.star logs.ltar logs.meta]];
end

% LOG_FILES
% 1-5 s / 6 old action / 7 old param / 8 r / 9-13 y / 14 action / 15 param
% 16 eng / 17 delta / 18 V / 19-24 ACT / 25-30 PA / 31-36 deltaACT
% 37-42 Q / 43 RPEQ / 44 varCriticDelta / 45 sigma / 46-51 varwA
% 52-57 kalmanV / 58-63 kalmanCOV / 64 sigma2Q / 65-66 star-ltar / 67 meta

%% README
switch (whichModel)
    case 1
        % simple Q-learning, fixed sigma:
        README_PARAMETERS = ['TASK: minENG ' num2str(BBT.minENG) ', maxENG ' num2str(BBT.maxENG) ', forget ' num2str(BBT.forget) ', reeng ' num2str(BBT.reeng) '. Gaussian Child Engagement, engMu ' num2str(BBT.engMu) ', engSig ' num2str(BBT.engSig) '. Rwd = (1 - lambdaRwd) * absolute child engagement + lambdaRwd * variation in child engagement. lambdaRwd = ' num2str(BBT.lambdaRwd) '. Optimal action 2 then 6 then 2 then 6 etc.. Caluwaerts learning rule (all deltas, delta*alphaA), action selection based on Q-values. No exploration bonus. Robot alphaC ' num2str(BBR.alphaC) ' alphaA ' num2str(BBR.alphaA) ' alphaQ ' num2str(BBR.alphaQ) ' beta ' num2str(BBR.beta) ' gamma ' num2str(BBR.gamma) ' softmax. Kalman QL with eta ' num2str(BBR.eta) ' kappa ' num2str(BBR.kappa) ' varObs ' num2str(BBR.varObs) ' initCov ' num2str(BBR.initCov) '. Schweighofer metalearning: tau1 ' num2str(BBR.tau1) ' tau2 ' num2str(BBR.tau2) ' mu ' num2str(BBR.mu) '. No active exploration. Fixed sigma ' num2str(BBR.sigma) '.'];
    case {2,7}
        % Kalman-Q active exploration:
        README_PARAMETERS = ['TASK: minENG ' num2str(BBT.minENG) ', maxENG ' num2str(BBT.maxENG) ', forget ' num2str(BBT.forget) ', reeng ' num2str(BBT.reeng) '. Gaussian Child Engagement, engMu ' num2str(BBT.engMu) ', engSig ' num2str(BBT.engSig) '. Rwd = (1 - lambdaRwd) * absolute child engagement + lambdaRwd * variation in child engagement. lambdaRwd = ' num2str(BBT.lambdaRwd) '. Optimal action 2 then 6 then 2 then 6 etc.. Caluwaerts learning rule (all deltas, delta*alphaA), action selection based on KalmanV+diag(BBR.kalmanCOV)*explorationBonus ' num2str(BBR.explorationBonus) '. Robot alphaC ' num2str(BBR.alphaC) ' alphaA ' num2str(BBR.alphaA) ' alphaQ ' num2str(BBR.alphaQ) ' beta ' num2str(BBR.beta) ' gamma ' num2str(BBR.gamma) ' softmax. Kalman QL with eta ' num2str(BBR.eta) ' kappa ' num2str(BBR.kappa) ' varObs ' num2str(BBR.varObs) ' initCov ' num2str(BBR.initCov) '. Schweighofer metalearning: tau1 ' num2str(BBR.tau1) ' tau2 ' num2str(BBR.tau2) ' mu ' num2str(BBR.mu) '. Active exploration for dynamic sigma based on kalmanCOV*' num2str(BBR.gainSigma) '.'];
    case 3
        % sigma2Q-based active exploration:
        README_PARAMETERS = ['TASK: minENG ' num2str(BBT.minENG) ', maxENG ' num2str(BBT.maxENG) ', forget ' num2str(BBT.forget) ', reeng ' num2str(BBT.reeng) '. Gaussian Child Engagement, engMu ' num2str(BBT.engMu) ', engSig ' num2str(BBT.engSig) '. Rwd = (1 - lambdaRwd) * absolute child engagement + lambdaRwd * variation in child engagement. lambdaRwd = ' num2str(BBT.lambdaRwd) '. Optimal action 2 then 6 then 2 then 6 etc.. Caluwaerts learning rule (all deltas, delta*alphaA), action selection based on Q-values+sigma2Q*explorationBonus ' num2str(BBR.explorationBonus) '. Robot alphaC ' num2str(BBR.alphaC) ' alphaA ' num2str(BBR.alphaA) ' alphaQ ' num2str(BBR.alphaQ) ' beta ' num2str(BBR.beta) ' gamma ' num2str(BBR.gamma) ' softmax. Kalman QL with eta ' num2str(BBR.eta) ' kappa ' num2str(BBR.kappa) ' varObs ' num2str(BBR.varObs) ' initCov ' num2str(BBR.initCov) '. Schweighofer metalearning: tau1 ' num2str(BBR.tau1) ' tau2 ' num2str(BBR.tau2) ' mu ' num2str(BBR.mu) '. Active exploration for dynamic sigma based on sigma2Q*' num2str(BBR.gainSigma) '.'];
    case 4
        % Hybrid active exploration:
        README_PARAMETERS = ['TASK: minENG ' num2str(BBT.minENG) ', maxENG ' num2str(BBT.maxENG) ', forget ' num2str(BBT.forget) ', reeng ' num2str(BBT.reeng) '. Gaussian Child Engagement, engMu ' num2str(BBT.engMu) ', engSig ' num2str(BBT.engSig) '. Rwd = (1 - lambdaRwd) * absolute child engagement + lambdaRwd * variation in child engagement. lambdaRwd = ' num2str(BBT.lambdaRwd) '. Optimal action 2 then 6 then 2 then 6 etc.. Caluwaerts learning rule (all deltas, delta*alphaA), action selection based on Q-values+sigma2Q*explorationBonus ' num2str(BBR.explorationBonus) '. Robot alphaC ' num2str(BBR.alphaC) ' alphaA ' num2str(BBR.alphaA) ' alphaQ ' num2str(BBR.alphaQ) ' beta ' num2str(BBR.beta) ' gamma ' num2str(BBR.gamma) ' softmax. Kalman QL with eta ' num2str(BBR.eta) ' kappa ' num2str(BBR.kappa) ' varObs ' num2str(BBR.varObs) ' initCov ' num2str(BBR.initCov) '. Schweighofer metalearning: tau1 ' num2str(BBR.tau1) ' tau2 ' num2str(BBR.tau2) ' mu ' num2str(BBR.mu) '. Hybrid active exploration for dynamic sigma based on sum of sigmoids on sigma2Q and metaparam parametrized by gainSigma ' num2str(BBR.gainSigma) '.'];
    case {5,6}
        % schweighofer metalearning-based active explortion:
        README_PARAMETERS = ['TASK: minENG ' num2str(BBT.minENG) ', maxENG ' num2str(BBT.maxENG) ', forget ' num2str(BBT.forget) ', reeng ' num2str(BBT.reeng) '. Gaussian Child Engagement, engMu ' num2str(BBT.engMu) ', engSig ' num2str(BBT.engSig) '. Rwd = (1 - lambdaRwd) * absolute child engagement + lambdaRwd * variation in child engagement. lambdaRwd = ' num2str(BBT.lambdaRwd) '. Optimal action 2 then 6 then 2 then 6 etc.. Caluwaerts learning rule (all deltas, delta*alphaA), action selection based on Q-values. Robot alphaC ' num2str(BBR.alphaC) ' alphaA ' num2str(BBR.alphaA) ' alphaQ ' num2str(BBR.alphaQ) ' beta ' num2str(BBR.beta) ' gamma ' num2str(BBR.gamma) ' softmax. Kalman QL with eta ' num2str(BBR.eta) ' kappa ' num2str(BBR.kappa) ' varObs ' num2str(BBR.varObs) ' initCov ' num2str(BBR.initCov) '. Schweighofer metalearning: tau1 ' num2str(BBR.tau1) ' tau2 ' num2str(BBR.tau2) ' mu ' num2str(BBR.mu) '. Active exploration for dynamic sigma based on (10 * (1 / (1 + exp(BBR.metaparam)) - 0.5)) + 0.25) *' num2str(BBR.gainSigma) '.'];
end

%% DEBUGGING
% debuug = (LOG_FILES(:,6)==2)&(LOG_FILES(:,7)>=10)&(LOG_FILES(:,7)<=15);
% size(LOG_FILES(debuug,:))
% pointeur = 0;
% pointeur = argmax(debuug(pointeur+1:end)) + pointeur
% LOG_FILES(pointeur-1:pointeur+1,[6:8 17 32 19:24])

%%%%%%%%%%%%%%
%% PLOT FIGURE
close all

figure

% plotting engagement
subplot(6, 1, 1)
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
        plot([verti verti], [0 10], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
plot(LOG_FILES(:, 16), 'k', 'LineWidth', 3)
ylabel('engagement')
axis([0 size(LOG_FILES,1) 0 10])

% plotting reward / Kalman COV / beta
subplot(6, 1, 2)
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
    plot([verti verti], [-0.5 1.2], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
    hold on
    verti = verti + episodeLength;
    end
end
switch (whichModel)
    case 2
        plot(LOG_FILES(:,58:63), 'LineWidth', 3)
        legend('A1', 'A2', 'A3', 'A4', 'A5', 'A6')
        hold on
    case 3
        plot(LOG_FILES(:, 8), '^k', 'MarkerSize', 3)
        hold on
        plot(LOG_FILES(:, 43), 'r', 'LineWidth', 3)
        plot(LOG_FILES(:, 64), 'b', 'LineWidth', 3)
    case {4,6}
        plot(LOG_FILES(:, 8), '^k', 'MarkerSize', 3)
        hold on
        LOG_FILES(:, 67) = LOG_FILES(:,67) + 2;
        plot(LOG_FILES(:, 65:67), 'Linewidth', 3)
    case 5
        LOG_FILES(:, 67) = LOG_FILES(:,67) + 2;
        plot(LOG_FILES(:, 65:67), 'Linewidth', 3)
    otherwise
        plot(LOG_FILES(:, 8), '^k', 'MarkerSize', 3)
end
%boubou = (1 ./ (1 + exp(LOG_FILES(:,65:67))) - 0.5);
%%plot([200 * boubou(:,1) 200 * boubou(:,2) 10 * boubou(:,3)],'Linewidth',3)
%plot([(10 * LOG_FILES(:,65) - 1) (10 * LOG_FILES(:,66) - 1) (5 * boubou(:,3) + 2)],'Linewidth',3)

switch (whichModel)
    case 2
        ylabel('Kalman COV')
        axis([0 size(LOG_FILES,1) 0 1])
    case {5,6}
        ylabel('beta')
        axis([0 size(LOG_FILES,1) -1 5])
        
    otherwise
        ylabel('reward')
        %ylabel('rwd & metaparam')
        %legend('r','short','long','diff')
        %legend('reward','metaparam')
        axis([0 size(LOG_FILES,1) -0.5 1.2])
end

% plotting learned action parameter
subplot(6, 1, 3)
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
        plot([verti verti], [BBT.intervalle(1) BBT.intervalle(end)], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
hold on
optiparam = LOG_FILES(:, 7);
optiparam(LOG_FILES(:,6) ~= 2) = NaN;
plot(optiparam, '.', 'Color', [216/255 82/255 24/255])
hold on
plot(LOG_FILES(:,20), 'k', 'LineWidth', 3)
ylabel('action 2 param')
axis([0 size(LOG_FILES,1) -100 100]) %BBT.intervalle(1) BBT.intervalle(end)]) %min(LOG_FILES(:,18)) max(LOG_FILES(:,18))])

% plotting learned action parameter
subplot(6, 1, 4)
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
        plot([verti verti], [BBT.intervalle(1) BBT.intervalle(end)], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
optiparam = LOG_FILES(:, 7);
optiparam(LOG_FILES(:,6) ~= 6) = NaN;
plot(optiparam, '.', 'Color', [76/255 189/255 237/255])
hold on
plot(LOG_FILES(:,24), 'k', 'LineWidth', 3)
ylabel('action 6 param')
axis([0 size(LOG_FILES,1) -100 100]) %BBT.intervalle(1) BBT.intervalle(end)]) %min(LOG_FILES(:,18)) max(LOG_FILES(:,18))])

% plotting action Q-values / Kalman Q-values
subplot(6, 1, 5)
switch (whichModel)
    case 2
        plot(LOG_FILES(:,52:57), 'LineWidth', 3)
    otherwise
        plot(LOG_FILES(:,37:42), 'LineWidth', 3)
end
%legend('Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6')
hold on
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
        plot([verti verti], [-6 6], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        verti = verti + episodeLength;
    end
end
switch (whichModel)
    case 2
        ylabel('Kalman Qs')
        axis([0 size(LOG_FILES,1) -7 5])
    case 5
        ylabel('Q-values')
        axis([0 size(LOG_FILES,1) -6 7])
    otherwise
        ylabel('Q-values')
        axis([0 size(LOG_FILES,1) -6 6])
end

% plotting action probabilities
subplot(6, 1, 6)
plot(LOG_FILES(:,25:30), 'LineWidth', 3)
hold on
%legend('P1', 'P2', 'P3', 'P4', 'P5', 'P6')
if (vertiBars)
    verti = episodeLength;
    while (verti <= 499) %size(LOG_FILES,1))
        plot([verti verti], [0 1], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        verti = verti + episodeLength;
    end
end
xlabel('timesteps')
ylabel('action proba')
axis([0 size(LOG_FILES,1) 0 1])

FigHandle = gcf;
set(FigHandle, 'Position', [100, 500, 250, 750]);

%% end of figure

% %%%%%%%%%%%%%%%%%%%%%%
% %% OLD PLOT FIGURE OLD
% close all
% 
% figure
% 
% % plotting engagement
% subplot(5, 2, 1)
% plot(LOG_FILES(:, 16), 'LineWidth', 3)
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [0 10], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('engagement')
% axis([0 size(LOG_FILES,1) 0 10])
% 
% % plotting learning variables
% subplot(5, 2, 3)
% plot(LOG_FILES(:, 17), 'k', 'LineWidth', 3)
% hold on
% plot(LOG_FILES(:, 18), 'r', 'LineWidth', 3)
% %plot(50 * LOG_FILES(:, 64), 'b', 'LineWidth', 3)
% legend('delta', 'VC', '50sig')
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [-10 10], '--k', 'LineWidth', 2) %[min(min(50 * LOG_FILES(:, 64)),min(LOG_FILES(:,18))) max(max(50 * LOG_FILES(:, 64)),max(LOG_FILES(:,18)))], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('critic')
% axis([0 size(LOG_FILES,1) -10 10]) %min(min(50 * LOG_FILES(:, 64)),min(LOG_FILES(:,18))) max(max(50 * LOG_FILES(:, 64)),max(LOG_FILES(:,18)))])
% 
% % plotting action Q-values
% subplot(5, 2, 8)
% plot(LOG_FILES(:,37:42), 'LineWidth', 3)
% %legend('Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6')
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [-6 8], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('Q-values')
% axis([0 size(LOG_FILES,1) -6 8])
% 
% % plotting KALMAN Q-values
% subplot(5, 2, 7)
% plot(LOG_FILES(:,52:57), 'LineWidth', 3)
% %legend('KQ1', 'KQ2', 'KQ3', 'KQ4', 'KQ5', 'KQ6')
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [-5 3], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('Kalman Qs')
% axis([0 size(LOG_FILES,1) -5 3])
% 
% % plotting KALMAN covariance
% subplot(5, 2, 9)
% plot(LOG_FILES(:,58:63), 'LineWidth', 3)
% legend('A1', 'A2', 'A3', 'A4', 'A5', 'A6')
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [0 1], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('Kalman COV')
% axis([0 size(LOG_FILES,1) 0 1])
% 
% %% second column
% 
% % plotting engagement
% subplot(5, 2, 2)
% plot(LOG_FILES(:, 16), 'LineWidth', 3)
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [0 10], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('engagement')
% axis([0 size(LOG_FILES,1) 0 10])
% 
% % plotting reward
% subplot(5, 2, 4)
% plot(LOG_FILES(:, 8), '^k', 'MarkerSize', 3)
% hold on
% switch (whichModel)
%     case 3
%         plot(LOG_FILES(:, 43), 'r', 'LineWidth', 3)
%         plot(LOG_FILES(:, 64), 'b', 'LineWidth', 3)
%     case {4,5,6}
%         LOG_FILES(:, 67) = LOG_FILES(:,67) + 2;
%         plot(LOG_FILES(:, 65:67), 'Linewidth', 3)
% end
% %boubou = (1 ./ (1 + exp(LOG_FILES(:,65:67))) - 0.5);
% %%plot([200 * boubou(:,1) 200 * boubou(:,2) 10 * boubou(:,3)],'Linewidth',3)
% %plot([(10 * LOG_FILES(:,65) - 1) (10 * LOG_FILES(:,66) - 1) (5 * boubou(:,3) + 2)],'Linewidth',3)
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%     plot([verti verti], [-1.5 1.5], '--k', 'LineWidth', 2)
%     verti = verti + episodeLength;
%     end
% end
% ylabel('rwd & metaparam')
% %legend('r','short','long','diff')
% %legend('reward','metaparam')
% axis([0 size(LOG_FILES,1) -1.5 1.5])
% 
% % plotting learned action parameter
% subplot(5, 2, 4)
% optiparam = LOG_FILES(:, 7);
% optiparam(LOG_FILES(:,6) ~= 2) = NaN;
% plot(optiparam, '.')
% hold on
% plot(LOG_FILES(:,20), 'k', 'LineWidth', 3)
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [BBT.intervalle(1) BBT.intervalle(end)], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('action 2 param')
% axis([0 size(LOG_FILES,1) -100 100]) %BBT.intervalle(1) BBT.intervalle(end)]) %min(LOG_FILES(:,18)) max(LOG_FILES(:,18))])
% 
% % plotting learned action parameter
% subplot(5, 2, 6)
% optiparam = LOG_FILES(:, 7);
% optiparam(LOG_FILES(:,6) ~= 6) = NaN;
% plot(optiparam, '.')
% hold on
% plot(LOG_FILES(:,24), 'k', 'LineWidth', 3)
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [BBT.intervalle(1) BBT.intervalle(end)], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% ylabel('action 6 param')
% axis([0 size(LOG_FILES,1) -100 100]) %BBT.intervalle(1) BBT.intervalle(end)]) %min(LOG_FILES(:,18)) max(LOG_FILES(:,18))])
% 
% % plotting action probabilities
% subplot(5, 2, 10)
% plot(LOG_FILES(:,25:30), 'LineWidth', 3)
% %legend('P1', 'P2', 'P3', 'P4', 'P5', 'P6')
% hold on
% if (vertiBars)
%     verti = episodeLength;
%     while (verti <= size(LOG_FILES,1))
%         plot([verti verti], [0 1], '--k', 'LineWidth', 2)
%         verti = verti + episodeLength;
%     end
% end
% xlabel('timesteps')
% ylabel('action proba')
% axis([0 size(LOG_FILES,1) 0 1])
% 
% %% end of figure

clear iii; clear verti; clear optiparam; clear logs;
BBR
%[BBR.kalmanV ; diag(BBR.kalmanCOV)' ; BBR.PA]
reward_engage = [mean(LOG_FILES(:,8)) mean(LOG_FILES(:,16))]
