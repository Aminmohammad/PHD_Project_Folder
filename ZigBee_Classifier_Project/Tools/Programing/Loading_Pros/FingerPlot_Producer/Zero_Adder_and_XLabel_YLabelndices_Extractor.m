function  [ matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, XLabel, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y ] = Zero_Adder_and_XLabel_YLabelndices_Extractor ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, ...
                                                                                                                                                                                                                                                                                         selected_Indices_of_Devices,            ...
                                                                                                                                                                                                                                                                                         number_of_Bursts_for_all_of_Devices,                       ...
                                                                                                                                                                                                                                                                                         YLabel,                                                    ...
                                                                                                                                                                                                                                                                                         number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,     ...
                                                                                                                                                                                                                                                                                         number_of_Added_Zeros_Between_Devices                      ...
                                                                                                                                                                                                                                                                                         )

    % Adding Zeros Between Devices
        temp_Number_of_Bursts_for_all_of_Devices = [ 0 number_of_Bursts_for_all_of_Devices ];
        temp_Matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [];
%         number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot =  [ 1, 159;
%                                                                    1, 159;
%                                                                    1, 159;
%                                                                    1, 159; ];

%         number_of_Added_Zeros_Between_Devices = 10;
        new_Starting_Point_of_Devices_in_XLabel = zeros ( 1, size ( selected_Indices_of_Devices, 2 ) + 1 );
        new_Ending_Point_of_Devices_in_XLabel   = zeros ( 1, size ( selected_Indices_of_Devices, 2 ) + 1 );
        for device_Index = 2 : size ( selected_Indices_of_Devices, 2 ) + 1

            starting_Index =  sum ( temp_Number_of_Bursts_for_all_of_Devices ( 1, 1 : device_Index - 1 ) ) + 1;
            ending_Index   =  sum ( temp_Number_of_Bursts_for_all_of_Devices ( 1, 1 : device_Index ) );
            this_Part_of_Matrix = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( :, starting_Index : ending_Index );
            temp_Matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [ temp_Matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, this_Part_of_Matrix(:, number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot ( device_Index - 1, 1  ) : number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot ( device_Index - 1, 2  )), zeros(size(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 1), number_of_Added_Zeros_Between_Devices ) ];
            
            number_of_Elements = number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot ( device_Index - 1, 2 ) - number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot ( device_Index - 1, 1 ) + 1;
            new_Starting_Point_of_Devices_in_XLabel ( 1, device_Index ) = number_of_Added_Zeros_Between_Devices + new_Ending_Point_of_Devices_in_XLabel ( 1, device_Index - 1 ) + 1;
            new_Ending_Point_of_Devices_in_XLabel   ( 1, device_Index ) = number_of_Added_Zeros_Between_Devices + new_Ending_Point_of_Devices_in_XLabel ( 1, device_Index - 1 ) + number_of_Elements;

        end
        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [ zeros(size(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 1), floor(number_of_Added_Zeros_Between_Devices/2) ), temp_Matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot(:, 1: end - number_of_Added_Zeros_Between_Devices), zeros(size(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 1), floor(number_of_Added_Zeros_Between_Devices/2) ) ] ;
        new_Starting_Point_of_Devices_in_XLabel = new_Starting_Point_of_Devices_in_XLabel ( 1, 2 : end ) - floor(number_of_Added_Zeros_Between_Devices/2);
        new_Ending_Point_of_Devices_in_XLabel   = new_Ending_Point_of_Devices_in_XLabel   ( 1, 2 : end ) - floor(number_of_Added_Zeros_Between_Devices/2);
                
        % Making the 'XLabel'
            XLabel = [];
            for index = 1 : size ( selected_Indices_of_Devices, 2 ) 
                XLabel = [ XLabel, { sprintf( 'Device_%d', selected_Indices_of_Devices ( 1, index ) )} ];
                
            end
            indices_of_Seperations_in_X_for_XTickLabels    = floor ( (new_Starting_Point_of_Devices_in_XLabel + new_Ending_Point_of_Devices_in_XLabel) / 2 );            
            indices_of_Seperations_in_X_for_Veritcal_Lines = new_Ending_Point_of_Devices_in_XLabel ( 1, 1 : end - 1 ) + floor( number_of_Added_Zeros_Between_Devices/2 );
            
        % Extracting the 'YLabel Indices'
           indices_of_Seperations_in_Y  = find ( strcmp ( YLabel, ' ' ) ~= 0 );
           indices_of_Seperations_in_Y  = indices_of_Seperations_in_Y ( 2 : end - 1, :);
           indices_of_Accumulation_in_Y = find ( strcmp ( YLabel, ' ' ) == 0 );

end