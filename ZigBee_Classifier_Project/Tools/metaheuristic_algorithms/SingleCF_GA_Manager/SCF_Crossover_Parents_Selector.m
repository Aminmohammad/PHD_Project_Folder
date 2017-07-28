function Selected_Parents_for_Crossover = SCF_Crossover_Parents_Selector (Population, N_Crossover, Method)
    if(strcmp(Method,'Minimum_TotalCost') == 1 )
        Selected_Parents_for_Crossover = Population(1:N_Crossover);
        
    end
    if(strcmp(Method,'RoulleteWheel')==1)
        F = [Population.fitness];
        P = (1./F)./sum(1./F);
        Cump = cumsum(P);
        for i = 1:N_Crossover
            R = rand;
            C = find(Cump>=R,1);
            Selected_Parents_for_Crossover(i) = Population(C);
        end
        Selected_Parents_for_Crossover = Selected_Parents_for_Crossover';
    end
end