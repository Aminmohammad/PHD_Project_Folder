function inputs_for_classifier = Input_Provider_for_Classifier ( varargin )


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
            
            inputSet.addParameter('Saving_Address', []); 

            inputSet.addParameter('training_Percentage', [] ); 
            inputSet.addParameter('validation_Percentage', [] ); 
            inputSet.addParameter('test_Percentage', [] ); 
            
            inputSet.addParameter('application_or_Training', [] );
            inputSet.addParameter('selected_Model_Address_for_Application', []);
            inputSet.addParameter('number_of_Devices_in_the_Original_DataBank', []);
            inputSet.addParameter('selected_Devices_Indices_for_Application', []);                        
            
            inputSet.addParameter( 'do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices', 0 );
            
            inputSet.addParameter('selected_Devices_for_Training', [] );
            inputSet.addParameter('selected_Devices_for_Validation', [] );
            inputSet.addParameter('selected_Devices_for_Test', [] );
            
            inputSet.addParameter('general_PlotTitle', []);
            
            inputSet.parse(varargin{:});

            input_DataPoints_Matrix                                      = inputSet.Results.input_DataPoints_Matrix;
            classLabels_from_DataBank                                    = inputSet.Results.classLabels_from_DataBank;
            
            Saving_Address                                               = inputSet.Results.Saving_Address;
            
            training_Percentage                                          = inputSet.Results.training_Percentage;

            test_Percentage                                              = inputSet.Results.test_Percentage;                                 

            application_or_Training                                      = inputSet.Results.application_or_Training;
            selected_Model_Address_for_Application                       = inputSet.Results.selected_Model_Address_for_Application;
            number_of_Devices_in_the_Original_DataBank                   = inputSet.Results.number_of_Devices_in_the_Original_DataBank;
            selected_Devices_Indices_for_Application                     = inputSet.Results.selected_Devices_Indices_for_Application;
           
            do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices = inputSet.Results.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices;
            selected_Devices_for_Training                                = inputSet.Results.selected_Devices_for_Training;
            selected_Devices_for_Test                                    = inputSet.Results.selected_Devices_for_Test;

            if        ( isempty( input_DataPoints_Matrix ) == 1 )        
                error ( 'You should Enter the "input_DataPoints_Matrix" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels_from_DataBank" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );
                
            elseif    ( isempty( application_or_Training ) == 1 )        
                error ( 'You should Enter the "application_or_Training" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );                    

            elseif    ( strcmp( application_or_Training, 'Application' ) == 1 ) && ( isempty( selected_Model_Address_for_Application ) == 1 )        
                error ( 'You should Enter the "selected_Model_Address_for_Application" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );                    
    
            elseif    ( do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices == 1 )
                 
                if     ( isempty ( selected_Devices_for_Training ) == 1 )
                     error ( 'You Selected to Use Specific Devies for Training, but You did not enter the "selected_Devices_for_Training" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );                    
    
                elseif ( isempty ( selected_Devices_for_Test ) == 1 )
                    error ( 'You Selected to Use Specific Devies for Training, but You did not enter the "selected_Devices_for_Test" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );                    
    
                end
            end                                        
                 
    %% Section 2: Producing the Inputs for Classification
       % Level 1: Normalization
            number_of_DataPoints_Dimensions  = size( input_DataPoints_Matrix, 1 );
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );
       
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
            
            normalized_DataPoints  = normalized_DataPoints';
            normalized_ClassLabels = normalized_ClassLabels';

        % Level 2: Dividing the Data to the 'Training' and 'Testing' Groups 
            temp = [];
            if ( strcmp ( application_or_Training, 'Training' ) == 1 )                

                if    ( do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices == 0 )
                    number_of_DataPoints                = numel ( normalized_ClassLabels );
                    training_Indices                    = randperm ( number_of_DataPoints, floor ( training_Percentage * number_of_DataPoints ) );
                    training_Indices                    = sort ( training_Indices );

                    training_Inputs                     = normalized_DataPoints  ( training_Indices, : );
                    training_Targets                    = normalized_ClassLabels ( training_Indices, : );                    
                    classLabels_from_DataBank_for_Train = classLabels_from_DataBank ( :, training_Indices  );

                    testing_Indices                     = setdiff ( 1 : number_of_DataPoints, training_Indices );
                    testing_Inputs                      = normalized_DataPoints  ( testing_Indices, : );                   
                    classLabels_from_DataBank_for_Test  = classLabels_from_DataBank ( :, testing_Indices  ); 
                    
                    temp_Training_Indices                         = zeros ( 1, numel ( normalized_ClassLabels ) );
                    temp_Training_Indices ( 1, training_Indices ) = 1;   
                    
                    temp_Testing_Indices                          = zeros ( 1, numel ( normalized_ClassLabels ) );
                    temp_Testing_Indices ( 1, testing_Indices )   = 1;
                    
                    selected_Indices_of_Devices_for_Training_among_all_Devies = temp_Training_Indices;
                    selected_Indices_of_Devices_for_Testing_among_all_Devies  = temp_Testing_Indices;
                    
                    selected_Devices_for_Training = unique ( classLabels_from_DataBank_for_Train );
                    selected_Devices_for_Test     = unique ( classLabels_from_DataBank_for_Test );
                    
                    % Following two lines should be ath the end of this part
                        training_Indices = ones ( 1, numel ( training_Indices ) );
                        testing_Indices  = ones ( 1, numel ( testing_Indices ) );
                    
                elseif ( do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices == 1 )

                    % Training "Indices", "Inputs", and "Targets"
                        indices = zeros( 1, size( classLabels_from_DataBank, 2 ) );
                        for selected_Training_Device_Index = 1 : numel ( selected_Devices_for_Training )
                            indices_of_Current_Selected_Devices_for_Training_Set = ( classLabels_from_DataBank ==  selected_Devices_for_Training ( 1, selected_Training_Device_Index ) );
                            indices                                              = indices + indices_of_Current_Selected_Devices_for_Training_Set;

                        end
                        temp_Training_Indices                  = logical ( indices );
                        
                        temp_1                                 = normalized_DataPoints  ( temp_Training_Indices, : );
                        temp_2                                 = normalized_ClassLabels  ( temp_Training_Indices, : );                        
                        temp_3                                 = classLabels_from_DataBank ( :, temp_Training_Indices );

                        training_Indices                       = logical ( 1 : size ( temp_2, 1 ) );                                             
                        number_of_DataPoints                   = sum ( training_Indices );

                        selected_Indices_from_Training_Indices = randperm ( number_of_DataPoints, floor ( training_Percentage * number_of_DataPoints ) );

                        training_Indices ( 1, setdiff ( 1 : sum(training_Indices), selected_Indices_from_Training_Indices ) ) = 0;

                        training_Inputs                     = temp_1  ( training_Indices, : );
                        training_Targets                    = temp_2  ( training_Indices, : );
                        classLabels_from_DataBank_for_Train = temp_3  ( :, training_Indices );
                        
                        temp_Training_Indices (1, temp_Training_Indices == 1 )    = training_Indices;
                        selected_Indices_of_Devices_for_Training_among_all_Devies = temp_Training_Indices;

                    % Testing "Indices", "Inputs", and "Targets"
                        indices = zeros( 1, size( classLabels_from_DataBank, 2 ) );
                        for selected_Test_Device_Index = 1 : numel ( selected_Devices_for_Test )
                            indices_of_Current_Selected_Devices_for_Test_Set        = ( classLabels_from_DataBank ==  selected_Devices_for_Test ( 1, selected_Test_Device_Index ) );
                            indices = indices + indices_of_Current_Selected_Devices_for_Test_Set;

                        end
                     
                        temp_Testing_Indices                   = logical ( indices );
                        temp_1                                 = normalized_DataPoints  ( temp_Testing_Indices, : );
                        temp_2                                 = normalized_ClassLabels  ( temp_Testing_Indices, : );                        
                        temp_3                                 = classLabels_from_DataBank ( :, temp_Testing_Indices );

                        testing_Indices                        = logical ( 1 : size ( temp_2, 1 ) );                                             
                        number_of_DataPoints                   = sum ( testing_Indices );
                        selected_Indices_from_Testing_Indices  = randperm ( number_of_DataPoints, floor ( test_Percentage * number_of_DataPoints ) );

                        testing_Indices ( 1, setdiff ( 1 : sum(testing_Indices), selected_Indices_from_Testing_Indices ) ) = 0;

                        testing_Inputs                     = temp_1  ( testing_Indices, : );
                        classLabels_from_DataBank_for_Test = temp_3  ( :, testing_Indices );
                        
                        temp_Testing_Indices (1, temp_Testing_Indices == 1 )     = testing_Indices;
                        selected_Indices_of_Devices_for_Testing_among_all_Devies = temp_Testing_Indices;                                                      
 
                end
                
                temp = { 'training_Inputs',  training_Inputs, ...
                         'training_Targets', training_Targets, ...
                         'classLabels_from_DataBank_for_Train', classLabels_from_DataBank_for_Train, ...
                         };
                
               % Extracting Essential Information for "Index Plot"
                   % Training Indices Information
                       total_Number_of_all_Datapoints_of_Training_Devices = 0;
                       for index = 1 : numel ( selected_Devices_for_Training )
                           current_Training_Device = selected_Devices_for_Training ( 1, index ) ;
                           total_Number_of_all_Datapoints_of_Training_Devices = total_Number_of_all_Datapoints_of_Training_Devices + sum ( classLabels_from_DataBank == current_Training_Device );

                       end
                        
                       total_Number_of_Training_Datapoints                                                                  =  sum (training_Indices);  
                       percentage_of_Total_Number_of_Training_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank =  ( total_Number_of_Training_Datapoints / numel ( classLabels_from_DataBank ) ) * 100;                        
                       percentage_of_total_Number_of_Training_Datapoints_based_on_all_DataPoints_of_Training_Devices        =  ( total_Number_of_Training_Datapoints / total_Number_of_all_Datapoints_of_Training_Devices ) * 100;                        
                       excluded_Devices_from_Training                                                                       =  setdiff ( unique ( classLabels_from_DataBank ), selected_Devices_for_Training );

                       unique_Indices_of_selected_Deviecs_for_Training = unique ( classLabels_from_DataBank_for_Train );
                       for index = 1 : numel ( unique_Indices_of_selected_Deviecs_for_Training )
                           number_of_Selected_DataPoints_for_each_of_Devices_for_Training ( 1, index )               = sum ( classLabels_from_DataBank_for_Train == unique_Indices_of_selected_Deviecs_for_Training ( 1, index ) );
                           percentage_of_Number_of_Selected_DataPoints_for_each_of_Training_Devices_based_on_all_DataPoints_of_each_of_Training_Devices ( 1, index ) = ( number_of_Selected_DataPoints_for_each_of_Devices_for_Training ( 1, index ) ...
                                                                                                                                                                         / sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Training ( 1, index ) ) ) * 100 ;
                                                                                                                                                                     
                           number_of_DataPoints_of_each_of_Training_Devices ( 1, index ) =  sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Training ( 1, index ) );                                                                                                                                                                   

                       end

                   % Testing Indices Information
                       total_Number_of_all_Datapoints_of_Testing_Devices = 0;
                       for index = 1 : numel ( selected_Devices_for_Test )
                           current_Testing_Device = selected_Devices_for_Test ( 1, index ) ;
                           total_Number_of_all_Datapoints_of_Testing_Devices = total_Number_of_all_Datapoints_of_Testing_Devices + sum ( classLabels_from_DataBank == current_Testing_Device );

                       end
                        
                       total_Number_of_Testing_Datapoints                                                                  =  sum (testing_Indices);  
                       percentage_of_Total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank =  ( total_Number_of_Testing_Datapoints / numel ( classLabels_from_DataBank ) ) * 100;                        
                       percentage_of_total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_Testing_Devices         =  ( total_Number_of_Testing_Datapoints / total_Number_of_all_Datapoints_of_Testing_Devices ) * 100;                        
                       excluded_Devices_from_Test                                                                          =  setdiff ( unique ( classLabels_from_DataBank ), selected_Devices_for_Test );
                       
                       unique_Indices_of_selected_Deviecs_for_Testing = unique ( classLabels_from_DataBank_for_Test );
                       for index = 1 : numel ( unique_Indices_of_selected_Deviecs_for_Testing )
                           number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, index )               = sum ( classLabels_from_DataBank_for_Test == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) );
                           percentage_of_Number_of_Selected_DataPoints_for_each_of_Testing_Devices_based_on_all_DataPoints_of_each_of_Testing_Devices ( 1, index ) = ( number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, index ) ...
                                                                                                                                                                       / sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) ) ) * 100 ;

                           number_of_DataPoints_of_each_of_Testing_Devices ( 1, index ) =  sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) );                                                                                                                                                                   

                       end
                       
                    % Common/unCommon Indices Information (for Training, Testing, and all)  
                        temp_Selected_Indices_of_Devices_for_Training_among_all_Devies = double ( selected_Indices_of_Devices_for_Training_among_all_Devies );
                        temp_Selected_Indices_of_Devices_for_Testing_among_all_Devies  = double ( selected_Indices_of_Devices_for_Testing_among_all_Devies );

                        for index = 1 : numel ( temp_Selected_Indices_of_Devices_for_Training_among_all_Devies )

                            if     ( temp_Selected_Indices_of_Devices_for_Training_among_all_Devies ( 1, index ) == 0 )
                                temp_Selected_Indices_of_Devices_for_Training_among_all_Devies ( 1, index ) = inf;

                            end

                            if ( temp_Selected_Indices_of_Devices_for_Testing_among_all_Devies ( 1, index ) == 0 )
                                temp_Selected_Indices_of_Devices_for_Testing_among_all_Devies ( 1, index )  = -inf;

                            end

                        end

                        % Common Data_points
                            indices_of_all_DataPoints_Contributed_in_Training_and_Testing = logical ( selected_Indices_of_Devices_for_Training_among_all_Devies + selected_Indices_of_Devices_for_Testing_among_all_Devies );
                            number_of_all_DataPoints_Contributed_in_Training_and_Testing  = sum(indices_of_all_DataPoints_Contributed_in_Training_and_Testing);
                            
                            indices_of_Common_DataPoints_from_Training_and_Testing        = ( temp_Selected_Indices_of_Devices_for_Training_among_all_Devies == temp_Selected_Indices_of_Devices_for_Testing_among_all_Devies );
                            number_of_Common_DataPoints_form_Training_and_Testing         = sum ( indices_of_Common_DataPoints_from_Training_and_Testing );
                            
                            percentage_of_Common_DataPoints_form_Training_and_Testing_with_Respect_to_all_DataPoint_Contributed_in_Training_and_Testing = ( number_of_Common_DataPoints_form_Training_and_Testing / number_of_all_DataPoints_Contributed_in_Training_and_Testing ) * 100;

                            unique_Devices_of_ClassLabels_from_DataBank = unique ( classLabels_from_DataBank );
                            for index = 1 : numel ( unique_Devices_of_ClassLabels_from_DataBank )
                                current_Device = unique_Devices_of_ClassLabels_from_DataBank ( 1, index );

                                indices_of_current_Device = ( classLabels_from_DataBank == current_Device  );


                                number_of_Common_DataPoints_for_each_Device ( 1, index )                                  = sum ( indices_of_Common_DataPoints_from_Training_and_Testing ( 1, indices_of_current_Device ) );

                                number_of_all_DataPoints_for_each_Device_Contributed_in_Training_and_Testing ( 1, index ) = sum ( indices_of_all_DataPoints_Contributed_in_Training_and_Testing ( 1, indices_of_current_Device ) );                                
                                
                                percentage_of_Number_of_Common_DataPoints_for_each_Device_with_Respect_to_summation_of_Training_and_Testing_DataPoints ( 1, index ) = ( number_of_Common_DataPoints_for_each_Device ( 1, index ) ...
                                                                                                                                                                                    / number_of_all_DataPoints_for_each_Device_Contributed_in_Training_and_Testing ( 1, index ) ) * 100;
                                                                                                                                       
                            end                                                

                        % unCommon Data_points (for Training)                       
                            indices_of_unCommon_DataPoints_in_Training                                              = ( indices_of_Common_DataPoints_from_Training_and_Testing ~= selected_Indices_of_Devices_for_Training_among_all_Devies );
                            
                            total_Number_of_unCommon_DataPoints_from_Training                                       = sum ( indices_of_unCommon_DataPoints_in_Training );
                            percentage_of_Number_of_unCommon_DataPoints_from_Training_based_on_Training_DataPoints  = ( total_Number_of_unCommon_DataPoints_from_Training / sum ( selected_Indices_of_Devices_for_Training_among_all_Devies ) ) * 100;

                            unique_Indices_of_selected_Deviecs_for_Training = unique ( classLabels_from_DataBank_for_Train );
                            for index = 1 : numel ( unique_Indices_of_selected_Deviecs_for_Training )
                                current_Device = unique_Indices_of_selected_Deviecs_for_Training ( 1, index );

                                indices_of_current_Device = ( classLabels_from_DataBank == current_Device  );

                                number_of_unCommon_DataPoints_for_Training_for_each_Device ( 1, index )               = sum ( indices_of_unCommon_DataPoints_in_Training ( 1, indices_of_current_Device ) );

                                percentage_of_Number_of_unCommon_DataPoints_for_Training_for_each_Device ( 1, index ) = ( number_of_unCommon_DataPoints_for_Training_for_each_Device ( 1, index ) ...
                                                                                                                           / number_of_Selected_DataPoints_for_each_of_Devices_for_Training ( 1, index ) ) * 100;

                            end
                           
                        % unCommon Data_points (for Testing)
                            indices_of_unCommon_DataPoints_in_Testing                                            = ( indices_of_Common_DataPoints_from_Training_and_Testing ~= selected_Indices_of_Devices_for_Testing_among_all_Devies );

                            total_Number_of_unCommon_DataPoints_from_Testing                                     = sum ( indices_of_unCommon_DataPoints_in_Testing );
                            percentage_of_Number_of_unCommon_DataPoints_from_Testing_based_on_Testing_DataPoints = ( total_Number_of_unCommon_DataPoints_from_Testing / sum ( selected_Indices_of_Devices_for_Testing_among_all_Devies ) ) * 100;

                            unique_Indices_of_selected_Deviecs_for_Testing = unique ( classLabels_from_DataBank_for_Test );
                            for index = 1 : numel ( unique_Indices_of_selected_Deviecs_for_Testing )
                                current_Device = unique_Indices_of_selected_Deviecs_for_Testing ( 1, index );

                                indices_of_current_Device = ( classLabels_from_DataBank == current_Device  );

                                number_of_unCommon_DataPoints_for_Testing_for_each_Device ( 1, index )               = sum ( indices_of_unCommon_DataPoints_in_Testing( 1, indices_of_current_Device ) );

                                percentage_of_Number_of_unCommon_DataPoints_for_Testing_for_each_Device ( 1, index ) = ( number_of_unCommon_DataPoints_for_Testing_for_each_Device ( 1, index ) ...
                                                                                                                           / number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, index ) ) * 100;

                            end                             
                        
                    % Text of Indices Information                        
                        text_Training_1 = sprintf ( 'Data-Bank Devices = [ %s] & Training Devices = [ %s] & Excluded Devices = [ %s].', sprintf( '%d ', unique ( classLabels_from_DataBank ) ), sprintf ( '%d ', selected_Devices_for_Training ), sprintf ( '%d ', excluded_Devices_from_Training ) );
                        text_Training_2 = sprintf ( 'Training Percentage = %2.2f%% of all Data-Points of Training Devices.', training_Percentage * 100 );
                        text_Training_3 = sprintf ( 'No. of Selected Data-Points for Training = %d (%2.2f%% of all Data-Points of all Data-Bank Devices (%d Data-Points)),', total_Number_of_Training_Datapoints, percentage_of_Total_Number_of_Training_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank, numel ( classLabels_from_DataBank ) );
                        text_Training_4 = sprintf ( '(%2.2f%% of all Data-Points of Training Devices (%d Data-Pints)). ', percentage_of_total_Number_of_Training_Datapoints_based_on_all_DataPoints_of_Training_Devices, total_Number_of_all_Datapoints_of_Training_Devices );
                        text_Training   = sprintf ( '%s\n%s\n%s\n%s', text_Training_1, text_Training_2, text_Training_3, text_Training_4 );

                        text_Testing_1 = sprintf ( 'Data-Bank Devices = [ %s]  & Testing Devices = [ %s] & Excluded Devices = [ %s].', sprintf( '%d ', unique ( classLabels_from_DataBank ) ), sprintf ( '%d ', selected_Devices_for_Test ), sprintf ( '%d ', excluded_Devices_from_Test ) );
                        text_Testing_2 = sprintf ( 'Testing Percentage = %2.2f%% of all Data-Points of Testing Devices.', test_Percentage * 100 );
                        text_Testing_3 = sprintf ( 'No. of Selected Data-Points for Testing = %d (%2.2f%% of all Data-Points of all Data-Bank Devices (%d Data-Points)),', total_Number_of_Testing_Datapoints, percentage_of_Total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank, numel ( classLabels_from_DataBank ) );
                        text_Testing_4 = sprintf ( '(%2.2f%% of all Data-Points of Testing Devices (%d Data-points)). ', percentage_of_total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_Testing_Devices, total_Number_of_all_Datapoints_of_Testing_Devices );
                        text_Testing   = sprintf ( '%s\n%s\n%s\n%s', text_Testing_1, text_Testing_2, text_Testing_3, text_Testing_4 );

                        text_unCommon_Training_1 = sprintf ( 'Training Devices = [ %s] & Excluded Devices = [ %s].', sprintf ( '%d ', selected_Devices_for_Training ), sprintf ( '%d ', excluded_Devices_from_Training ) );
                        text_unCommon_Training_2 = sprintf ( 'No. of Unique Selected Data-Points for Training, not Included in Testing = %d (%2.2f%% of all Training Data-Points of Training Devices (%d Data-Points)).', total_Number_of_unCommon_DataPoints_from_Training, percentage_of_Number_of_unCommon_DataPoints_from_Training_based_on_Training_DataPoints, total_Number_of_Training_Datapoints );
                        text_unCommon_Training   = sprintf ( '%s\n%s', text_unCommon_Training_1, text_unCommon_Training_2 );

                        text_unCommon_Testing_1  = sprintf ( 'Testing Devices = [ %s] & Excluded Devices = [ %s].', sprintf ( '%d ', selected_Devices_for_Test ), sprintf ( '%d ', excluded_Devices_from_Test ) );
                        text_unCommon_Testing_2  = sprintf ( 'No. of Unique Selected Data-Points for Testing, not Included in Training = %d (%2.2f%% of all Testing Data-Points of Testing Devices (%d Data-Points)).', total_Number_of_unCommon_DataPoints_from_Testing, percentage_of_Number_of_unCommon_DataPoints_from_Testing_based_on_Testing_DataPoints, total_Number_of_Testing_Datapoints );
                        text_unCommon_Testing    = sprintf ( '%s\n%s', text_unCommon_Testing_1, text_unCommon_Testing_2 );
                        
                        text_Common_1 = sprintf ( 'Training Devices = [ %s] & Excluded Devices = [ %s].', sprintf ( '%d ', selected_Devices_for_Training ), sprintf ( '%d ', excluded_Devices_from_Training ) );
                        text_Common_2 = sprintf ( 'Testing Devices = [ %s] & Excluded Devices = [ %s].', sprintf ( '%d ', selected_Devices_for_Test ), sprintf ( '%d ', excluded_Devices_from_Test ) );
                        text_Common_3 = sprintf ( 'No. of Common Selected Data-Points for Training & Testing = %d (%2.2f%% of all Training & Testing Data-Points of Training & Testing Devices (%d Data-Points)).', number_of_Common_DataPoints_form_Training_and_Testing, percentage_of_Common_DataPoints_form_Training_and_Testing_with_Respect_to_all_DataPoint_Contributed_in_Training_and_Testing, number_of_all_DataPoints_Contributed_in_Training_and_Testing );
                        text_Common   = sprintf ( '%s\n%s\n%s', text_Common_1, text_Common_2, text_Common_3 );

            elseif ( strcmp ( application_or_Training, 'Application' ) == 1 )
                
                % Level 1: Reduction of Devices for the case of "Application"      
                    temp_DataPoints  = [];
                    temp_ClassLabels = [];
                    temp_ClassLabels_from_DataBank_for_Test = [];
                    testing_Indices = zeros ( 1, numel ( classLabels_from_DataBank ) );
                    for selected_DeviceLabel_Index = 1 : numel ( selected_Devices_Indices_for_Application )
                        crrent_Selected_DeviceLabel = selected_Devices_Indices_for_Application ( 1, selected_DeviceLabel_Index );

                        temp_Indices = ( classLabels_from_DataBank == crrent_Selected_DeviceLabel );

                        temp_DataPoints  = [ temp_DataPoints; normalized_DataPoints(temp_Indices, :) ];
                        temp_ClassLabels = [ temp_ClassLabels; normalized_ClassLabels(temp_Indices, :) ];
                        temp_ClassLabels_from_DataBank_for_Test = [ temp_ClassLabels_from_DataBank_for_Test classLabels_from_DataBank( :, temp_Indices ) ];
                        
                        testing_Indices = testing_Indices + temp_Indices;

                    end
                selected_Indices_of_Devices_for_Testing_among_all_Devies = testing_Indices;
                testing_Inputs                                           = temp_DataPoints;

                classLabels_from_DataBank_for_Test = temp_ClassLabels_from_DataBank_for_Test;
                selected_Devices_for_Test = unique (temp_ClassLabels_from_DataBank_for_Test);
                
                % Level 2: Testing Indices Information
                   total_Number_of_all_Datapoints_of_Testing_Devices = 0;
                   for index = 1 : numel ( selected_Devices_for_Test )
                       current_Testing_Device = selected_Devices_for_Test ( 1, index ) ;
                       total_Number_of_all_Datapoints_of_Testing_Devices = total_Number_of_all_Datapoints_of_Testing_Devices + sum ( classLabels_from_DataBank == current_Testing_Device );

                   end

                   total_Number_of_Testing_Datapoints                                                                  =  sum (testing_Indices);  
                   percentage_of_Total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank =  ( total_Number_of_Testing_Datapoints / numel ( classLabels_from_DataBank ) ) * 100;                        
                   percentage_of_total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_Testing_Devices         =  ( total_Number_of_Testing_Datapoints / total_Number_of_all_Datapoints_of_Testing_Devices ) * 100;                        
                   excluded_Devices_from_Test                                                                          =  setdiff ( unique ( classLabels_from_DataBank ), selected_Devices_for_Test );

                   unique_Indices_of_selected_Deviecs_for_Testing = unique ( classLabels_from_DataBank_for_Test );
                   for index = 1 : numel ( unique_Indices_of_selected_Deviecs_for_Testing )
                       number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, index )               = sum ( classLabels_from_DataBank_for_Test == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) );
                       percentage_of_Number_of_Selected_DataPoints_for_each_of_Testing_Devices_based_on_all_DataPoints_of_each_of_Testing_Devices ( 1, index ) = ( number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, index ) ...
                                                                                                                                                                   / sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) ) ) * 100 ;

                       number_of_DataPoints_of_each_of_Testing_Devices ( 1, index ) =  sum ( classLabels_from_DataBank == unique_Indices_of_selected_Deviecs_for_Testing ( 1, index ) );                                                                                                                                                                   

                   end
           
               % Level 3: Text of Indices Information
                    text_Testing_1 = sprintf ( 'Data-Bank Devices = [ %s]  & Testing Devices = [ %s] & Excluded Devices = [ %s].', sprintf( '%d ', unique ( classLabels_from_DataBank ) ), sprintf ( '%d ', selected_Devices_for_Test ), sprintf ( '%d ', excluded_Devices_from_Test ) );
                    text_Testing_2 = sprintf ( 'No. of Selected Data-Points for Testing = %d (%2.2f%% of all Data-Points of all Data-Bank Devices (%d Data-Points)),', total_Number_of_Testing_Datapoints, percentage_of_Total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_all_Devices_in_DataBank, numel ( classLabels_from_DataBank ) );
                    text_Testing_3 = sprintf ( '(%2.2f%% of all Data-Points of Testing Devices (%d Data-points)). ', percentage_of_total_Number_of_Testing_Datapoints_based_on_all_DataPoints_of_Testing_Devices, total_Number_of_all_Datapoints_of_Testing_Devices );
                    text_Testing   = sprintf ( '%s\n%s\n%s\n%s', text_Testing_1, text_Testing_2, text_Testing_3 );

            end
            
            temp = [ temp, { 'testing_Inputs', testing_Inputs } ];
             
    %% Section 3: Drawing the "Selected Indices" for "Training" and/or "Testing"
        if     ( strcmp ( application_or_Training, 'Training' ) == 1 )
            figure('Name', 'All Training and Testing Data-Points for Classification', 'NumberTitle', 'off')  

        elseif ( strcmp ( application_or_Training, 'Application' ) == 1 )
            figure('Name', 'All Testing Data-Points for Classification', 'NumberTitle', 'off')  

        end
        
        % Making Margins Disapear
            make_it_tight = true;
            gap_between_subPlots = 0.05;
            margin_Bottom = 0.05;
            margin_Top    = 0.01;
            margin_Left   = 0.01;
            margin_Right  = 0.01;
            subplot = @(m,n,p) subtightplot (m, n, p, [gap_between_subPlots 0.05], [margin_Bottom margin_Top], [margin_Left margin_Right]);
            if ~make_it_tight,  clear subplot;  end

        set(findall( gcf,'-property', 'FontSize' ),'FontSize', 12 )
        markerSize = 7;
        rate_of_Demonstration_for_X = 30;  
        each_Class_TextFontSize  = 10;
        each_Plot_TextFontSize   = each_Class_TextFontSize + 1;
        vertical_Offset_of_Text  = .5;
        
        % SubPlot ( 3, 1, 1 ) >> Just for 'Training_or_Application == Training'   >>>>>>>>>>> 'Training Indices'
            if     ( strcmp ( application_or_Training, 'Training' ) == 1 ) 
                subplot (3, 1, 1)  
                
                % Plotting Graph
                    for index = 1 : size ( classLabels_from_DataBank, 2 )                   
                        if ( selected_Indices_of_Devices_for_Training_among_all_Devies ( 1, index ) == 1 )
                            plot ( index, classLabels_from_DataBank ( 1, index ), 'r*', 'DisplayName', 'Training Data-Points', 'MarkerSize', markerSize );
                            hold on;                                                

                        end                                        

                    end
                
                % Showing Infos. for each Device
                    unique_Device_Labels = unique ( classLabels_from_DataBank );
                    temp_Index = 1;
                    for index = 1 : numel ( unique_Device_Labels )
                    	temporary = find ( classLabels_from_DataBank == unique_Device_Labels ( 1, index ) );
                        temp_Starting_Index_of_DataPoints_of_Current_Device = temporary ( 1, 1 );
                        temp_Ending_Index_of_DataPoints_of_Current_Device   = temporary ( 1, end );
                        
                        current_part_of_Selected_DeviceLabels_for_Training = selected_Indices_of_Devices_for_Training_among_all_Devies ( 1, temp_Starting_Index_of_DataPoints_of_Current_Device : temp_Ending_Index_of_DataPoints_of_Current_Device );
                        
                        if     ( index ~= numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index + vertical_Offset_of_Text;
                            
                        elseif ( index == numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index - vertical_Offset_of_Text;
                            
                        end

                        if ( sum ( current_part_of_Selected_DeviceLabels_for_Training ) > 1 )
                            Text_1 = sprintf ( 'No. of Selected Data-Points for Training for Device %d = %d,', unique_Device_Labels ( 1, index ), number_of_Selected_DataPoints_for_each_of_Devices_for_Training ( 1, temp_Index ) );
                            Text_2 = sprintf ( '          (%2.2f%% of all Data-Points for this Device (%d Data-Points)).', percentage_of_Number_of_Selected_DataPoints_for_each_of_Training_Devices ( 1, temp_Index ), number_of_DataPoints_of_each_of_Training_Devices ( 1, temp_Index ) );
                            Text = sprintf ( '%s\n%s', Text_1, Text_2 );

                            t = text ( temp_Starting_Index_of_DataPoints_of_Current_Device, vertical_Position_of_Text, Text );
                            t.FontSize = each_Class_TextFontSize;
                            temp_Index = temp_Index + 1;
                            
                        end
                    end
                  
                % Showing Infos. for Whole Plot                    
                    set(gca,'XLim', [ 1   length( classLabels_from_DataBank ) ] )
                    demonstrating_X_Labels = unique( floor ( (  1 : length( classLabels_from_DataBank ) ) / rate_of_Demonstration_for_X ) + 1 ) * rate_of_Demonstration_for_X;
                    set(gca,'XTick', demonstrating_X_Labels )
                    set(gca,'XTickLabels', '' )
                    set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                    set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                    ylabel('ClassLabels')
                    textLoc( text_Training, 'SouthEast', 'edgecolor', 'black', 'fontsize', each_Plot_TextFontSize )
                    title ( 'Indices of Training Data-Points' )
                    hold off;                
                    grid on;
                
            end
            
        % SubPlot ( 3, 1, 2 ) or "simple Figure"   >>>>>>>>>>> 'Testing Indices' 
            % determination of 'subPlot Index'
                if     ( strcmp ( application_or_Training, 'Training' ) == 1 ) 
                    subplot (3, 1, 2) 

                elseif ( strcmp ( application_or_Training, 'Application' ) == 1 )
                    % Nothing

                end
                
            % Plotting Graph                
                for index = 1 : size ( classLabels_from_DataBank, 2 )                   
                    if ( selected_Indices_of_Devices_for_Testing_among_all_Devies ( 1, index ) == 1 )
                        plot ( index, classLabels_from_DataBank ( 1, index ), 'bo', 'DisplayName', 'Testing Data-Points', 'MarkerSize', markerSize );
                        hold on;

                    end

                end

            % Showing Infos. for each Device
                unique_Device_Labels = unique ( classLabels_from_DataBank );
                temp_Index = 1;
                for index = 1 : numel ( unique_Device_Labels )
                    temporary = find ( classLabels_from_DataBank == unique_Device_Labels ( 1, index ) );
                    temp_Starting_Index_of_DataPoints_of_Current_Device = temporary ( 1, 1 );
                    temp_Ending_Index_of_DataPoints_of_Current_Device   = temporary ( 1, end );

                    current_part_of_Selected_DeviceLabels_for_Testing = selected_Indices_of_Devices_for_Testing_among_all_Devies ( 1, temp_Starting_Index_of_DataPoints_of_Current_Device : temp_Ending_Index_of_DataPoints_of_Current_Device );

                    if     ( index ~= numel ( unique_Device_Labels ) )
                        vertical_Position_of_Text   = index + vertical_Offset_of_Text;
                            
                    elseif ( index == numel ( unique_Device_Labels ) )
                        vertical_Position_of_Text   = index - vertical_Offset_of_Text;

                    end

                    if ( sum ( current_part_of_Selected_DeviceLabels_for_Testing ) > 1 )
                        Text_1 = sprintf ( 'No. of Selected Data-Points for Testing for Device %d = %d,', unique_Device_Labels ( 1, index ), number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, temp_Index ) );
                        Text_2 = sprintf ( '          (%2.2f%% of all Data-Points for this Device (%d Data-Points)).', percentage_of_Number_of_Selected_DataPoints_for_each_of_Testing_Devices ( 1, temp_Index ), number_of_DataPoints_of_each_of_Testing_Devices ( 1, temp_Index )  );
                        Text = sprintf ( '%s\n%s', Text_1, Text_2 );

                        t = text ( temp_Starting_Index_of_DataPoints_of_Current_Device, vertical_Position_of_Text, Text );
                        t.FontSize = each_Class_TextFontSize;
                        temp_Index = temp_Index + 1;

                    end
                end
                  
            % Showing Infos. for Whole Plot                 
                set(gca,'XLim', [ 1   length( classLabels_from_DataBank ) ] )
                demonstrating_X_Labels = unique( floor ( (  1 : length( classLabels_from_DataBank ) ) / rate_of_Demonstration_for_X ) + 1 ) * rate_of_Demonstration_for_X;
                set(gca,'XTick', demonstrating_X_Labels )
                if     ( strcmp ( application_or_Training, 'Training' ) == 1 ) 
                    set(gca,'XTickLabels', '' )
                end
                set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                if     ( strcmp ( application_or_Training, 'Application' ) == 1 ) 
                    xlabel('Data-Points Indices')
                    
                end                
                ylabel('ClassLabels')
                textLoc( text_Testing, 'SouthEast', 'edgecolor', 'black', 'fontsize', each_Plot_TextFontSize )
                title ( 'Indices of Testing Data-Points' )
                hold off;
                grid on;                  
            
        % SubPlot ( 3, 1, 3 ) >> Just for 'Training_or_Application == Training'    >>>>>>>>>>> 'Showing Training and Testing Indices in One Figure'
            if ( strcmp ( application_or_Training, 'Training' ) == 1 ) 
                for index = 1 : size ( classLabels_from_DataBank, 2 ) 

                    subplot (3, 1, 3)
                    
                    % Plotting Graph 1 (Training Data-Points)                     
                        if ( selected_Indices_of_Devices_for_Training_among_all_Devies ( 1, index ) == 1 )
                            h ( 1, 1 ) = plot ( index, classLabels_from_DataBank ( 1, index ), 'r*', 'DisplayName', 'Training Data-Points Indices', 'MarkerSize', markerSize );
                            hold on;

                        end

                    % Plotting Graph 1 (Testing Data-Points)                          
                        if ( selected_Indices_of_Devices_for_Testing_among_all_Devies ( 1, index ) == 1 )
                            h ( 1, 2 ) = plot ( index, classLabels_from_DataBank ( 1, index ), 'bo', 'DisplayName', 'Testing Data-Points Indices', 'MarkerSize', markerSize );
                            hold on;

                        end

                end
                
                % Showing Infos. for Whole Plot                 
                    set(gca,'XLim', [ 1   size( classLabels_from_DataBank, 2 ) ] )

                    set(gca,'XTick', demonstrating_X_Labels )
                    set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                    set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                    xlabel('Data-Points Indices')
                    ylabel('ClassLabels')
                    legend ( h, 'Location', 'Best' )
                    title ( 'Indices of Training and Testing Data-Points' )
                    hold off;
                    grid on;

            end 
            
        % Setting the current Figure Invisible              
            set (gcf, 'Visible', 'off')
            
    %% Section 4: Drawing the "Common/unCommon Indices" for "Training" and/or "Testing"  

        if ( strcmp ( application_or_Training, 'Training' ) == 1 )
            
            figure('Name', 'Common/Uncommon Training and Testing Data-Points for Classification', 'NumberTitle', 'off')  

            % Making Margins Disapear
                make_it_tight = true;
            gap_between_subPlots = 0.05;
            margin_Bottom = 0.05;
            margin_Top    = 0.01;
            margin_Left   = 0.01;
            margin_Right  = 0.01;
                subplot = @(m,n,p) subtightplot (m, n, p, [gap_between_subPlots 0.05], [margin_Bottom margin_Top], [margin_Left margin_Right]);
                if ~make_it_tight,  clear subplot;  end

            set(findall( gcf,'-property', 'FontSize' ),'FontSize', 12 )
            markerSize = 7;
            rate_of_Demonstration_for_X = 30;  
            each_Class_TextFontSize  = 10;
            each_Plot_TextFontSize   = each_Class_TextFontSize + 1;
            vertical_Offset_of_Text  = .5;
        
            % SubPlot ( 3, 1, 1 ) >> Just for 'Training_or_Application == Training'   >>>>>>>>>>> 'unCommon Training Indices'                
                subplot (3, 1, 1)  

                % Plotting Graph
                    for index = 1 : size ( classLabels_from_DataBank, 2 )                   
                        if ( indices_of_unCommon_DataPoints_in_Training ( 1, index ) == 1 )
                            plot ( index, classLabels_from_DataBank ( 1, index ), 'r*', 'DisplayName', 'Training Data-Points', 'MarkerSize', markerSize );
                            hold on;                                                

                        end                                        

                    end
                    
                % Showing Infos. for each Device
                    unique_Device_Labels = unique ( classLabels_from_DataBank );
                    temp_Index = 1;
                    for index = 1 : numel ( unique_Device_Labels )
                        temporary = find ( classLabels_from_DataBank == unique_Device_Labels ( 1, index ) );
                        temp_Starting_Index_of_DataPoints_of_Current_Device = temporary ( 1, 1 );
                        temp_Ending_Index_of_DataPoints_of_Current_Device   = temporary ( 1, end );

                        current_part_of_UnSelected_DeviceLabels_for_Training = indices_of_unCommon_DataPoints_in_Training ( 1, temp_Starting_Index_of_DataPoints_of_Current_Device : temp_Ending_Index_of_DataPoints_of_Current_Device );

                        if     ( index ~= numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index + vertical_Offset_of_Text;

                        elseif ( index == numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index - vertical_Offset_of_Text;

                        end

                        if ( sum ( current_part_of_UnSelected_DeviceLabels_for_Training ) > 1 )
                            Text_1 = sprintf ( 'No. of Unique Selected Data-Points for Training for Device %d = %d,', unique_Device_Labels ( 1, index ), number_of_unCommon_DataPoints_for_Training_for_each_Device ( 1, temp_Index ) );
                            Text_2 = sprintf ( '          (%2.2f%% of Training Data-Points for this Device (%d Data-Points)).', percentage_of_Number_of_unCommon_DataPoints_for_Training_for_each_Device ( 1, temp_Index ), number_of_Selected_DataPoints_for_each_of_Devices_for_Training ( 1, temp_Index ) );
                            Text = sprintf ( '%s\n%s', Text_1, Text_2 );

                            t = text ( temp_Starting_Index_of_DataPoints_of_Current_Device, vertical_Position_of_Text, Text );
                            t.FontSize = each_Class_TextFontSize;
                            temp_Index = temp_Index + 1;

                        end
                    end

                % Showing Infos. for Whole Plot                    
                    set(gca,'XLim', [ 1   length( classLabels_from_DataBank ) ] )
                    demonstrating_X_Labels = unique( floor ( (  1 : length( classLabels_from_DataBank ) ) / rate_of_Demonstration_for_X ) + 1 ) * rate_of_Demonstration_for_X;
                    set(gca,'XTick', demonstrating_X_Labels )
                    set(gca,'XTickLabels', '' )
                    set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                    set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                    ylabel('ClassLabels')
                    textLoc( text_unCommon_Training, 'SouthEast', 'edgecolor', 'black', 'fontsize', each_Plot_TextFontSize )
                    title ( 'Indices of Unique Training Data-Points (not Used in Testing)' )
                    hold off;                
                    grid on;     
                    
            % SubPlot ( 3, 1, 2 ) >> Just for 'Training_or_Application == Training'   >>>>>>>>>>> 'unCommon Testing Indices'                
                subplot (3, 1, 2)  

                % Plotting Graph
                    for index = 1 : size ( classLabels_from_DataBank, 2 )                   
                        if ( indices_of_unCommon_DataPoints_in_Testing ( 1, index ) == 1 )
                            plot ( index, classLabels_from_DataBank ( 1, index ), 'bo', 'DisplayName', 'Training Data-Points', 'MarkerSize', markerSize );
                            hold on;                                                

                        end                                        

                    end
                    
                % Showing Infos. for each Device
                    unique_Device_Labels = unique ( classLabels_from_DataBank );
                    temp_Index = 1;
                    for index = 1 : numel ( unique_Device_Labels )
                        temporary = find ( classLabels_from_DataBank == unique_Device_Labels ( 1, index ) );
                        temp_Starting_Index_of_DataPoints_of_Current_Device = temporary ( 1, 1 );
                        temp_Ending_Index_of_DataPoints_of_Current_Device   = temporary ( 1, end );

                        current_part_of_UnSelected_DeviceLabels_for_Testing = indices_of_unCommon_DataPoints_in_Testing ( 1, temp_Starting_Index_of_DataPoints_of_Current_Device : temp_Ending_Index_of_DataPoints_of_Current_Device );

                        if     ( index ~= numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index + vertical_Offset_of_Text;

                        elseif ( index == numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index - vertical_Offset_of_Text;

                        end

                        if ( sum ( current_part_of_UnSelected_DeviceLabels_for_Testing ) > 1 )
                            Text_1 = sprintf ( 'No. of Unique Selected Data-Points for Testinig for Device %d = %d,', unique_Device_Labels ( 1, index ), number_of_unCommon_DataPoints_for_Testing_for_each_Device ( 1, temp_Index ) );
                            Text_2 = sprintf ( '          (%2.2f%% of Testing Data-Points for this Device (%d Data-Points)).', percentage_of_Number_of_unCommon_DataPoints_for_Testing_for_each_Device ( 1, temp_Index ), number_of_Selected_DataPoints_for_each_of_Devices_for_Testing ( 1, temp_Index ) );
                            Text = sprintf ( '%s\n%s', Text_1, Text_2 );

                            t = text ( temp_Starting_Index_of_DataPoints_of_Current_Device, vertical_Position_of_Text, Text );
                            t.FontSize = each_Class_TextFontSize;
                            temp_Index = temp_Index + 1;

                        end
                    end

                % Showing Infos. for Whole Plot                    
                    set(gca,'XLim', [ 1   length( classLabels_from_DataBank ) ] )
                    demonstrating_X_Labels = unique( floor ( (  1 : length( classLabels_from_DataBank ) ) / rate_of_Demonstration_for_X ) + 1 ) * rate_of_Demonstration_for_X;
                    set(gca,'XTick', demonstrating_X_Labels )
                    set(gca,'XTickLabels', '' )
                    set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                    set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                    ylabel('ClassLabels')
                    textLoc( text_unCommon_Testing, 'SouthEast', 'edgecolor', 'black', 'fontsize', each_Plot_TextFontSize )
                    title ( 'Indices of Unique Testing Data-Points (not Used in Training)' )
                    hold off;                
                    grid on;                       
                    
            % SubPlot ( 3, 1, 3 ) >> Just for 'Training_or_Application == Training'   >>>>>>>>>>> 'Common Indices'                
                subplot (3, 1, 3)  

                % Plotting Graph
                    for index = 1 : size ( classLabels_from_DataBank, 2 )                   
                        if ( indices_of_Common_DataPoints_from_Training_and_Testing ( 1, index ) == 1 )
                            plot ( index, classLabels_from_DataBank ( 1, index ), 'gs', 'DisplayName', 'Training Data-Points', 'MarkerSize', markerSize );
                            hold on;                                                

                        end                                        

                    end
                    
                % Showing Infos. for each Device
                    unique_Device_Labels = unique ( classLabels_from_DataBank );
                    for index = 1 : numel ( unique_Device_Labels )
                        temporary = find ( classLabels_from_DataBank == unique_Device_Labels ( 1, index ) );
                        temp_Starting_Index_of_DataPoints_of_Current_Device = temporary ( 1, 1 );

                        if     ( index ~= numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index + vertical_Offset_of_Text;

                        elseif ( index == numel ( unique_Device_Labels ) )
                            vertical_Position_of_Text   = index - vertical_Offset_of_Text;

                        end

                            Text_1 = sprintf ( 'No. of Common Data-Points for Device %d = %d,', unique_Device_Labels ( 1, index ), number_of_Common_DataPoints_for_each_Device ( 1, index ) );
                            Text_2 = sprintf ( '(%2.2f%% of all Selected Data-Points for Training & Testing for this Device (%d Data-Points)).', percentage_of_Number_of_Common_DataPoints_for_each_Device_with_Respect_to_summation_of_Training_and_Testing_DataPoints ( 1, index ), number_of_all_DataPoints_for_each_Device_Contributed_in_Training_and_Testing ( 1, index ) );
                            Text = sprintf ( '%s\n%s', Text_1, Text_2 );

                            t = text ( temp_Starting_Index_of_DataPoints_of_Current_Device, vertical_Position_of_Text, Text );
                            t.FontSize = each_Class_TextFontSize;

                    end

                % Showing Infos. for Whole Plot                    
                    set(gca,'XLim', [ 1   length( classLabels_from_DataBank ) ] )
                    demonstrating_X_Labels = unique( floor ( (  1 : length( classLabels_from_DataBank ) ) / rate_of_Demonstration_for_X ) + 1 ) * rate_of_Demonstration_for_X;
                    set(gca,'XTick', demonstrating_X_Labels )
                    set(gca,'YLim', [ min( unique ( classLabels_from_DataBank ) )    max( unique ( classLabels_from_DataBank ) ) ] )
                    set(gca,'YTick', unique ( classLabels_from_DataBank ) )
                    ylabel('ClassLabels');
                    textLoc( text_Common, 'SouthEast', 'edgecolor', 'black', 'fontsize', each_Plot_TextFontSize )
                    title ( 'Indices of Common Data-Points (Used both in Training and Testing)' )
                    hold off;                
                    grid on;       
                   
            % Setting the current Figure Invisible              
%                 set (gcf, 'Visible', 'off')                    

        end     

    %% Section 5: Collecting the Inputs for Classification            
        inputs_for_classifier = [   temp,                                           ... 
                                    { 'application_or_Training',                    application_or_Training, ...
                                      'selected_Model_Address_for_Application',     selected_Model_Address_for_Application, ...
                                      'Saving_Address',                             Saving_Address, ...
                                      ...
                                      'Minimum_of_ClassLabels_in_all_Dimensions',   Minimum_of_ClassLabels_in_all_Dimensions, ...
                                      'Maximum_of_ClassLabels_in_all_Dimensions',   Maximum_of_ClassLabels_in_all_Dimensions, ...
                                      ...
                                      'classLabels_from_DataBank',                  classLabels_from_DataBank , ...
                                      ...                                          
                                      'classLabels_from_DataBank_for_Test',         classLabels_from_DataBank_for_Test, ...
                                      'number_of_Devices_in_the_Original_DataBank', number_of_Devices_in_the_Original_DataBank
                                      }                                     
                                ];
            
            
            
            