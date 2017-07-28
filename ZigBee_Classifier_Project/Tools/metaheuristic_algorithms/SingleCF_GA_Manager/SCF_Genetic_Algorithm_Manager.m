
function [ output ] = SCF_Genetic_Algorithm_Manager (   GA_Parameters_Structure,                         ...
                                                        weight_Specific_Structure,                       ...
                                                        general_Plot_Title,                              ...
                                                        structure_of_Fixed_Variables_for_Cost_Function,  ...
                                                        Saving_Address,                                  ...
                                                        selected_Saving_Extension,                       ...
                                                        number_of_Hidden_Layer_Neurons_Text)
                                                                                                                                         
                                           
    %% Section 0: Extraction of Initial Parameters
        number_of_Vars    = GA_Parameters_Structure. number_of_Vars;            
        var_Min_Vector    = GA_Parameters_Structure. var_Min_Vector;                                 
        var_Max_Vector    = GA_Parameters_Structure. var_Max_Vector;
        maximum_Iteration = GA_Parameters_Structure. maximum_Iteration;                       
        population_Size   = GA_Parameters_Structure. population_Size;                            
        p_CrossOver       = GA_Parameters_Structure. p_CrossOver;                                   
        p_Mutation        = GA_Parameters_Structure. p_Mutation;                                    
        deviation         = GA_Parameters_Structure. deviation;                                     
        ranking_Policy    = GA_Parameters_Structure. ranking_Policy;
    
    %% Section 1: Determination of initial Conditions    
        % if initial_Population is 'not' empty, we Should check the 'population_Size' with 'size(initial_Population, 1)'
        %    if these values are 'not' the same, we should replace 'size(initial_Population, 1)' instead of 'population_Size'            
            for index = 1 : population_Size
                initial_Population ( index, : )    = rand(1,number_of_Vars) .* ( var_Max_Vector - var_Min_Vector ) - var_Min_Vector;
                output = WrittenV1_Perceptron_Neural_Network_Cost_Function_Calculator ( initial_Population(index,:),                       ...
                                                                                        weight_Specific_Structure,                         ...
                                                                                        structure_of_Fixed_Variables_for_Cost_Function ); 
                                                                                                                
                cost_Function_Structue( index, 1 ).mean_Squared_error = output.mean_Squared_error;
                cost_Function_Structue( index, 1 ).network            = output.network;
                cost_Function_Structue( index, 1 ).output_from_Net    = output.output_from_Net;
                cost_Function_Structue( index, 1 ).class_Labels       = output.class_Labels;
                
            end
            
        % Generic Algorithm Conditions ( Even Numbers for n_Crossover & n_Mutation )
            if ( floor(p_CrossOver * population_Size)/2 ) ==  floor( floor(p_CrossOver * population_Size)/2 )
                n_Crossover = floor(p_CrossOver * population_Size);
            else
                n_Crossover = floor(p_CrossOver * population_Size) - 1 ;
            end
            
            if ( floor(p_Mutation * population_Size)/2 ) ==  floor( floor(p_Mutation * population_Size)/2 )
                n_Mutation = floor(p_Mutation * population_Size);
            else
                n_Mutation = floor(p_Mutation * population_Size) - 1 ;
            end   

    %% Section 3: Determination of Initial Population             
        for loop_Index = 1 : population_Size
            chromosome_Population(loop_Index, 1).value = initial_Population( loop_Index, : );  
            
        end

    %% Section 4 : Updating Chromosomes by Crossover and Mutation 
         matrix_of_Chromosome_Population = []; 
         vertical_Structure_of_Best_chromosome       = [];
         previous_Saved_Index = 0;
         figurenumber = figure;      
                
         for iteration_Index = 1: maximum_Iteration  
              fprintf(' Program is in the %d-th Iteration out of %d possible iterations ( Phase 3 : Crossover and Mutation ).\n', iteration_Index, maximum_Iteration);

            % Level 1: Generation of New Population              
                % section 1: Crossovering population
                    % Selection of Parents for Crossover
                        Selected_Parents_for_Crossover = SCF_Crossover_Parents_Selector(chromosome_Population, n_Crossover, 'Minimum_TotalCost' ); %% Methods: 'Minimum_TotalCost' or 'RoulleteWheel'
                                                                                                                                                               % ranking_Policy: 'Ascend' or 'Descend'
                    % Crossovering Parents
                        for crossover_Index = 1 : 2 : n_Crossover

                            % Calculation of 'Crossovered_parents'
                                alpha = rand;
                                [crossovered_parent_1, crossovered_parent_2]      = SCF_Parents_Crosoverer( Selected_Parents_for_Crossover(crossover_Index).value, Selected_Parents_for_Crossover(crossover_Index + 1).value, var_Min_Vector, var_Max_Vector, alpha);
                                crossovered_parent_1 = crossovered_parent_1 / sum ( crossovered_parent_1 );
                                crossovered_parent_2 = crossovered_parent_2 / sum ( crossovered_parent_2 );

                                crossovered_parents(crossover_Index, 1).value     = crossovered_parent_1;
                                crossovered_parents(crossover_Index + 1, 1).value = crossovered_parent_2;

                        end

            % Level 2: Mutating population 
                    for mutation_Index = 1 : n_Mutation

                        % Mutating the Pupulation
                            selected_Population_Index_for_Mutation         = randsample(1 : size   ( chromosome_Population, 1), 1);
                            mutated_Population                             = SCF_Population_Mutator( chromosome_Population( selected_Population_Index_for_Mutation ).value, deviation, var_Min_Vector, var_Max_Vector);                    
                            mutated_Population                             = mutated_Population / sum ( mutated_Population );
                            mutated_Populations( mutation_Index, 1 ).value = mutated_Population;

                    end

            % Level 3 : Acumulation of Previous Chromosome_Population && New Crossovered_parents && New Mutated_Population
                temp_Chromosome_Population = [chromosome_Population; crossovered_parents; mutated_Populations];
                chromosome_Population = temp_Chromosome_Population;
                temp_Matrix_of_all_Chromosome_Populations = [];
                    
            % Level 4 : Calculation of Different Total Costs               
                 % Stage 1 : Attaching ( Lambda-Populations                                                && Rho-Int && CodeRate  && new_Epsilon && ( 1 - Code-Rate - new_Epsilon ) / ( 1 - new_Epsilon ) && SimgaLambda : for " User Selection Mode" ) or 
                                       % ( Lambda-Populations && r_AVG, code_Rate_Coeff1 && code_Rate_Coeff2 && Rho_Int && code_Rate && new_Epsilon && ( 1 - Code-Rate - new_Epsilon ) / ( 1 - new_Epsilon ) && SimgaLambda : for " LP Mode"             ) Together     
                        number_of_all_Members_of_Total_Population = size ( chromosome_Population , 1);

                        for index = 1 : number_of_all_Members_of_Total_Population                            
                            temp_Matrix_of_all_Chromosome_Populations ( index , : ) = [chromosome_Population( index, 1). value];

                            % Extraction of CodeRate && Rho_Int
                                 output = WrittenV1_Perceptron_Neural_Network_Cost_Function_Calculator ( temp_Matrix_of_all_Chromosome_Populations ( index , : ),    ...
                                                                                                         weight_Specific_Structure,                                  ...
                                                                                                         structure_of_Fixed_Variables_for_Cost_Function );
                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                 cost_Function_Structue( index, 1 ).mean_Squared_error = output.mean_Squared_error;
                                 cost_Function_Structue( index, 1 ).network            = output.network;
                                 cost_Function_Structue( index, 1 ).output_from_Net    = output.output_from_Net;
                                 cost_Function_Structue( index, 1 ).class_Labels       = output.class_Labels;
                
                        end

                 % Stage 2 : Sorting the Result                     
                    if ( strcmp (ranking_Policy, 'Ascend' ) == 1 )
                        [~, Index_Vector] = sort( [cost_Function_Structue.mean_Squared_error], 'descend');

                    elseif ( strcmp (ranking_Policy, 'Descend' ) == 1 )
                        [~, Index_Vector] = sort( [cost_Function_Structue.mean_Squared_error], 'ascend');
                    end 
                    Index_Vector = Index_Vector (:);

                    chromosome_Population = [];
                    for index = 1 : population_Size
                        chromosome_Population ( index, 1). value         = temp_Matrix_of_all_Chromosome_Populations ( Index_Vector( index, 1 ), : ); 
                        
                    end                           
                    
           % Level 5 : Saving Best 'Chromosome' of all Iterations   
                vertical_Structure_of_Best_chromosome ( iteration_Index, 1). network                = cost_Function_Structue( Index_Vector( 1, 1 ), : ).network;
                vertical_Structure_of_Best_chromosome ( iteration_Index, 1). mean_Squared_error     = cost_Function_Structue( Index_Vector( 1, 1 ), : ).mean_Squared_error;
                vertical_Structure_of_Best_chromosome ( iteration_Index, 1). output_from_Net        = cost_Function_Structue( Index_Vector( 1, 1 ), : ).output_from_Net;
                vertical_Structure_of_Best_chromosome ( iteration_Index, 1). class_Labels           = cost_Function_Structue( Index_Vector( 1, 1 ), : ).class_Labels;
                
           % Level 6 : Saving all 'Chromosome-Populations' of all Iterations
                set(0,'CurrentFigure', figurenumber)
                plot ( [vertical_Structure_of_Best_chromosome.mean_Squared_error], 'b--o', 'LineWidth', 2 )
                hold on
                pause ( .1 )                
                
                grid on;

         end 
         hold off;
         
     % Figure Label
        xlabel ( 'Iterations' );
        ylabel ( 'MSE (DataBank-Labels - Model-Labels)' )

        if ( isempty ( general_Plot_Title ) == 0 )
            part_1  = sprintf ( '%s', general_Plot_Title (1, : ) );
            part_2  = sprintf ( '%s', general_Plot_Title (2, : ) );
            part_3  = sprintf ( '%s', general_Plot_Title (3, : ) );
            part_4  = 'Convergence Procedure of "GA + Neural Network"';

            Title   = sprintf ('%s\n%s\n%s\n\n%s', part_1, part_2, part_3, part_4 );
            title( Title, 'Interpreter', 'none' );

        else
            part_1  = [];

            Title   = sprintf ('%s', part_1 );        
            title( Title, 'Interpreter', 'none' );

        end       
        
    %% Section 5: Demonstration
        handle = Drawing_and_Saving_a_Java_GUI_in_a_Figure ( vertical_Structure_of_Best_chromosome(end, 1).network, [ Saving_Address '\' 'WrittenV1_Perceptron_Neural_Network' '_' number_of_Hidden_Layer_Neurons_Text ] , selected_Saving_Extension );
        close ( handle )
                
    %% Section 6: Output     
         output = [];
         output.net                =  vertical_Structure_of_Best_chromosome(end, 1).network;
         output.outputs            = [vertical_Structure_of_Best_chromosome(end, 1).output_from_Net];
         output.class_Labels       = [vertical_Structure_of_Best_chromosome(end, 1).class_Labels];
         output.mean_Squared_error = [vertical_Structure_of_Best_chromosome(end, 1).mean_Squared_error];
size([output.outputs])
end
