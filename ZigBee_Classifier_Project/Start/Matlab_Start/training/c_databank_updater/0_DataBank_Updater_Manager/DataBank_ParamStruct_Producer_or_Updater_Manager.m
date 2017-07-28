function dataBank_Parameters_Structure = DataBank_ParamStruct_Producer_or_Updater_Manager ( varargin )

    %% Section 1: Extraction of Essential Parameters
        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.KeepUnmatched = true;
        inputSet.addParameter( 'do_You_Want_to_Make_new_DataBank', 0 );                                
        inputSet.addParameter( 'selected_DataBank_Methods', 'Skewness' ); 
                                % selected_DataBank_Methods = { 'Skewness', 'Variance', 'Kurtosis', 'Mean' };
                                % used in: 'Calculation_of_Statistics_for_all_Bursts.m'
        inputSet.addParameter( 'strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix', 'each_Statistics_of_Characteristics_in_Seperate_Rows' );                            
                                % 'all_Statistics_of_the_Same_Characteristics_in_Just_One_Row' or 'each_Statistics_of_Characteristics_in_Seperate_Rows'                                                                  
                                % used in: 'Calculation_of_Statistics_for_all_Bursts.m'
        inputSet.addParameter( 'selected_DataSet_Name', [] );
                                % used in: 'FingerPrint_for_Multi_Devices.m'
        inputSet.addParameter( 'vertical_Cell_of_Characteristics_Names', {'Amplitude_Element', 'Phase_Element','Frequency_Element'} );
                              % vertical_Cell_of_Characteristics_Names = { 'Amplitude_Element', 'Phase_Element','Frequency_Element' };    
        inputSet.addParameter( 'vertical_Cell_of_Statistics_Names', {'Skewness', 'Variance', 'Kurtosis', 'Mean'} );
                              % vertical_Cell_of_Statistics_Names = { 'Skewness', 'Variance', 'Kurtosis', 'Mean' };
        inputSet.addParameter( 'vertical_Structure_of_all_Devices', 'fingerPrint_for_a_Single_Device' );
                              % 'fingerPrint_for_a_Single_Device' or 'statistics_for_a_Single_Device'
        inputSet.parse( varargin{:} );

        do_You_Want_to_Make_new_DataBank                          = inputSet.Results.do_You_Want_to_Make_new_DataBank;
        selected_DataBank_Methods                                 = inputSet.Results.selected_DataBank_Methods;
        strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix = inputSet.Results.strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix; 
        selected_DataSet_Name                                     = inputSet.Results.selected_DataSet_Name;
        vertical_Cell_of_Characteristics_Names                    = inputSet.Results.vertical_Cell_of_Characteristics_Names;
        vertical_Cell_of_Statistics_Names                         = inputSet.Results.vertical_Cell_of_Statistics_Names;
        vertical_Structure_of_all_Devices                         = inputSet.Results.vertical_Structure_of_all_Devices;

        dataBank_Parameters_Structure.do_You_Want_to_Make_new_DataBank                          = do_You_Want_to_Make_new_DataBank;
        dataBank_Parameters_Structure.selected_DataBank_Methods                                 = selected_DataBank_Methods;
        dataBank_Parameters_Structure.strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix = strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix;
        dataBank_Parameters_Structure.selected_DataSet_Name                                     = selected_DataSet_Name;
        dataBank_Parameters_Structure.vertical_Cell_of_Characteristics_Names                    = vertical_Cell_of_Characteristics_Names;
        dataBank_Parameters_Structure.vertical_Cell_of_Statistics_Names                         = vertical_Cell_of_Statistics_Names;
        dataBank_Parameters_Structure.vertical_Structure_of_all_Devices                         = vertical_Structure_of_all_Devices;            

end



    
    