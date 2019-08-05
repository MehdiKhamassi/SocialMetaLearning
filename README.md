# Meta-learning based on social engagement reward signal

> This is the source code going with the following publication: Khamassi, M., Velentzas, G., Tsitsimis, T. and Tzafestas, C. (2018). Robot fast adaptation to changes in human engagement during simulated dynamic social interaction with active exploration in parameterized reinforcement learning. IEEE Transactions on Cognitive and Developmental Systems, 10(4):881-893.

> This code was part of the EU H2020 BabyRobot project, for which most of code is available at: https://github.com/orgs/babyrobot-eu/.

This Matlab source code implements an active exploration algorithm for RL during HRI where the reward function is the weighted sum of the human’s current engagement and variations of this engagement. It uses a parameterized action space where a meta-learning algorithm is applied to simultaneously tune the exploration in discrete action space (e.g., moving an object) and in the space of continuous characteristics of movement (e.g., velocity, direction, strength, and expressivity). The code tests the algorithm in a simple simulated HRI task with a single state, a small set of discrete actions, and one continuous parameter per action. The task is thus equivalent to a bandit task in parameterized action space. 

## Structure of the present files

```
/ [root]
├── README.md
├── code
│   ├── main.m (runs a single simulation experiment)
│   └── ... (other matlab files called by main.m)
├── data
│   ├── bestModelsOptiSummer2016 (contains the optimized parameters for each tested model)
│   └── ... (other .mat files contain individual simulation experiments results that were used for illustration in the paper)
└── results
    └── [your future results]
```

## Quick start

Use main.m to launch a simulation experiment and to plot a few figures (including figures similar to the illustrative individual experiments shown in Fig.3 in the paper). If you want to change the model, change the variable called ‘whichModel’ in run.sh. There you can also change the duration of the experiment, and some other constraints of the task.

After launching a simulation experiment, you can save the corresponding data in a .mat file. Ex: save([‘MyDirectory/MyModel_Expe1.mat’]).

Repeat the same process to save at least 10 experiments for a given model. This is required to then compare the performance curves of different models as in Fig.5 of the paper.

Fig.4 in the paper has been obtained after making a grid search in the parameter space for each model. This uses the functions BBoptimize.m, BBoptimizeParameters.m. Since such an optimization process is very long, it has been launched in parallel on a cluster of computers, using BBparallelOpti.m and BBcluster.sh.

Now you can play with the code to compare different models. You can also modify the parameters of the model by preventing main.m to read the parameter values in the file called bestModelsOptiSummer2016.mat, or by overriding these parameter values.

## Questions

Contact Mehdi Khamassi (firstname (dot) lastname (at) upmc (dot) fr)
