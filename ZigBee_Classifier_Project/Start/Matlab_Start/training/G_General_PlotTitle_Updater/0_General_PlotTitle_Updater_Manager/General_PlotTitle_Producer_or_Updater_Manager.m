function general_PlotTitle = General_PlotTitle_Producer_or_Updater_Manager ( varargin )

    %% Section 1: Extraction of Essential Parameters
        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.KeepUnmatched = true; 
        inputSet.addParameter( 'dataSet_Parameters_Structure', '2016_07_11_IQ_20Msps_RZUSBSTICK' );
        inputSet.addParameter( 'preProc_Parameters_Structure', [] );
        inputSet.addParameter( 'dataBank_Parameters_Structure', [] );
        inputSet.addParameter( 'postProc_Parameters_Structure', [] );
        inputSet.addParameter( 'classification_Parameters_Structure', [] );
        inputSet.addParameter( 'evaluation_Parameters_Structure', [] );        
        inputSet.addParameter( 'horizontal_Vector_of_all_Selected_Evaluation_Methods', [] );                                                                                   
        inputSet.parse( varargin{:} );
        
        dataSet_Parameters_Structure                         = inputSet.Results.dataSet_Parameters_Structure;
        preProc_Parameters_Structure                         = inputSet.Results.preProc_Parameters_Structure;
        dataBank_Parameters_Structure                        = inputSet.Results.dataBank_Parameters_Structure;
        postProc_Parameters_Structure                        = inputSet.Results.postProc_Parameters_Structure;
        classification_Parameters_Structure                  = inputSet.Results.classification_Parameters_Structure;
        evaluation_Parameters_Structure                      = inputSet.Results.evaluation_Parameters_Structure;

        if ( isfield(preProc_Parameters_Structure, 'selected_preFeatureGeneration_Method') == 1 )
            temp_1 = preProc_Parameters_Structure.selected_preFeatureGeneration_Method;
            
        else
            temp_1= [];
            
        end
                                   
        part_1 = [  'DataSet Name: '                                                                              , ...
                    char(dataSet_Parameters_Structure. SelectedDataSetName) ' -- '                           , ...
                    'preFeature Method: '                                                                              , ...
                    temp_1 ' -- '                           , ...
                    'FingerPrint Method: '                                                                             , ...
                    char(dataBank_Parameters_Structure.selected_DataBank_Methods) ' -- '   ];

        part_2 = [  'postFeature Method: '                                                                             , ...
                    postProc_Parameters_Structure.selected_postFeatureGeneration_Method, ' -- '                        ];

        temp = [];        
        temp_1 = evaluation_Parameters_Structure.selected_Evaluation_Methods_for_GeneralPlotTitle;
        temp_1 = temp_1{:};

        for index = 1 : size ( temp_1, 2 ) 
            temp_2 = temp_1 ( 1, index );
            temp = [ temp sprintf( '%s, ', char(temp_2 ))];

        end
        temp = temp (1, 1 : end - 2 );

        part_3 = [  'Class. Method: '                                                                                  , ...
                    classification_Parameters_Structure.selected_Classification_Method, ' -- '                         , ...
                    'Eval. Method(s): '                                                                                   , ...
                    temp, '.'                                   , ...
                    ];   

        if size ( part_1, 2 ) >= size ( part_2, 2 )
            difference            = size ( part_1, 2 ) - size ( part_2, 2 );
            left_Space            = floor ( difference/ 2 );
            right_Space           = difference - left_Space;
            additional_Left_Part  = repmat ( ' ', 1, left_Space );
            additional_Right_Part = repmat ( ' ', 1, right_Space );

            part_2                = [ additional_Left_Part part_2 additional_Right_Part ];

        else
            difference            = size ( part_2, 2 ) - size ( part_1, 2 );
            left_Space            = floor ( difference/ 2 );
            right_Space           = difference - left_Space;
            additional_Left_Part  = repmat ( ' ', 1, left_Space );
            additional_Right_Part = repmat ( ' ', 1, right_Space );
            part_1                = [ additional_Left_Part part_1 additional_Right_Part ];

        end

        part_2 = [ part_1; part_2 ];

        if size ( part_3, 2 ) >= size ( part_2, 2 )
            difference            = size ( part_3, 2 ) - size ( part_2, 2 );
            left_Space            = floor ( difference/ 2 );
            right_Space           = difference - left_Space;
            additional_Left_Part  = repmat ( ' ', 2, left_Space );
            additional_Right_Part = repmat ( ' ', 2, right_Space );

            part_2                = [ additional_Left_Part part_2 additional_Right_Part ];

        else
            difference            = size ( part_2, 2 ) - size ( part_3, 2 );
            left_Space            = floor ( difference/ 2 );
            right_Space           = difference - left_Space;
            additional_Left_Part  = repmat ( ' ', 1, left_Space );
            additional_Right_Part = repmat ( ' ', 1, right_Space );
            part_3                = [ additional_Left_Part part_3 additional_Right_Part ]; %#ok<*AGROW>

        end            

        general_PlotTitle = [ part_2; part_3 ];               
            
end



    
    