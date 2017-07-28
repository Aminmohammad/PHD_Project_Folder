function output = WrittenV1_Perceptron_Neural_Network ( varargin )

% Input:
%
%   input_DataPoints_Matrix: 
%                    DataPoints
%                __              __
%                |                |
%                |                |            
%    Dimensions  |                |
%                |_              _|

%   classLabels_from_DataBank:
%                 _              _
%                |_              _|

    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('input_DataPoints_Matrix', []);    
            inputSet.addParameter('classLabels_from_DataBank', []);
            inputSet.addParameter('special_Structure_of_Parameters_for_Classification', []);
            inputSet.addParameter('general_Plot_Title', []); 

            inputSet.parse(varargin{:});

            input_DataPoints_Matrix                            = inputSet.Results.input_DataPoints_Matrix;
            classLabels_from_DataBank                          = inputSet.Results.classLabels_from_DataBank;
            special_Structure_of_Parameters_for_Classification = inputSet.Results.special_Structure_of_Parameters_for_Classification;
            general_Plot_Title                                 = inputSet.Results.general_Plot_Title;

            number_of_DataPoints             = size( input_DataPoints_Matrix, 2 );
            number_of_DataPoints_Dimensions  = size( input_DataPoints_Matrix, 1 );
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );
                                    
            if        ( isempty( input_DataPoints_Matrix ) == 1 )        
                error ( 'You should Enter the "input_DataPoints_Matrix" for Classification in "WrittenV1_Perceptron_Neural_Network".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels_from_DataBank" for Classification in "WrittenV1_Perceptron_Neural_Network".' );

            end    

            if ( isempty( special_Structure_of_Parameters_for_Classification ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'number_of_Hidden_Layer_Neurons' ) ) == 0 )
                number_of_Hidden_Layer_Neurons   = special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons;
                
            else
                number_of_Hidden_Layer_Neurons = [ 10 number_of_ClassLabels_Dimensions ];
                
            end
            
            if ( isempty( special_Structure_of_Parameters_for_Classification ) == 0 && isempty (  isfield ( special_Structure_of_Parameters_for_Classification, 'hiddenLayer_Type_of_Neturons' ) ) == 0 )
                hiddenLayer_Type_of_Neturons          = special_Structure_of_Parameters_for_Classification.hiddenLayer_Type_of_Neturons;
                
            else
                
                number_of_Hidden_Layer_Neurons = number_of_Hidden_Layer_Neurons (:)';
                for index = 1 : size ( number_of_Hidden_Layer_Neurons, 2 )
                    hiddenLayer_Type_of_Neturons ( 1, index ) = { 'tansig' };
                end
                
            end
            
            if ( isempty( special_Structure_of_Parameters_for_Classification ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'GA_Parameters_Structure' ) ) == 0 )
                GA_Parameters_Structure                   = special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure;
                
            else
                maximum_Iteration    = 100;
                population_Size      = 100;
                p_CrossOver          = .8;
                p_Mutation           = .1;
                deviation            = 10;
                ranking_Policy       = 'Descend';
                training_Probability = .8;
                                            
                GA_Parameters_Structure. maximum_Iteration = maximum_Iteration;                       
                GA_Parameters_Structure. population_Size   = population_Size;                            
                GA_Parameters_Structure. p_CrossOver       = p_CrossOver;                                   
                GA_Parameters_Structure. p_Mutation        = p_Mutation;                                    
                GA_Parameters_Structure. deviation         = deviation;                                     
                GA_Parameters_Structure. ranking_Policy    = ranking_Policy;
            end       
            
            if ( isempty( special_Structure_of_Parameters_for_Classification ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'training_Probability' ) ) == 0 )
                training_Probability                   = special_Structure_of_Parameters_for_Classification.training_Probability;
                
            else
                training_Probability = .8;
                                            
            end               

    %% Section 2: Tarining the Model
        % Level 1: Normalization
                Minimum_of_Datapoints_in_all_Dimensions  = min ( input_DataPoints_Matrix' ); %#ok<*UDIM>
                Maximum_of_Datapoints_in_all_Dimensions  = max ( input_DataPoints_Matrix' );

                Minimum_of_ClassLabels_in_all_Dimensions = min ( classLabels_from_DataBank' );
                Maximum_of_ClassLabels_in_all_Dimensions = max ( classLabels_from_DataBank' );

                for dimension_Index = 1 : number_of_DataPoints_Dimensions
                    normalized_DataPoints ( dimension_Index, : ) = Normalize_Fcn ( input_DataPoints_Matrix ( dimension_Index, : ), Minimum_of_Datapoints_in_all_Dimensions ( dimension_Index ), Maximum_of_Datapoints_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                end

                for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                    normalized_ClassLabels ( dimension_Index, : ) = Normalize_Fcn ( classLabels_from_DataBank ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) );
                end

                inputs  = normalized_DataPoints;
                targets = normalized_ClassLabels;
                
        % Level 2: Network Structure
                pr  = [-1 1];
                PR  = repmat( pr, number_of_DataPoints_Dimensions, 1 );
                net = newff ( PR, number_of_Hidden_Layer_Neurons, hiddenLayer_Type_of_Neturons );

        % Level 3: making the model ready for 'GA Algorithm'        
            weight_Specific_Structure = Weight_Specific_Structure_Extractor_for_GA ( net, inputs, targets );
            number_of_Vars                           = size ( weight_Specific_Structure . raw_Chromosome_Horizontal_Vector, 2);

            structure_of_Fixed_Variables_for_Cost_Function.dataPoints   = inputs;
            structure_of_Fixed_Variables_for_Cost_Function.class_Labels = targets;
            structure_of_Fixed_Variables_for_Cost_Function.net          = net;
                                                                                                      
            var_Min_Vector = -1 * ones ( 1, number_of_Vars );             
            var_Max_Vector =  1 * ones ( 1, number_of_Vars );                                                             
                   
            GA_Parameters_Structure. number_of_Vars = number_of_Vars;                       
            GA_Parameters_Structure. var_Min_Vector = var_Min_Vector; 
            GA_Parameters_Structure. var_Max_Vector = var_Max_Vector; 
            
            % Making the Proper Name
                number_of_Hidden_Layer_Neurons_Text = [];
                for index = 1 : size ( number_of_Hidden_Layer_Neurons, 2 )
                    number_of_Hidden_Layer_Neurons_Text = [ number_of_Hidden_Layer_Neurons_Text '_' num2str( number_of_Hidden_Layer_Neurons(1, index) ) ];
                end

                number_of_Hidden_Layer_Neurons_Text = [ '(' number_of_Hidden_Layer_Neurons_Text(1, 2: end) ')' ];
                  
            % Output    
                output   = SCF_Genetic_Algorithm_Manager ( GA_Parameters_Structure,                         ...
                                                           weight_Specific_Structure,                       ...
                                                           general_Plot_Title,                              ...
                                                           structure_of_Fixed_Variables_for_Cost_Function,  ...
                                                           Saving_Address,                                  ...
                                                           selected_Saving_Extension,                       ...
                                                           number_of_Hidden_Layer_Neurons_Text);

       
    %% Section 4: Outputs
        outputs = [ output.outputs ];        

        % Level 1: Reforming the 'outputs' in the Range of 'initial ClassLabels'
            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                reformed_Outputs ( dimension_Index, : ) = Reform_Fcn ( outputs ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                
            end
            
         % Level 2: Rounding   
            outputs = round ( reformed_Outputs );

         % Level 3: Clamping
            outputs ( outputs > max ( classLabels_from_DataBank ) ) = max ( classLabels_from_DataBank );
            outputs ( outputs < min ( classLabels_from_DataBank ) ) = min ( classLabels_from_DataBank );
         
         % Level 4: Output
            temp_Raw_outputs                           = reformed_Outputs;  
            temp_Rounded_and_Clampd_outputs            = outputs;
            
            output.outputs_Train.raw_Output            = temp_Raw_outputs;
            output.outputs_Train.roundedClamped_Output = temp_Rounded_and_Clampd_outputs;
            
            output.outputs_Test.raw_Output             = temp_Raw_outputs;
            output.outputs_Test.roundedClamped_Output  = temp_Rounded_and_Clampd_outputs;

            
end