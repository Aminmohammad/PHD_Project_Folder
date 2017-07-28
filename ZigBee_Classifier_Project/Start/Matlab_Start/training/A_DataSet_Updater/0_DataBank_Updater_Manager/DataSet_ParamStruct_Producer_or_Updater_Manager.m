function dataSet_Parameters_Structure = DataSet_ParamStruct_Producer_or_Updater_Manager ( varargin )

    %% Section 1: Extraction of Essential Parameters
        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.KeepUnmatched = true;
        inputSet.addParameter( 'do_You_Want_to_Make_new_DataSet', 0 );
        inputSet.addParameter( 'SelectedDataSetName', '2016_07_11_IQ_20Msps_RZUSBSTICK' );    
        inputSet.addParameter( 'zero_Conversion_Threshold', .7 );
        inputSet.addParameter( 'number_of_subRegion', 32 );
        inputSet.parse( varargin{:} );
        
        SelectedDataSetName             = inputSet.Results.SelectedDataSetName;
        zero_Conversion_Threshold       = inputSet.Results.zero_Conversion_Threshold;
        do_You_Want_to_Make_new_DataSet = inputSet.Results.do_You_Want_to_Make_new_DataSet;
        number_of_subRegion             = inputSet.Results.number_of_subRegion;

        dataSet_Parameters_Structure. do_You_Want_to_Make_new_DataSet = do_You_Want_to_Make_new_DataSet;
        dataSet_Parameters_Structure. SelectedDataSetName             = SelectedDataSetName;
        dataSet_Parameters_Structure. zero_Conversion_Threshold       = zero_Conversion_Threshold;
        dataSet_Parameters_Structure. number_of_subRegion             = number_of_subRegion;
            
        
end



    
    