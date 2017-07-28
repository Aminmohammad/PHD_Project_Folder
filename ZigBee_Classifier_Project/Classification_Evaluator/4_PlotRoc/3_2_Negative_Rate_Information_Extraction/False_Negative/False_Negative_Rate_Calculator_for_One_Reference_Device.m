function output = False_Negative_Rate_Calculator_for_One_Reference_Device ( varargin )

    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |                                                                      |     Data-Point-1 (from Testing-Device)     |     Data-Point-2 (from Testing-Device)     |     ...     |     Data-Point-k (from Testing-Device)     |
    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |   Reference-Device-Probabilities-for-each-Testing-Device-DataPoint   |                                            |                                            |             |                                            |  
    % |           (probabilities_of_Testing_Device_DataPoins)                |                   p1i                      |                   p2i                      |     ...     |                   pki                      |
    % |              Device-i ( Reference_Device_Label = i )                 |                                            |                                            |             |                                            | 
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

            inputSet.parse(varargin{:});

            probabilities_of_Testing_DataPoins     = inputSet.Results.probabilities_of_Testing_DataPoins;

            % Level 1: Sorting the Input
                probabilities_of_Testing_DataPoins = sort (probabilities_of_Testing_DataPoins);

     %% Section 2: Formation of 'Thresholds' through using Median
        % Level 1: Formation of Median Values of 'Probabilities
            temp_Probabilities_of_Testing_DataPoins = unique ( probabilities_of_Testing_DataPoins );
            
            if ( numel ( temp_Probabilities_of_Testing_DataPoins ) > 1 )
                temp = temp_Probabilities_of_Testing_DataPoins ( 1, 1 : end - 1 ) + temp_Probabilities_of_Testing_DataPoins ( 1, 2 : end );
                median_Values                           = temp / 2;
                
            else
                median_Values = [];
                
            end
                        
        % Level 2: Formation of 'Thresholds'
            minimum_Probability = min ( probabilities_of_Testing_DataPoins );
            maximum_Probability = max ( probabilities_of_Testing_DataPoins );
            thresholds = [ minimum_Probability-.0001 median_Values maximum_Probability+.0001 ];      

     %% Section 3: Extraction of 'False-Negative-Rate' 
        % Level 1: Finding 'False Negative numbers'
            for threshold_Index = 1 : numel ( thresholds )
                number_of_False_Negative_Cases_of_Classifications_for_each_thresholds( 1, threshold_Index ) = sum ( probabilities_of_Testing_DataPoins >= thresholds( 1, threshold_Index ) );
                
            end

        % Level 2: Number of 'Testing Data-Points' 
            number_of_Testing_Data_Points = numel ( probabilities_of_Testing_DataPoins );
        
        % Level 3: Finding 'False Negative Rate'
            false_Negative_Rates_of_Classifications_for_all_Thresholds = ( number_of_False_Negative_Cases_of_Classifications_for_each_thresholds)/ number_of_Testing_Data_Points;
        
     %% Section 4: Output           
        % Level 1: 'Thresholds'
            output. thresholds_for_True_or_False_Negative_Rates = thresholds;
            
        % Level 2: 'False Negative Rates'
            output. false_Negative_Rates_of_Classifications_for_all_Thresholds = false_Negative_Rates_of_Classifications_for_all_Thresholds;

end