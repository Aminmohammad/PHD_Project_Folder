function Matrix_for_InitialDataBank_FingerPrintPlot_Producer_Manager (  matrix_of_FingerPrint_DataBank_for_all_Devices,            ...
                                                                        selected_DataSet_Name,                                     ...
                                                                                                                                   ...
                                                                        selected_Indices_of_Devices,            ...                       
                                                                        number_of_Bursts_for_all_of_Devices,                       ...
                                                                        general_PlotTitle,                                         ...
                                                                                                                                   ...
                                                                        selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String, ...
                                                                        selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String, ...                                                           
                                                                        number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,     ...
                                                                        number_of_Added_Zeros_Between_Devices,                     ...
                                                                        application_or_Training                                    ...
                                                                     )
       
                                                                                    
% for a Single Device (Matrix)
    % 'all_Statistics_of_the_Same_Characteristics_in_Just_One_Row'
    %              --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    % Amplitude:   | Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33        ...            Skewness_of_Amplitude_Element_1       Variance_of_Amplitude_Element_1        Kurtosis_of_Amplitude_Element_1        Mean_of_Amplitude_Element_1        ...        Skewness_of_Amplitude_Element_33       Variance_of_Amplitude_Element_33        Kurtosis_of_Amplitude_Element_33        Mean_of_Amplitude_Element_33 |                   
    % Phase:       | Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33            ...            Skewness_of_Phase_Element_1           Variance_of_Phase_Element_1            Kurtosis_of_Phase_Element_1            Mean_of_Phase_Element_1            ...        Skewness_of_Phase_Element_33           Variance_of_Phase_Element_33            Kurtosis_of_Phase_Element_33            Mean_of_Phase_Element_33     |                       
    % Frequency:   | Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33        ...            Skewness_of_Frequency_Element_1       Variance_of_Frequency_Element_1        Kurtosis_of_Frequency_Element_1        Mean_of_Frequency_Element_1        ...        Skewness_of_Frequency_Element_33       Variance_of_Frequency_Element_33        Kurtosis_of_Frequency_Element_33        Mean_of_Frequency_Element_33 |      
    %              -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
    %              |                                                                    subRegion_1                                                                     |   ...    |                                                                        subRegion_33                                                                     |    ...     |                                                                    subRegion_1                                                                     |   ...    |                                                                        subRegion_33                                                                       |                                                                                                                                                                                  
    %              ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    %              |                                                                                                                                                       Burst_1                                                                                                                                                           |    ...     |                                                                                                                                                       Burst_N                                                                                                                                                             |
    %              ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                      

    % or:                            
    % 'each_Statistics_of_Characteristics_in_Seperate_Rows'
    %---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    %              | Skewness_of_Amplitude_Element_1           ...        Skewness_of_Amplitude_Element_33 |         ...         | Skewness_of_Amplitude_Element_1           ...        Skewness_of_Amplitude_Element_33 |       
    % Amplitude:   | Variance_of_Amplitude_Element_1           ...        Variance_of_Amplitude_Element_33 |         ...         | Variance_of_Amplitude_Element_1           ...        Variance_of_Amplitude_Element_33 |
    %              | Kurtosis_of_Amplitude_Element_1           ...        Kurtosis_of_Amplitude_Element_33 |         ...         | Kurtosis_of_Amplitude_Element_1           ...        Kurtosis_of_Amplitude_Element_33 |
    %              | Mean_of_Amplitude_Element_1               ...        Mean_of_Amplitude_Element_33     |         ...         | Mean_of_Amplitude_Element_1               ...        Mean_of_Amplitude_Element_33     |
    %--------------|                                                                                       |         ...         |                                                                                       |
    %              | Skewness_of_Phase_Element_1               ...        Skewness_of_Phase_Element_33     |         ...         | Skewness_of_Phase_Element_1               ...        Skewness_of_Phase_Element_33     |                                                                
    % Phase:       | Variance_of_Phase_Element_1               ...        Variance_of_Phase_Element_33     |         ...         | Variance_of_Phase_Element_1               ...        Variance_of_Phase_Element_33     |        
    %              | Kurtosis_of_Phase_Element_1               ...        Kurtosis_of_Phase_Element_33     |         ...         | Kurtosis_of_Phase_Element_1               ...        Kurtosis_of_Phase_Element_33     |       
    %              | Mean_of_Phase_Element_1                   ...        Mean_of_Phase_Element_33         |         ...         | Mean_of_Phase_Element_1                   ...        Mean_of_Phase_Element_33         |       
    %--------------|                                                                                       |         ...         |                                                                                       |
    %              | Skewness_of_Frequency_Element_1           ...        Skewness_of_Frequency_Element_33 |         ...         | Skewness_of_Frequency_Element_1           ...        Skewness_of_Frequency_Element_33 |                             
    % Frequency:   | Variance_of_Frequency_Element_1           ...        Variance_of_Frequency_Element_33 |         ...         | Variance_of_Frequency_Element_1           ...        Variance_of_Frequency_Element_33 |       
    %              | Kurtosis_of_Frequency_Element_1           ...        Kurtosis_of_Frequency_Element_33 |         ...         | Kurtosis_of_Frequency_Element_1           ...        Kurtosis_of_Frequency_Element_33 |         
    %              | Mean_of_Frequency_Element_1               ...        Mean_of_Frequency_Element_33     |         ...         | Mean_of_Frequency_Element_1               ...        Mean_of_Frequency_Element_33     |        
    %---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    %              |         subRegion_1                   |   ...    |            subRegion_33            |         ...         |         subRegion_1                   |   ...    |            subRegion_33            |                                                                                                                                                                                  
    %---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    %              |                                          Burst_1                                      |                                                                Burst_N                                      |
    %---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    % or
    % 'all_Statistics_of_all_Characteristics_in_Just_One_Column'
    %------------------------------------------------------------------------------------------------------------------------------------------------------------
    %              |                 |  Skewness_of_Amplitude_Element_1   |      ...      |                 |  Skewness_of_Amplitude_Element_1   |    
    %              |                 |  Variance_of_Amplitude_Element_1   |      ...      |                 |  Variance_of_Amplitude_Element_1   |
    %              |  sub-Region 1:  |  Kurtosis_of_Amplitude_Element_1   |      ...      |  sub-Region 1:  |  Kurtosis_of_Amplitude_Element_1   |
    %              |                 |  Mean_of_Amplitude_Element_1       |      ...      |                 |  Mean_of_Amplitude_Element_1       |
    %              |-----------------|                                    |      ...      |-----------------|                                    | 
    % Amplitude:   |        .        |             .                      |      ...      |        .        |             .                      |                    
    %              |        .        |             .                      |      ...      |        .        |             .                      |    
    %              |        .        |             .                      |      ...      |        .        |             .                      | 
    %              |-----------------|  Skewness_of_Amplitude_Element_33  |      ...      |-----------------|  Skewness_of_Amplitude_Element_33  | 
    %              |                 |  Variance_of_Amplitude_Element_33  |      ...      |                 |  Variance_of_Amplitude_Element_33  | 
    %              |  sub-Region 33: |  Kurtosis_of_Amplitude_Element_33  |      ...      |  sub-Region 33: |  Kurtosis_of_Amplitude_Element_33  | 
    %              |                 |  Mean_of_Amplitude_Element_33      |      ...      |                 |  Mean_of_Amplitude_Element_33      |                 
    %--------------|-----------------|                                    |      ...      |-----------------|                                    |              
    %              |                 |  Skewness_of_Phase_Element_1       |      ...      |                 |  Skewness_of_Phase_Element_1       |                                                             
    %              |  sub-Region 1:  |  Variance_of_Phase_Element_1       |      ...      |  sub-Region 1:  |  Variance_of_Phase_Element_1       |       
    %              |                 |  Kurtosis_of_Phase_Element_1       |      ...      |                 |  Kurtosis_of_Phase_Element_1       |      
    %              |                 |  Mean_of_Phase_Element_1           |      ...      |                 |  Mean_of_Phase_Element_1           |      
    %              |-----------------|                                    |      ...      |-----------------|                                    |
    %    Phase:    |        .        |             .                      |      ...      |        .        |             .                      |               
    %              |        .        |             .                      |      ...      |        .        |             .                      | 
    %              |        .        |             .                      |      ...      |        .        |             .                      | 
    %              |-----------------|  Skewness_of_Phase_Element_33      |      ...      |-----------------|  Skewness_of_Phase_Element_33      | 
    %              |                 |  Variance_of_Phase_Element_33      |      ...      |                 |  Variance_of_Phase_Element_33      | 
    %              |  sub-Region 33: |  Kurtosis_of_Phase_Element_33      |      ...      |  sub-Region 33: |  Kurtosis_of_Phase_Element_33      | 
    %              |                 |  Mean_of_Phase_Element_33          |      ...      |                 |  Mean_of_Phase_Element_33          |                
    %--------------|-----------------|                                    |      ...      |-----------------|                                    |                                                   |
    %              |                 |  Skewness_of_Frequency_Element_1   |      ...      |                 |  Skewness_of_Frequency_Element_1   |                      
    %              |  sub-Region 1:  |  Variance_of_Frequency_Element_1   |      ...      |  sub-Region 1:  |  Variance_of_Frequency_Element_1   |
    %              |                 |  Kurtosis_of_Frequency_Element_1   |      ...      |                 |  Kurtosis_of_Frequency_Element_1   |
    %              |                 |  Mean_of_Frequency_Element_1       |      ...      |                 |  Mean_of_Frequency_Element_1       |
    %              |-----------------|                                    |      ...      |-----------------|                                    | 
    %  Frequency:  |        .        |             .                      |      ...      |        .        |             .                      |               
    %              |        .        |             .                      |      ...      |        .        |             .                      |
    %              |        .        |             .                      |      ...      |        .        |             .                      |
    %              |-----------------|  Skewness_of_Frequency_Element_33  |      ...      |-----------------|  Skewness_of_Frequency_Element_33  | 
    %              |                 |  Variance_of_Frequency_Element_33  |      ...      |                 |  Variance_of_Frequency_Element_33  | 
    %              |  sub-Region 33: |  Kurtosis_of_Frequency_Element_33  |      ...      |  sub-Region 33: |  Kurtosis_of_Frequency_Element_33  | 
    %              |                 |  Mean_of_Frequency_Element_33      |      ...      |                 |  Mean_of_Frequency_Element_33      |                  
    %--------------------------------------------------------------------------------------------------------------------------------------------| 
    %                           Burst 1                                   |      ...      |                    Burst N                           |
    %--------------------------------------------------------------------------------------------------------------------------------------------|                             



    %% Section 1: Lading the Data
        % Level 1: Extraction of the Address of 'DataBank Folder' and 'Single_Burst_Strategy_for_FPPlot.txt'
            [ default_DataBank_Address, ~ ] = Folder_Address_Extractor ( 'PHD_Project_Folder', 'Resources' );
            resources_Folder_Address        = default_DataBank_Address{:};
            default_DataBank_Address        = default_DataBank_Address{:};
            default_DataBank_Address        = dir ( default_DataBank_Address );
            default_DataBank_Address        = default_DataBank_Address ( : );
            default_DataSet_Name            = default_DataBank_Address( 3, 1).name;

            address_of_Loading_FPPlot_Strategy                        = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\Single_Burst_Strategy_for_FPPlot.txt' ];  
            address_of_Loading_Cell_of_FieldNames_for_all_Devices     = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\cell_of_FieldNames_for_all_Devices.mat' ]; 
            address_of_Loading_Lenght_of_a_Single_subRegion           = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\lenght_of_a_Single_subRegion.mat' ];            
            address_of_Loading_Lengths_Matrix_for_all_Devices         = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\lengths_Matrix_for_all_Devices.mat' ];            
            address_of_Loading_Number_of_bursts_for_all_Devices       = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\number_of_bursts_for_all_Devices.mat' ];            
            address_of_Loading_Number_of_Devices                      = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\number_of_Devices.mat' ];            
            address_of_Loading_Number_of_subRegions_in_a_Single_Burst = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\number_of_subRegions_in_a_Single_Burst.mat' ];            
            address_of_Loading_Vertical_Cell_of_Characteristics_Names = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\vertical_Cell_of_Characteristics_Names.mat' ];            
            address_of_Loading_Vertical_Cell_of_Statistics_Names      = [ resources_Folder_Address   '\' selected_DataSet_Name '\DataBank\vertical_Cell_of_Statistics_Names.mat' ];            

        % Level 2: Loading the Data
            FPPlot_Strategy                        = importdata(address_of_Loading_FPPlot_Strategy);
            lenght_of_a_Single_subRegion           = importdata(address_of_Loading_Lenght_of_a_Single_subRegion);
            lengths_Matrix_for_all_Devices         = importdata(address_of_Loading_Lengths_Matrix_for_all_Devices);
            number_of_bursts_for_all_Devices       = importdata(address_of_Loading_Number_of_bursts_for_all_Devices);
            loading_Number_of_Devices              = importdata(address_of_Loading_Number_of_Devices);
            number_of_subRegions_in_a_Single_Burst = importdata(address_of_Loading_Number_of_subRegions_in_a_Single_Burst);
            vertical_Cell_of_Characteristics_Names = importdata(address_of_Loading_Vertical_Cell_of_Characteristics_Names);
            vertical_Cell_of_Statistics_Names      = importdata(address_of_Loading_Vertical_Cell_of_Statistics_Names);
            cell_of_FieldNames_for_all_Devices     = importdata(address_of_Loading_Cell_of_FieldNames_for_all_Devices);

            number_of_Characteristics = size ( vertical_Cell_of_Characteristics_Names, 1 );
            number_of_Statistics      = size ( vertical_Cell_of_Statistics_Names, 1 );

    %% Section 2: Lading the 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot' && 'YLabel'       
        if      ( strcmp ( FPPlot_Strategy, 'all_Statistics_of_all_Characteristics_in_Just_One_Column' ) == 1 )                        
            output_Stricture = FPM_for_all_Statistics_of_all_Characteristics_in_Just_One_Column (  matrix_of_FingerPrint_DataBank_for_all_Devices, ...
                                                                                                   cell_of_FieldNames_for_all_Devices,             ...
                                                                                                   number_of_bursts_for_all_Devices,               ...
                                                                                                                                                   ...
                                                                                                   selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String, ...
                                                                                                   selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String, ...
                                                                                                                                                   ...
                                                                                                   vertical_Cell_of_Characteristics_Names,         ...
                                                                                                   vertical_Cell_of_Statistics_Names,              ...
                                                                                                   selected_Indices_of_Devices,       ...
                                                                                                   application_or_Training                         ...
                                                                                                   );                    

        elseif  ( strcmp ( FPPlot_Strategy, 'all_Statistics_of_the_Same_Characteristics_in_Just_One_Row' ) == 1 )
            % To Do Here     
            matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [];

        elseif  ( strcmp ( FPPlot_Strategy, 'each_Statistics_of_Characteristics_in_Seperate_Rows' ) == 1 )
            % To Do Here   
            matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [];
            
        else
            matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [];

        end
      
    %% Section 3: Editing the 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot' && Loading 'XLabel' and 'indices_of_Seperations_in_X_for_XTickLabels' && 'indices_of_Seperations_in_Y' and 'indices_of_Accumulation_in_Y '               
        field_Names = fieldnames ( output_Stricture );
        for field_Names_Index =  1 : size ( field_Names, 1 )
            % Level 1: 'Zero_Adder_and_XLabel_YLabelndices_Extractor'

                temp = output_Stricture.(char(field_Names( field_Names_Index, 1 )));

                temp_Fields = fieldnames ( temp );
                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = temp.(char(( temp_Fields(1,1) )));
                YLabel                                                    = temp.(char(( temp_Fields(2,1) )));
                
                if     ( strcmp ( application_or_Training, 'Training' ) == 1 )
                    [ matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, XLabel, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y ] = Zero_Adder_and_XLabel_YLabelndices_Extractor (   matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, ...
                                                                                                                                                                                                                                                                                                     selected_Indices_of_Devices,            ...
                                                                                                                                                                                                                                                                                                     number_of_Bursts_for_all_of_Devices,                       ...
                                                                                                                                                                                                                                                                                                     YLabel,                                                    ...
                                                                                                                                                                                                                                                                                                     number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,     ...
                                                                                                                                                                                                                                                                                                     number_of_Added_Zeros_Between_Devices                      ...
                                                                                                                                                                                                                                                                                                     );
                                                                                                                                                                                                                                                                                                 
                elseif ( strcmp ( application_or_Training, 'Application' ) == 1 )
                     [ matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, XLabel, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y ] = Zero_Adder_and_XLabel_YLabelndices_Extractor (  matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, ...
                                                                                                                                                                                                                                                                                                     selected_Indices_of_Devices,                  ...
                                                                                                                                                                                                                                                                                                     number_of_Bursts_for_all_of_Devices,                       ...
                                                                                                                                                                                                                                                                                                     YLabel,                                                    ...
                                                                                                                                                                                                                                                                                                     number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,     ...
                                                                                                                                                                                                                                                                                                     number_of_Added_Zeros_Between_Devices                      ...
                                                                                                                                                                                                                                                                                                     );
                                                                                                                                                                                                                                                          
                end
                
            % Level 2: Plotting the Graph
                special_PlotTitle = [ 'Data FingerPrint before PostProcessing --> ' char(field_Names( field_Names_Index, 1 )) ];
                FingerPrint_Graph ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, XLabel, YLabel, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y, general_PlotTitle, special_PlotTitle );

        end

end