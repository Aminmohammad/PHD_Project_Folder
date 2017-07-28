function vertical_Structure_of_all_Devices = DataSet_Maker_or_Loader ( varargin )


    %% Section 1: Extraction of Essential Parameters
        [ default_DataSet_Address, ~ ] = Folder_Address_Extractor ( 'PHD_Project_Folder', 'Resources' );
        default_DataSet_Address        = default_DataSet_Address{:};
        default_DataSet_Address        = dir ( default_DataSet_Address );
        default_DataSet_Address        = default_DataSet_Address ( : );
        default_DataSet_Name           = default_DataSet_Address( 3, 1).name;

        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.addParameter( 'do_You_Want_to_Make_new_DataSet', 0 );
        inputSet.addParameter( 'SelectedDataSetName', default_DataSet_Name );    
        inputSet.addParameter( 'zero_Conversion_Threshold', .5 );
        inputSet.addParameter( 'number_of_subRegions', 32 );
        inputSet.parse( varargin{:} );

        selected_DataSet_Name           = inputSet.Results.SelectedDataSetName;
        do_You_Want_to_Make_new_DataSet = inputSet.Results.do_You_Want_to_Make_new_DataSet;
        zero_Conversion_Threshold       = inputSet.Results.zero_Conversion_Threshold;
        number_of_subRegions            = inputSet.Results.number_of_subRegions;

        if ( exist ( [ selected_DataSet_Name '\DataSet\DataSet.mat' ], 'file' ) == 0 ) || ...
                   ( do_You_Want_to_Make_new_DataSet == 1 )
            fprintf ( 'DataSet Making Started ... \n' )   
            DataSet_Maker ( selected_DataSet_Name, zero_Conversion_Threshold, number_of_subRegions );   
            vertical_Structure_of_all_Devices = load ( [ selected_DataSet_Name '\DataSet\DataSet.mat' ] );
            fprintf ( 'DataSet Making Finished! \n' )

        else  
            fprintf ( 'DataSet Loading Started ... \n' ) 
            vertical_Structure_of_all_Devices = load ( [ selected_DataSet_Name '\DataSet\DataSet.mat' ] );
            fprintf ( 'DataSet Loading Finished! \n' )

        end
        
end

%% Section 2: DataSet Making
    function DataSet_Maker ( selected_DataSet_Folder, zero_Conversion_Threshold, number_of_subRegions )

        [ resources_Folder_Address, ~ ] = Folder_Address_Extractor ( 'PHD_Project_Folder', 'Resources' );          
        list_of_Devices = dir ( [ resources_Folder_Address{:} '\' selected_DataSet_Folder '\RawData' ] );
        list_of_Devices = list_of_Devices(:);
        list_of_Devices = list_of_Devices ( 3 : end , 1 );

        for device_Index = 1 : size (list_of_Devices, 1)

            current_Data_Location            = [ resources_Folder_Address{:} '\' selected_DataSet_Folder '\RawData' '\' list_of_Devices(device_Index, 1).name ];

            vertical_Structure_of_all_Bursts = Device_RawData_Loader ( current_Data_Location, zero_Conversion_Threshold, number_of_subRegions );

            vertical_Structure_of_all_Devices ( device_Index, 1 ).device_Index    = device_Index;
            vertical_Structure_of_all_Devices ( device_Index, 1 ).a_Single_Device = vertical_Structure_of_all_Bursts;

        end

        address_of_Saving_DataSet       =      sprintf ( '%s%s%s%s', resources_Folder_Address{:}, '\', selected_DataSet_Folder, '\DataSet\DataSet.mat' );
        save( address_of_Saving_DataSet, 'vertical_Structure_of_all_Devices')

    end



    
    