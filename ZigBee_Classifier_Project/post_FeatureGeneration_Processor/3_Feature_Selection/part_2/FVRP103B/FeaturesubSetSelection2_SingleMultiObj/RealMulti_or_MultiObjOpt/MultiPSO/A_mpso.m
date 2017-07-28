    % from 47:00 to end
        clc;
        clear;
        close all;

    %% Load Data
        data=B_LoadData();
        nx=data.nx;

    %% Multi PSO
        BestSol=cell(nx,1);
        S=cell(nx,1);
        BestCost=zeros(nx,1);

        for nf=1:nx
            disp(['Selecting ' num2str(nf) ' feature(s) ...']);
            results=C_RunPSO(data,nf);
            disp(' ');

            BestSol{nf}=results.BestSol;
            S{nf}=BestSol{nf}.Out.S;
            BestCost(nf)=BestSol{nf}.Cost;
        end

    %% Plot Results
        figure;
        plot(1:nx,BestCost,'*');
        xlabel('n_f');
        ylabel('E');

        save('run_results.mat');
