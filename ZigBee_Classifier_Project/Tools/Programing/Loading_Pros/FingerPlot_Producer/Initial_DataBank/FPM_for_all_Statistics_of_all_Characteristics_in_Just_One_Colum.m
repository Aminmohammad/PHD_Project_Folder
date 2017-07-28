function output_Stricture = FPM_for_all_Statistics_of_all_Characteristics_in_Just_One_Column (   matrix_of_FingerPrint_DataBank_for_all_Devices, ...
                                                                                                 cell_of_FieldNames_for_all_Devices,             ...
                                                                                                 number_of_bursts_for_all_Devices,               ...
                                                                                                                                                 ...
                                                                                                 selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String, ...
                                                                                                 selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String, ...
                                                                                                                                                 ...
                                                                                                 vertical_Cell_of_Characteristics_Names,         ...
                                                                                                 vertical_Cell_of_Statistics_Names,              ...
                                                                                                 selected_Devices_Indices_for_Application,       ...
                                                                                                 application_or_Training                         ...
                                                                                                                                                       )

    %% Section 0: Extraction of Essential Inputs
        func_for_Rows_String                                                        = selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String;
        func_for_Rows                                                               = str2func ( func_for_Rows_String );

%         func_for_Cols_String                                                      = selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String;
%         func_for_Cols                                                             = str2func ( func_for_Cols_String );

       
    %% Section 1: Preparing the Indices     
        % Level 1: Reducting the size of 'cell_of_FieldNames_for_all_Devices'
            temp_Cell_of_FieldNames_for_all_Devices = [];
            for selected_Devices_Index_for_Application = 1 : size ( selected_Devices_Indices_for_Application, 2 )
                number_of_Burst_for_Current_Selected_Device = number_of_bursts_for_all_Devices ( selected_Devices_Indices_for_Application ( 1, selected_Devices_Index_for_Application ), 1 );
                starting_Index = 0;

                if ( selected_Devices_Indices_for_Application ( 1, selected_Devices_Index_for_Application ) > 1 )
                    starting_Index = sum ( number_of_bursts_for_all_Devices( 1 : selected_Devices_Indices_for_Application ( 1, selected_Devices_Index_for_Application  )- 1, 1 ) );

                end
                    starting_Index = starting_Index + 1;
                    ending_Index   = starting_Index + number_of_Burst_for_Current_Selected_Device - 1;                        
                    temp_Cell_of_FieldNames_for_all_Devices = [ temp_Cell_of_FieldNames_for_all_Devices, cell_of_FieldNames_for_all_Devices( :, starting_Index : ending_Index ) ];
            end

            cell_of_FieldNames_for_all_Devices = temp_Cell_of_FieldNames_for_all_Devices;

        % Level 2: Extracing the Labels
            skewness_of_Amplitude_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Skewness_of_Amplitude_Element' );
            variance_of_Amplitude_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Variance_of_Amplitude_Element' );
            kurtosis_of_Amplitude_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Kurtosis_of_Amplitude_Element' );
            mean_of_Amplitude_Indices     = strcmp ( cell_of_FieldNames_for_all_Devices, 'Mean_of_Amplitude_Element' );

            skewness_of_Phase_Indices     = strcmp ( cell_of_FieldNames_for_all_Devices, 'Skewness_of_Phase_Element' );
            variance_of_Phase_Indices     = strcmp ( cell_of_FieldNames_for_all_Devices, 'Variance_of_Phase_Element' );
            kurtosis_of_Phase_Indices     = strcmp ( cell_of_FieldNames_for_all_Devices, 'Kurtosis_of_Phase_Element' );
            mean_of_Phase_Indices         = strcmp ( cell_of_FieldNames_for_all_Devices, 'Mean_of_Phase_Element' );

            skewness_of_Frequency_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Skewness_of_Frequency_Element' );
            variance_of_Frequency_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Variance_of_Frequency_Element' );
            kurtosis_of_Frequency_Indices = strcmp ( cell_of_FieldNames_for_all_Devices, 'Kurtosis_of_Frequency_Element' );
            mean_of_Frequency_Indices     = strcmp ( cell_of_FieldNames_for_all_Devices, 'Mean_of_Frequency_Element' );

            temp_Matrix_of_FingerPrint_DataBank_for_all_Devices = matrix_of_FingerPrint_DataBank_for_all_Devices ( 1 : end - 1, : );
            matrix_of_Skewness_of_Amplitude = [];
            matrix_of_Skewness_of_Phase     = [];
            matrix_of_Skewness_of_Frequency = [];
            matrix_of_Variance_of_Amplitude = []; 
            matrix_of_Variance_of_Phase     = []; 
            matrix_of_Variance_of_Frequency = [];
            matrix_of_Kurtosis_of_Amplitude = []; 
            matrix_of_Kurtosis_of_Phase     = []; 
            matrix_of_Kurtosis_of_Frequency = [];
            matrix_of_Mean_of_Amplitude     = [];
            matrix_of_Mean_of_Phase         = []; 
            matrix_of_Mean_of_Frequency     = [];

            for row_Index = 1 : size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 1 )

                  temp_Skewness_of_Amplitude_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );              

                  temp_Skewness_of_Amplitude_Indices  ( row_Index, : ) = skewness_of_Amplitude_Indices ( row_Index, : );
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Skewness_of_Amplitude_Indices ) );
                  matrix_of_Skewness_of_Amplitude                      = [ matrix_of_Skewness_of_Amplitude; temp(:)' ]; 

                  temp_Skewness_of_Phase_Indices                       = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Skewness_of_Phase_Indices      ( row_Index, : ) = skewness_of_Phase_Indices ( row_Index, : );
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Skewness_of_Phase_Indices ) ); 
                  matrix_of_Skewness_of_Phase                          = [ matrix_of_Skewness_of_Phase; temp(:)'];

                  temp_Skewness_of_Frequency_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Skewness_of_Frequency_Indices  ( row_Index, : ) = skewness_of_Frequency_Indices ( row_Index, : );                              
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Skewness_of_Frequency_Indices ) );
                  matrix_of_Skewness_of_Frequency                      = [ matrix_of_Skewness_of_Frequency; temp(:)'];
                                                        ...
                                                        ...
                                                        ...
                                                        ...
                  temp_Variance_of_Amplitude_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Variance_of_Amplitude_Indices  ( row_Index, : ) = variance_of_Amplitude_Indices ( row_Index, : );                              
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Variance_of_Amplitude_Indices ) ); 
                  matrix_of_Variance_of_Amplitude                      = [ matrix_of_Variance_of_Amplitude; temp(:)'];

                  temp_Variance_of_Phase_Indices                       = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Variance_of_Phase_Indices      ( row_Index, : ) = variance_of_Phase_Indices ( row_Index, : );                              
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Variance_of_Phase_Indices ) ); 
                  matrix_of_Variance_of_Phase                          = [ matrix_of_Variance_of_Phase; temp(:)' ];

                  temp_Variance_of_Frequency_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Variance_of_Frequency_Indices  ( row_Index, : ) = variance_of_Frequency_Indices ( row_Index, : );                              
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Variance_of_Frequency_Indices ) ); 
                  matrix_of_Variance_of_Frequency                      = [ matrix_of_Variance_of_Frequency; temp(:)' ];
                                                        ...
                                                        ...
                                                        ...
                                                        ...
                  temp_Kurtosis_of_Amplitude_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Kurtosis_of_Amplitude_Indices  ( row_Index, : ) = kurtosis_of_Amplitude_Indices ( row_Index, : );                                                            
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Kurtosis_of_Amplitude_Indices ) ); 
                  matrix_of_Kurtosis_of_Amplitude                      = [ matrix_of_Kurtosis_of_Amplitude; temp(:)' ];

                  temp_Kurtosis_of_Phase_Indices                       = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Kurtosis_of_Phase_Indices      ( row_Index, : ) = kurtosis_of_Phase_Indices ( row_Index, : );                                                            
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Kurtosis_of_Phase_Indices ) ); 
                  matrix_of_Kurtosis_of_Phase                          = [ matrix_of_Kurtosis_of_Phase; temp(:)' ];

                  temp_Kurtosis_of_Frequency_Indices                   = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Kurtosis_of_Frequency_Indices  ( row_Index, : ) = kurtosis_of_Frequency_Indices ( row_Index, : );                                                                
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Kurtosis_of_Frequency_Indices ) );
                  matrix_of_Kurtosis_of_Frequency                      = [ matrix_of_Kurtosis_of_Frequency; temp(:)' ];
                                                        ...
                                                        ...
                                                        ...
                                                        ...
                  temp_Mean_of_Amplitude_Indices                       = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Mean_of_Amplitude_Indices      ( row_Index, : ) = mean_of_Amplitude_Indices ( row_Index, : );       
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Mean_of_Amplitude_Indices ) ); 
                  matrix_of_Mean_of_Amplitude                          = [ matrix_of_Mean_of_Amplitude; temp(:)' ];

                  temp_Mean_of_Phase_Indices                           = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Mean_of_Phase_Indices          ( row_Index, : ) = mean_of_Phase_Indices ( row_Index, : );                                                                
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Mean_of_Phase_Indices ) ); 
                  matrix_of_Mean_of_Phase                              = [ matrix_of_Mean_of_Phase; temp(:)' ];

                  temp_Mean_of_Frquency_Indices                        = zeros ( size ( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ) );
                  temp_Mean_of_Frquency_Indices       ( row_Index, : ) = mean_of_Frequency_Indices ( row_Index, : );                                                                
                  temp                                                 = temp_Matrix_of_FingerPrint_DataBank_for_all_Devices ( logical ( temp_Mean_of_Frquency_Indices ) );
                  matrix_of_Mean_of_Frequency                          = [ matrix_of_Mean_of_Frequency; temp(:)' ];

            end

    %% Section 2: Vertical Structure of Different 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot'
            % Level 1: Characteristic Based Matrices
                % Stage 1_1: Amplitude 
                    % Part 1_1_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased = [   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Kurtosis_of_Amplitude );   ...                                                                           
                                                                                                                                          ...  
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Skewness_of_Amplitude );   ...                                                                           .
                                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Variance_of_Amplitude );   ...
                                                                                                                                          ...                                 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Mean_of_Amplitude );       ...
                                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...

                                                                                                                        ];  

                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased( row_Index, : ) / maximum_Value;
                            end
                        end
                        
                    % Part 1_1_2: YLabels
                       YLabel_AmplitudeBased = {   ' ';
                                                    sprintf('%s(Amp. Kurtosis_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                    ' ';
                                                    sprintf('%s(Amp. Skewness_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                    ' ';
                                                    sprintf('%s(Amp. Variance_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                    ' ';
                                                    sprintf('%s(Amp. Mean_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                    ' ';
                                                    };
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

                % Stage 1_2: Phase
                    % Part 1_2_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased = [   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                   func_for_Rows( matrix_of_Kurtosis_of_Phase );   ...                                                                           
                                                                                                                                      ...  
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...
                                                                                                   func_for_Rows( matrix_of_Skewness_of_Phase );   ...                                                                           .
                                                                                                                                      ... 
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...                                   
                                                                                                   func_for_Rows( matrix_of_Variance_of_Phase );   ...
                                                                                                                                      ...                                 
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...                                   
                                                                                                   func_for_Rows( matrix_of_Mean_of_Phase );       ...
                                                                                                                                      ... 
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...

                                                                                                                        ];  

                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased( row_Index, : ) / maximum_Value;
                            end
                        end
                        
                    % Part 1_2_2: YLabels
                       YLabel_PhaseBased = {    ' ';
                                                sprintf('%s(Phase Kurtosis_a_l_l_s_u_b_R_e_g_s)',     func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Skewness_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Variance_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Mean_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                };

                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

                % Stage 1_2: Frequency 
                    % Part 1_2_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased = [   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Kurtosis_of_Phase );   ...                                                                           
                                                                                                                                          ...  
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Skewness_of_Phase );   ...                                                                           .
                                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Variance_of_Phase );   ...
                                                                                                                                          ...                                 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Mean_of_Phase );       ...
                                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                          ...

                                                                                                                        ];  

                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased( row_Index, : ) / maximum_Value;
                            end
                        end
                        
                    % Part 1_2_2: YLabels
                       YLabel_FrequencyBased = {    ' ';
                                                sprintf('%s(Freq. Kurtosis_a_l_l_s_u_b_R_e_g_s)',     func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Freq. Skewness_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Freq. Variance_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Freq. Mean_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                };

                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

            % Level 2: Statistics Based Matrices
                % Stage 2_1: Mean 
                    % Part 2_1_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased = [   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                   func_for_Rows( matrix_of_Mean_of_Frequency );   ...                                                                           
                                                                                                                                      ...  
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...
                                                                                                   func_for_Rows( matrix_of_Mean_of_Phase );   ...                                                                           .
                                                                                                                                      ... 
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...                                   
                                                                                                   func_for_Rows( matrix_of_Mean_of_Amplitude );   ...
                                                                                                                                      ... 
                                                                                                   zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                       ...

                                                                                                                        ];  
                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased( row_Index, : ) / maximum_Value;
                            end
                        end
                        
                    % Part 2_1_2: YLabels
                       YLabel_MeanBased = { ' ';
                                            sprintf('%s(Freq. Mean_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                            ' ';
                                            sprintf('%s(Phase Mean_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                            ' ';
                                            sprintf('%s(Amp. Mean_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                            ' ';
                                            };
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

                % Stage 2_2: Variance 
                    % Part 2_2_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased = [    zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Variance_of_Amplitude );   ...                                                                           
                                                                                                                          ...  
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Variance_of_Phase );   ...                                                                           .
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Variance_of_Frequency );   ...
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                   ];  
                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased( row_Index, : ) / maximum_Value;
                            end
                        end
                        
                    % Part 2_2_2: YLabels
                       YLabel_VarianceBased = { ' ';
                                                sprintf('%s(Freq. Variance_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Variance_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Amp. Variance_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                };

               
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

                % Stage 2_2: Skewness 
                    % Part 2_2_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased = [    zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Skewness_of_Amplitude );   ...                                                                           
                                                                                                                          ...  
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Skewness_of_Phase );   ...                                                                           .
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Skewness_of_Frequency );   ...
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                   ];  

                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased( row_Index, : ) / maximum_Value;
                            end
                        end

                        
                    % Part 2_2_3: YLabels
                       YLabel_SkewnessBased = { ' ';
                                                sprintf('%s(Freq. Skewness_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Skewness_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Amp. Skewness_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                };

                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

                % Stage 2_2: Kurtosis
                    % Part 2_2_1: Matrix
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased = [    zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Kurtosis_of_Amplitude );   ...                                                                           
                                                                                                                          ...  
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                       func_for_Rows( matrix_of_Kurtosis_of_Phase );   ...                                                                           .
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...                                   
                                                                                                       func_for_Rows( matrix_of_Kurtosis_of_Frequency );   ...
                                                                                                                          ... 
                                                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                          ...
                                                                                                   ];  

                    % Part 2_2_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased( row_Index, : ) / maximum_Value;
                            end
                            
                        end                                                                                               

                    % Part 2_2_3: YLabels
                       YLabel_KurtosisBased = { ' ';
                                                sprintf('%s(Freq. Kurtosis_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Phase Kurtosis_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                sprintf('%s(Amp. Kurtosis_a_l_l_s_u_b_R_e_g_s)', func_for_Rows_String );
                                                ' ';
                                                };
               
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

            % Level 3: all Characteristics and Statistics in one Place
                % Stage 3_1: MAtrix 
                        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all = [  zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...
                                                                                           func_for_Rows( matrix_of_Kurtosis_of_Frequency );   ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Kurtosis_of_Phase );       ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Kurtosis_of_Amplitude );   ...
                                                                                                                                      ...  
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...
                                                                                           func_for_Rows( matrix_of_Skewness_of_Frequency );   ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Skewness_of_Phase );       ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Skewness_of_Amplitude );   ...
                                                                                                                                      ... 
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...                                   
                                                                                           func_for_Rows( matrix_of_Variance_of_Frequency );   ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Variance_of_Phase );       ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Variance_of_Amplitude );   ...
                                                                                                                                      ...                                 
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...                                   
                                                                                           func_for_Rows( matrix_of_Mean_of_Frequency );       ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Mean_of_Phase );           ...
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                           func_for_Rows( matrix_of_Mean_of_Amplitude );       ...
                                                                                                                                      ... 
                                                                                           zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                                                      ...
                                                                                                                        ];  
                                    
                    % Part 3_1_2: Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all'
                        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all, 1 )
                            
                            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) ) ~= 0 )
                                
                                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) );
                                if ( minimum_Value < 0 )
                                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) + abs ( minimum_Value );
                                    
                                end
                                
                                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) );
                                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all( row_Index, : ) / maximum_Value;
                                
                            end
                                                        
                        end
        
                    % Part 3_1_3: YLabels
                       YLabel_all = {   ' ';
                                        sprintf('%s(Freq. Kurtosis_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Phase Kurtosis_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Amp. Kurtosis_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' ';                                        
                                        sprintf('%s(Freq. Skewness_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Phase Skewness_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Amp. Skewness_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' ';
                                        sprintf('%s(Freq. Variance_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Phase Variance_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Amp. Variance_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );                                        
                                        ' ';
                                        sprintf('%s(Freq. Mean_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Phase Mean_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' '; 
                                        sprintf('%s(Amp. Mean_a_l_l_s_u_b_R_e_g_s)',  func_for_Rows_String );
                                        ' ';
                                        };

                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------
                % ------------------------------------------------------------------------------------------------------------------------------------------------------------------

            % Level 4: Collecting all Matrices
                output_Stricture. amplitude. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased;
                output_Stricture. amplitude. YLabel_AmplitudeBased                                                    = YLabel_AmplitudeBased;

                output_Stricture. phase. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased         = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_PhaseBased;
                output_Stricture. phase. YLabel_PhaseBased                                                            = YLabel_PhaseBased;

                output_Stricture. frequency. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_FrequencyBased;
                output_Stricture. frequency. YLabel_FrequencyBased                                                    = YLabel_FrequencyBased;

                output_Stricture. mean. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased           = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_MeanBased;
                output_Stricture. mean. YLabel_MeanBased                                                              = YLabel_MeanBased;

                output_Stricture. variance. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased   = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_VarianceBased;
                output_Stricture. variance. YLabel_VarianceBased                                                      = YLabel_VarianceBased;

                output_Stricture. skewness. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased   = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_SkewnessBased;
                output_Stricture. skewness. YLabel_SkewnessBased                                                      = YLabel_SkewnessBased;

                output_Stricture. kurtosis. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased   = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_KurtosisBased;
                output_Stricture. kurtosis. YLabel_KurtosisBased                                                      = YLabel_KurtosisBased;

                output_Stricture. all. matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all                  = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_all;
                output_Stricture. all. YLabel_all                                                                     = YLabel_all;




end