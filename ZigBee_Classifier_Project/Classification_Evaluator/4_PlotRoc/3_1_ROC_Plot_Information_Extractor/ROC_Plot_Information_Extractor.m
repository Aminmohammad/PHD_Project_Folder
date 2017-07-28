function output = ROC_Plot_Information_Extractor ( train_Input, test_Input )

reference_Devices_Indices              = train_Input.selected_Indices_of_Devices;
reference_Devices_Scores               = train_Input.scores;
Number_of_Bursts_for_Reference_Devices = train_Input.number_of_Bursts_for_Classified_Devices;
reference_Devices_Labels               = train_Input.classLabels_from_Original_or_ReducedForApplication_DataBank;

testing_Devices_Indices                = test_Input.selected_Indices_of_Devices;
testing_Devices_Scores                 = test_Input.scores;
Number_of_Bursts_for_Testing_Devices   = test_Input.number_of_Bursts_for_Classified_Devices;
testing_Devices_Labels                 = test_Input.classLabels_from_Original_or_ReducedForApplication_DataBank;

Unique_Reference_Devices_Labels = unique ( reference_Devices_Labels );
output_Index = 1;
for reference_Devices_Labels_Index = 1 : numel ( Unique_Reference_Devices_Labels )
    
    if ( reference_Devices_Labels_Index == 1 )
        starting_Index = 1;
        ending_Index   = Number_of_Bursts_for_Reference_Devices ( 1, 1 );
        
    else
        starting_Index = sum ( Number_of_Bursts_for_Reference_Devices ( 1, 1 : reference_Devices_Labels_Index - 1 ) ) + 1;
        ending_Index   = sum ( Number_of_Bursts_for_Reference_Devices ( 1, 1 : reference_Devices_Labels_Index ) ) ;
        
    end

    current_Reference_Device_Labels = reference_Devices_Labels ( 1, starting_Index : ending_Index );
    current_Reference_Device_Probabilities = reference_Devices_Scores ( reference_Devices_Labels_Index, starting_Index : ending_Index );    
    Unique_Testing_Devices_Labels = unique ( testing_Devices_Labels );
    
    current_Reference_Device_Label = unique (current_Reference_Device_Labels);
    
    for testing_Devices_Labels_Index = 1 : numel ( Unique_Testing_Devices_Labels )
        if ( testing_Devices_Labels_Index == 1 )
            starting_Index = 1;
            ending_Index   = Number_of_Bursts_for_Testing_Devices ( 1, 1 );

        else
            starting_Index = sum ( Number_of_Bursts_for_Testing_Devices ( 1, 1 : testing_Devices_Labels_Index - 1 ) ) + 1;
            ending_Index   = sum ( Number_of_Bursts_for_Testing_Devices ( 1, 1 : testing_Devices_Labels_Index ) ) ;

        end
        
        true_Labels_of_Current_Testing_Device = testing_Devices_Labels ( 1, starting_Index : ending_Index );
       
        probabilities_of_DataPoints_of_Current_Testing_Device_based_on_Current_Reference_Device = testing_Devices_Scores ( reference_Devices_Labels_Index, ...
                                                                                                                           starting_Index : ending_Index );
        current_Testing_Device_Label = unique (true_Labels_of_Current_Testing_Device);
        
        if ( current_Reference_Device_Label ~= current_Testing_Device_Label )

            % Negative Test                                                                                                               
                output_of_False_Negative = False_Negative_Rate_Calculator_for_One_Reference_Device ( 'true_Labels_of_Testing_Device', true_Labels_of_Current_Testing_Device, ...
                                                                                                     'probabilities_of_Testing_DataPoins', probabilities_of_DataPoints_of_Current_Testing_Device_based_on_Current_Reference_Device );

                output_of_True_Negative = True_Negative_Rate_Calculator_for_One_Reference_Device  ( 'true_Labels_of_Reference_DataPoints', current_Reference_Device_Labels, ...
                                                                                                    'probabilities_of_Reference_DataPoins', current_Reference_Device_Probabilities, ...
                                                                                                    'thresholds_for_True_or_False_Negative_Rates', output_of_False_Negative. thresholds_for_True_or_False_Negative_Rates, ...
                                                                                                    'Reference_Device_Index', current_Reference_Device_Label );

                x_Values_for_Negative_Case = output_of_False_Negative. false_Negative_Rates_of_Classifications_for_all_Thresholds;
                y_Values_for_Negative_Case = output_of_True_Negative. true_Negative_Rates_of_Classifications_for_all_Thresholds;

                output.negative( 1, output_Index ).reference_Device_Index         = Unique_Reference_Devices_Labels ( 1, reference_Devices_Labels_Index );
                output.negative( 1, output_Index ).testing_Device_Index           = Unique_Testing_Devices_Labels ( 1, testing_Devices_Labels_Index );
                output.negative( 1, output_Index ).x_Values                       = x_Values_for_Negative_Case;
                output.negative( 1, output_Index ).y_Values                       = y_Values_for_Negative_Case;
                output.negative( 1, output_Index ).thresholds                     = output_of_False_Negative. thresholds_for_True_or_False_Negative_Rates;
                output.negative( 1, output_Index ).reference_Device_probabilities = current_Reference_Device_Probabilities;
                output.negative( 1, output_Index ).testing_Device_probabilities   = probabilities_of_DataPoints_of_Current_Testing_Device_based_on_Current_Reference_Device;


            % Positive Test                                                                                    
                output_of_False_Positive = False_Positive_Rate_Calculator_for_One_Reference_Device ( 'true_Labels_of_Reference_DataPoints', current_Reference_Device_Labels, ...
                                                                                                     'probabilities_of_Reference_DataPoints', current_Reference_Device_Probabilities );

                output_of_True_Positive = True_Positive_Rate_Calculator_for_One_Reference_Device  ('true_Labels_of_Testing_DataPoints', true_Labels_of_Current_Testing_Device, ...
                                                                                                   'probabilities_of_Testing_DataPoins', probabilities_of_DataPoints_of_Current_Testing_Device_based_on_Current_Reference_Device, ...
                                                                                                   'thresholds_for_True_or_False_Positive_Rates', output_of_False_Positive. thresholds_for_True_or_False_Positive_Rates, ...
                                                                                                   'Reference_Device_Index', current_Reference_Device_Label );


                x_Values_for_Positive_Case = output_of_False_Positive. false_Positive_Rates_of_Classifications_for_all_Thresholds;
                y_Values_for_Positive_Case = output_of_True_Positive. true_Positive_Rates_of_Classifications_for_all_Thresholds;


                output.positive( 1, output_Index ).reference_Device_Index         = Unique_Reference_Devices_Labels ( 1, reference_Devices_Labels_Index );
                output.positive( 1, output_Index ).testing_Device_Index           = Unique_Testing_Devices_Labels ( 1, testing_Devices_Labels_Index );
                output.positive( 1, output_Index ).x_Values                       = x_Values_for_Positive_Case;
                output.positive( 1, output_Index ).y_Values                       = y_Values_for_Positive_Case;
                output.positive( 1, output_Index ).thresholds                     = output_of_False_Positive. thresholds_for_True_or_False_Positive_Rates;
                output.positive( 1, output_Index ).reference_Device_probabilities = current_Reference_Device_Probabilities;
                output.positive( 1, output_Index ).testing_Device_probabilities   = probabilities_of_DataPoints_of_Current_Testing_Device_based_on_Current_Reference_Device;

            output_Index = output_Index + 1;
            
        end

    end


end