function output = False_Positive_Rate_Calculator_for_One_Reference_Device ( varargin )

    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |                                                                        |     Data-Point-1 (from Reference-Device)     |     Data-Point-2 (from Reference-Device)     |     ...     |     Data-Point-k (from Reference-Device)     |
    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % |   Reference-Device-Probabilities-for-each-Reference-Device-DataPoint   |                                            |                                            |             |                                            |  
    % |           (probabilities_of_Reference_Device_DataPoins)                |                   p1i                      |                   p2i                      |     ...     |                   pki                      |
    % |              Device-i ( Reference_Device_Index = i )                   |                                            |                                            |             |                                            | 
    % |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % 
    % pji: Probability that ReferenceDevice-DataPoint-j belongs to the Reference-Device-i
    %
    %
    % Reference Device:                       'Negative Device = Known Device'
    
     %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            
            inputSet.addParameter('true_Labels_of_Reference_DataPoints', []);
            inputSet.addParameter('probabilities_of_Reference_DataPoints', []);            

            inputSet.parse(varargin{:});

            true_Labels_of_Reference_DataPoints         = inputSet.Results.true_Labels_of_Reference_DataPoints;
            probabilities_of_Reference_DataPoints       = inputSet.Results.probabilities_of_Reference_DataPoints;

            % Level 1: Sorting the Input
                [ probabilities_of_Reference_DataPoints, sorting_Indices_of_probabilities_of_Reference_DataPoints ] = sort ( probabilities_of_Reference_DataPoints );
                true_Labels_of_Reference_DataPoints                                                               = true_Labels_of_Reference_DataPoints (1, sorting_Indices_of_probabilities_of_Reference_DataPoints);            

     %% Section 2: Formation of 'Thresholds' through using Median
        % Level 1: Formation of Median Values of 'Probabilities
            temp_probabilities_of_Reference_DataPoints = unique ( probabilities_of_Reference_DataPoints );
            
            if ( numel ( temp_probabilities_of_Reference_DataPoints ) > 1 )
                temp = temp_probabilities_of_Reference_DataPoints ( 1, 1 : end - 1 ) + temp_probabilities_of_Reference_DataPoints ( 1, 2 : end );
                median_Values                           = temp / 2;
                
            else
                median_Values = [];
                
            end
                        
        % Level 2: Formation of 'Thresholds'
            minimum_Probability = min ( probabilities_of_Reference_DataPoints );
            maximum_Probability = max ( probabilities_of_Reference_DataPoints );
            thresholds = [ minimum_Probability-.0001 median_Values maximum_Probability+.0001 ];      

     %% Section 3: Extraction of 'False-Positive-Rate' 
        % Level 1: Finding 'False Positive numbers'
            for threshold_Index = 1 : numel ( thresholds )
                number_of_False_Positive_Cases_of_Classifications_for_each_thresholds( 1, threshold_Index ) = sum ( probabilities_of_Reference_DataPoints < thresholds( 1, threshold_Index ) );
                
            end

        % Level 2: Number of 'Reference Data-Points' 
            number_of_Reference_Data_Points = numel ( probabilities_of_Reference_DataPoints );
        
        % Level 3: Finding 'False Positive Rate'
            false_Positive_Rates_of_Classifications_for_all_Thresholds = ( number_of_False_Positive_Cases_of_Classifications_for_each_thresholds)/ number_of_Reference_Data_Points;
        
     %% Section 4: Output           
        % Level 1: 'Thresholds'
            output. thresholds_for_True_or_False_Positive_Rates = thresholds;
            
        % Level 2: 'False Positive Rates'
            output. false_Positive_Rates_of_Classifications_for_all_Thresholds = false_Positive_Rates_of_Classifications_for_all_Thresholds;
             
end