    % from 43:26 to 47:00
        clc;
        clear;
        close all;

    %% Load Data
        data=B_LoadData();
        nf=4;

    %% PSO
        results=C_RunPSO(data,nf);

    %% Plot Results    
        figure;
        plot(results.BestCost,'LineWidth',2);
        xlabel('Iteration');
        ylabel('Best Cost');
