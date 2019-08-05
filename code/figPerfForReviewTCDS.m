%% load data
load ../data/experiment41_logs.mat

%% parameters
whichModel = 5;
runOptimizedModels = 1;
episodeLength = 1000;
vertiBars = true;

%% optimal discrete action
optiaction = [LOG_FILES(1:1001,6)==6;LOG_FILES(1002:2001,6)==2;LOG_FILES(2002:3001,6)==6;LOG_FILES(3002:4001,6)==2;LOG_FILES(4002:5001,6)==6];
boubou=zeros(5001,1);
for iii=20:5001
    boubou(iii)=mean(optiaction(iii-19:iii));
end

%% optimal continuous param
%optiparam = LOG_FILES(:, 7);
%probaEng = (exp((- (a.param - BBT.engMu) ^ 2) / (2 * BBT.engSig ^ 2)) - 0.5) * 2;
optiparam = (exp((- (LOG_FILES(1:1001, 7) + 50) .^ 2) ./ (2 * BBT.engSig .^ 2)) - 0.5) .* 2;
optiparam = [optiparam ; (exp((- (LOG_FILES(1002:2001, 7) - 50) .^ 2) ./ (2 * BBT.engSig .^ 2)) - 0.5) .* 2];
optiparam = [optiparam ; (exp((- (LOG_FILES(2002:3001, 7) + 50) .^ 2) ./ (2 * BBT.engSig .^ 2)) - 0.5) .* 2];
optiparam = [optiparam ; (exp((- (LOG_FILES(3002:4001, 7) - 50) .^ 2) ./ (2 * BBT.engSig .^ 2)) - 0.5) .* 2];
optiparam = [optiparam ; (exp((- (LOG_FILES(4002:5001, 7) + 50) .^ 2) ./ (2 * BBT.engSig .^ 2)) - 0.5) .* 2];
boubou2=zeros(5001,1);
for iii=20:5001
    boubou2(iii)=mean(optiparam(iii-19:iii)>0);
end

%% joint performance
boubou4=zeros(5001,1);
for iii=20:5001
    boubou4(iii)=mean(optiaction(iii-19:iii).*(optiparam(iii-19:iii)>0));
end

%% figure
subplot(4, 1, 1)
if (vertiBars)
    verti = episodeLength;
    while (verti <= size(LOG_FILES,1))
        plot([verti verti], [0 10], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
plot(LOG_FILES(:, 16), 'k', 'LineWidth', 3)
ylabel('engagement')
axis([0 size(LOG_FILES,1) 0 10])
title('Meta-learning, experiment shown in Fig3-D')
subplot(4, 1, 2)
if (vertiBars)
    verti = episodeLength;
    while (verti <= size(LOG_FILES,1))
        plot([verti verti], [0 10], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
plot(boubou,'LineWidth',2)
axis([0 size(LOG_FILES,1) 0 1])
ylabel('perf action')
subplot(4, 1, 3)
if (vertiBars)
    verti = episodeLength;
    while (verti <= size(LOG_FILES,1))
        plot([verti verti], [0 10], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
plot(boubou2,'r','LineWidth',2)
axis([0 size(LOG_FILES,1) 0 1])
ylabel('perf param')
subplot(4, 1, 4)
if (vertiBars)
    verti = episodeLength;
    while (verti <= size(LOG_FILES,1))
        plot([verti verti], [0 10], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 2)
        hold on
        verti = verti + episodeLength;
    end
end
plot(boubou4,'k','LineWidth',2)
axis([0 size(LOG_FILES,1) 0 1])
ylabel('joint perf')
xlabel('timesteps')
