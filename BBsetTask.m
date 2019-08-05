function BBtask = BBsetTask()

    % This functions returns the task for the Baby Robot Use Case 2 Learning scenario.

    %% Context/Child number (=type of children involved in the interaction)
    % 1 = normal
    % 2 = curious
    % 3 = introspective
    nC = 1;
    
    %% Context/Child engagement
    % min engagement
    minENG = 0;
    % max engagement
    maxENG = 10;
    % current engagement = initial child engagement (just the fact to see the robot)
    cENG = (minENG+maxENG)/2; % OLD : minENG;
    % re-engagement rate
    reeng = 0.1;
    % forgetting rate
    forget = 0.05; %0.01;
    % gaussian child engagement
    engMu = -50; engSig = 10; % -50 10
    % weight of engagement variations in reward function
    lambdaRwd = 0.7;

    %% Number of dimensions of the state vector of the robot:
    % CONSIDER SWITCHING TO RELATIONAL REINFORCEMENT LEARNING (PIETQUIN)
    % 6 lego bricks on table (3 near child; 3 near robot). Tower location accessible by both.
    % State vector has 5 dimensions (Total: 7x2x2x2x2=112 states):
    % 1 number of bricks in tour (0 to 6)
    % 2 presence of cubes near robot
    % 3 presence of cubes near child
    % 4 robot hand full
    % 5 child hand full.
    nS = 5;

    %% Number of actions available to the robot:
    % 6 Actions: 1 nothing, 2 pointing, 3 picking, 4 placing, 5 giving, 6 receiving.
    nA = 6;
    % current optimal action
    optimal = 6;
    
    %% Action parameters
    % interval of possible action parameters
    intervalle = [-100:5:100];

    % Initial state distribution. This a vector which indicates the probability of
    % starting in a given state, for each state. Recall that our robot will always
    % start in state 1. Fill in the corresponding probabilities.
    P0 = zeros(1, nS);
    P0(2:3) = 1;

    % We now create a structure that stores all the elements of the MDP
    BBtask = struct('nC', nC, 'minENG', minENG, 'maxENG', maxENG, 'cENG', cENG, 'forget', forget, 'reeng', reeng, 'engMu', engMu, 'engSig', engSig, 'lambdaRwd', lambdaRwd, 'nS', nS, 'nA', nA, 'P0', P0, 'intervalle', intervalle, 'optimal', optimal);

end