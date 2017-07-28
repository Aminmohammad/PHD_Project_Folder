 function output = Output_Provider_from_Classifier ( varargin )
  
     %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            
            inputSet.addParameter('training_Outputs', []);
            inputSet.addParameter('testing_Outputs', []);
            inputSet.addParameter('training_Scores', []);
            inputSet.addParameter('testing_Scores', []);
            inputSet.addParameter('application_or_Training', []);
            
            inputSet.addParameter('Minimum_of_ClassLabels_in_all_Dimensions', []);
            inputSet.addParameter('Maximum_of_ClassLabels_in_all_Dimensions', []);
            
            inputSet.addParameter('classLabels_from_DataBank', []);
            
            inputSet.addParameter('classLabels_from_DataBank_for_Train', []);
            inputSet.addParameter('classLabels_from_DataBank_for_Test', []);
            
            inputSet.addParameter('number_of_Devices_in_the_Original_DataBank', []);
            
            inputSet.parse(varargin{:});

            training_Outputs                               = inputSet.Results.training_Outputs;
            testing_Outputs                                = inputSet.Results.testing_Outputs;
            training_Scores                                = inputSet.Results.training_Scores;
            testing_Scores                                 = inputSet.Results.testing_Scores;
            application_or_Training                        = inputSet.Results.application_or_Training;
            
            Minimum_of_ClassLabels_in_all_Dimensions       = inputSet.Results.Minimum_of_ClassLabels_in_all_Dimensions;
            Maximum_of_ClassLabels_in_all_Dimensions       = inputSet.Results.Maximum_of_ClassLabels_in_all_Dimensions;
            
            classLabels_from_DataBank                      = inputSet.Results.classLabels_from_DataBank;
            
            classLabels_from_DataBank_for_Train            = inputSet.Results.classLabels_from_DataBank_for_Train;
            classLabels_from_DataBank_for_Test             = inputSet.Results.classLabels_from_DataBank_for_Test;
            
            number_of_Devices_in_the_Original_DataBank     = inputSet.Results.number_of_Devices_in_the_Original_DataBank;

    %% Section 2: Outputs 
        % Level 1: transposing the 'outputs', if essential.            
            if     ( strcmp ( application_or_Training, 'Training' ) == 1 ) && ( size ( training_Outputs, 1 ) > size ( training_Outputs, 2 ) )
                training_Outputs = training_Outputs';
                
            end
            
            if ( size ( testing_Outputs, 1 ) > size ( testing_Outputs, 2 ) )
                testing_Outputs  = testing_Outputs';
                
            end     
            
        % Level 2: Reforming the 'outputs' in the Range of 'initial ClassLabels'
            number_of_ClassLabels_Dimensions = size( testing_Outputs, 1 );                                   
            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                if ( strcmp ( application_or_Training, 'Training' ) == 1 )
                    reformed_Training_Outputs ( dimension_Index, : ) = Reform_Fcn ( training_Outputs ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                    
                end
                
                reformed_Testing_Outputs  ( dimension_Index, : ) = Reform_Fcn ( testing_Outputs  ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                
            end
            
         % Level 3: Rounding   
            if ( strcmp ( application_or_Training, 'Training' ) == 1 )
                training_Outputs = round ( reformed_Training_Outputs );   
                
            end
            testing_Outputs  = round ( reformed_Testing_Outputs );                  
            
         % Level 4: Clamping
            if ( strcmp ( application_or_Training, 'Training' ) == 1 )
                training_Outputs ( training_Outputs > max ( classLabels_from_DataBank ) ) = max ( classLabels_from_DataBank );
                
            end
            testing_Outputs  ( testing_Outputs  < min ( classLabels_from_DataBank ) ) = min ( classLabels_from_DataBank );

         % Level 5: Extracting the Number of Bursts for both cases of "Train" and "Test"
            if ( strcmp ( application_or_Training, 'Training' ) == 1 )
                unique_ClassLabels_from_DataBank_for_Train = unique ( classLabels_from_DataBank_for_Train );
                for index = 1 : numel ( unique_ClassLabels_from_DataBank_for_Train )
                    number_of_Bursts_for_Train ( 1, index ) = sum (  classLabels_from_DataBank_for_Train == unique_ClassLabels_from_DataBank_for_Train ( 1, index )  );
                    
                end
                                
            end

            unique_ClassLabels_from_DataBank_for_Test = unique ( classLabels_from_DataBank_for_Test );
            for index = 1 : numel ( unique_ClassLabels_from_DataBank_for_Test )
                number_of_Bursts_for_Test ( 1, index ) = sum (  classLabels_from_DataBank_for_Test == unique_ClassLabels_from_DataBank_for_Test ( 1, index )  );

            end

         % Level 6: Output             
            if ( strcmp ( application_or_Training, 'Training' ) == 1 )
                temp_Raw_Training_outputs                                        = reformed_Training_Outputs;  
                temp_Rounded_and_Clampd_Training_outputs                         = training_Outputs;
                
                output.outputs_Train.raw_Output                                  = temp_Raw_Training_outputs;
                output.outputs_Train.roundedClamped_Output                       = temp_Rounded_and_Clampd_Training_outputs;
                output.outputs_Train.classLabels_from_DataBank                   = classLabels_from_DataBank_for_Train;                                
                output.outputs_Train.number_of_Bursts                            = number_of_Bursts_for_Train;
                output.outputs_Train.selected_Indices_of_Devices                 = unique(classLabels_from_DataBank_for_Train);
                output.outputs_Train.number_of_Devices_in_the_Original_DataBank  = numel ( output.outputs_Train.selected_Indices_of_Devices );
                
                output.outputs_Train.scores                             = training_Scores;
                
            end

            temp_Raw_Testing_outputs                        = reformed_Testing_Outputs;  
            temp_Rounded_and_Clampd_Testing_outputs         = testing_Outputs;

            output.outputs_Test.raw_Output                  = temp_Raw_Testing_outputs;
            output.outputs_Test.roundedClamped_Output       = temp_Rounded_and_Clampd_Testing_outputs;
            output.outputs_Test.classLabels_from_DataBank   = classLabels_from_DataBank_for_Test;
            
            output.outputs_Test.number_of_Bursts            = number_of_Bursts_for_Test;
            output.outputs_Test.selected_Indices_of_Devices = unique ( classLabels_from_DataBank_for_Test );

            if ( isempty ( number_of_Devices_in_the_Original_DataBank ) == 0 )
                if     ( strcmp ( application_or_Training, 'Application' ) == 1 )
                    temp                                                            = load ( number_of_Devices_in_the_Original_DataBank );
                    output.outputs_Test. number_of_Devices_in_the_Original_DataBank = temp.number_of_Devices;
                    
                elseif ( strcmp ( application_or_Training, 'Training' ) == 1 )

                    output.outputs_Test. number_of_Devices_in_the_Original_DataBank = numel ( output.outputs_Test.selected_Indices_of_Devices );

                end
                
            end
            
            output.outputs_Test.scores             = testing_Scores;
      
 end