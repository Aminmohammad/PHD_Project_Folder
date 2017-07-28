function [ matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, YLabel ] = FPM_for_all_Statistics_of_all_Characteristics_in_Just_One_Column (  matrix_of_FingerPrint_DataBank_for_all_Devices, ...
                                                                                                                                                     cell_of_FieldNames_for_all_Devices, ...
                                                                                                                                                                            ...
                                                                                                                                                     vertical_Cell_of_Characteristics_Names, ...
                                                                                                                                                     vertical_Cell_of_Statistics_Names       ...
                                                                                                                                                       )


    %% Section 1: 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot'
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

        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [  zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                          ...
                                                                       mean( matrix_of_Skewness_of_Amplitude );   ...
                                                                       mean( matrix_of_Skewness_of_Phase );       ...
                                                                       mean( matrix_of_Skewness_of_Frequency );   ...
                                                                                                          ...  
                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                          ...
                                                                       mean( matrix_of_Variance_of_Amplitude );   ...
                                                                       mean( matrix_of_Variance_of_Phase );       ...
                                                                       mean( matrix_of_Variance_of_Frequency );   ...
                                                                                                          ... 
                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                          ...                                   
                                                                       mean( matrix_of_Kurtosis_of_Amplitude );   ...
                                                                       mean( matrix_of_Kurtosis_of_Phase );       ...
    %                                                                            mean( matrix_of_Kurtosis_of_Frequency );   ...
                                                                                                          ...                                 
                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                          ...                                   
                                                                       mean( matrix_of_Mean_of_Amplitude );       ...
                                                                       mean( matrix_of_Mean_of_Phase );           ...
                                                                       mean( matrix_of_Mean_of_Frequency );       ...
                                                                                                          ... 
                                                                       zeros( 1, size( temp_Matrix_of_FingerPrint_DataBank_for_all_Devices, 2 ) );
                                                                                                          ...

                                                                                        ];  

    %% Section 2: YLabel
       YLabel = {   ' ';
                    'mean(Amp. Skewness_a_l_l_s_u_b_R_e_g_s)';
                    'mean(Phase. Skewness_a_l_l_s_u_b_R_e_g_s)';
                    'mean(Freq. Skewness_a_l_l_s_u_b_R_e_g_s)';
                    ' ';
                    'mean(Amp. St.Dev._a_l_l_s_u_b_R_e_g_s)';
                    'mean(Phase. St.Dev._a_l_l_s_u_b_R_e_g_s)';
                    'mean(Freq. St.Dev._a_l_l_s_u_b_R_e_g_s)';
                    ' ';
                    'mean(Amp. Kurtosis_a_l_l_s_u_b_R_e_g_s)';
                    'mean(Phase. Kurtosis_a_l_l_s_u_b_R_e_g_s)';
                    ' ';
                    'mean(Amp. Mean_a_l_l_s_u_b_R_e_g_s)';
                    'mean(Phase. Mean_a_l_l_s_u_b_R_e_g_s)';
                    'mean(Freq. Mean_a_l_l_s_u_b_R_e_g_s)';
                    ' ';
                    };

end