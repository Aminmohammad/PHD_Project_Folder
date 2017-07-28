function output = True_Positive_Rate_Calculator_for_One_Reference_Device ( varargin )

    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |                                                                      |     Data-Point-1 (from Testing-Device)     |     Data-Point-2 (from Testing-Device)     |     ...     |     Data-Point-k (from Testing-Device)     |
    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |   Reference-Device-Probabilities-for-each-Testing-Device-DataPoint   |                                            |                                            |             |                                            |  
    % |           (probabilities_of_Testing_Device_DataPoins)                |                   p1i                      |                   p2i                      |     ...     |                   pki                      |
    % |              Device-i ( Reference_Device_Index = i )                 |                                            |                                            |             |                                            | 
    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % 
    % pji: Probability that TestingDevice-DataPoint-j belongs to the Reference-Device-i
    %
    %
    % Testing Device:                       'Any Device except Referece ( = Negative = Known ) Device'
    
     %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            
            inputSet.addParameter('true_Labels_of_Testing_DataPoints', []);
            inputSet.addParameter('probabilities_of_Testing_DataPoins', []);            
            inputSet.addParameter('thresholds_for_True_or_False_Positive_Rates', []);
            inputSet.addParameter('Reference_Device_Index', []);

            inputSet.parse(varargin{:});

            true_Labels_of_Testing_DataPoints           = inputSet.Results.true_Labels_of_Testing_DataPoints;
            probabilities_of_Testing_DataPoins          = inputSet.Results.probabilities_of_Testing_DataPoins;
            thresholds_for_True_or_False_Positive_Rates = inputSet.Results.thresholds_for_True_or_False_Positive_Rates;
            Reference_Device_Index                      = inputSet.Results.Reference_Device_Index;

            % Level 1: Sorting the Input
                [ probabilities_of_Testing_DataPoins, sorting_Indices_of_Probabilities_of_Testing_DataPoins ] = sort ( probabilities_of_Testing_DataPoins );
                true_Labels_of_Testing_DataPoints                                                               = true_Labels_of_Testing_DataPoints (1, sorting_Indices_of_Probabilities_of_Testing_DataPoins);            

     %% Section 3: Extraction of 'True Positive Rate'
            % Level 1: Number of 'Positive Data-Points' 
                number_of_Testing_Data_Points = numel ( probabilities_of_Testing_DataPoins );
                
        for threshold_Index = 1 : numel ( thresholds_for_True_or_False_Positive_Rates )
            
            current_Threshold = thresholds_for_True_or_False_Positive_Rates ( 1, threshold_Index );
            
            % Level 1: Finding 'Probabilities' Higher than 'each Threshold'
                indices_of_Testing_DataPoints_Which_are_Selected_as_nonReference_Device_DataPoints_for_Current_Threshold = ( probabilities_of_Testing_DataPoins < current_Threshold ); 

%             % Level 2: Determination of a 'Label Vector' based on 'Current Threshold' for Comparison
%                 label_Vector                                                                                                               = zeros ( 1, numel ( indices_of_Reference_DataPoints_Which_are_Selected_as_Reference_Device_DataPoints_for_Current_Threshold ) );
%                 label_Vector ( 1, indices_of_Reference_DataPoints_Which_are_Selected_as_Reference_Device_DataPoints_for_Current_Threshold )  = Reference_Device_Index;
%                 label_Vector ( 1, ~indices_of_Reference_DataPoints_Which_are_Selected_as_Reference_Device_DataPoints_for_Current_Threshold ) = inf;

            % Level 3: Number of 'Testing Device Data-Points' which Match the 'Actual Labels of Testing Data-Points' 
%                 comparison = ( true_Labels_of_Reference_DataPoints == label_Vector );
                number_of_Extracted_Labels_of_Testing_Device_DataPoints_which_Match_the_Actual_Labels_for_Current_Threshold = sum ( indices_of_Testing_DataPoints_Which_are_Selected_as_nonReference_Device_DataPoints_for_Current_Threshold );
            
            % Level 4: Finding 'True Positive Rate'
                true_Positive_Rates_of_Classifications_for_all_Thresholds ( 1, threshold_Index ) = ( number_of_Extracted_Labels_of_Testing_Device_DataPoints_which_Match_the_Actual_Labels_for_Current_Threshold )/ number_of_Testing_Data_Points;
                    
        end

     %% Section 4: Output           
        % Level 2: 'True Positive Rate'
            output. true_Positive_Rates_of_Classifications_for_all_Thresholds = true_Positive_Rates_of_Classifications_for_all_Thresholds;
            
            
end