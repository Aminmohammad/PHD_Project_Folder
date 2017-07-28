function permission_Structure = PermissionStructure_Producer_or_Updater_Manager ( strategy, varargin )

    %% Section 1: Extraction of Essential Parameters
        if   ( strcmp ( strategy, 'initialization' ) )
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter( 'run_Permission_Vector', [ 0 1 1 1 1 ] );                                                                                  
            inputSet.parse( varargin{:} );

            permission_Vector = inputSet.Results.run_Permission_Vector;

            permission_Structure. do_You_Want_the_DataSet_to_Run         = 1;
            permission_Structure. do_You_Want_the_preProc_to_Run         = permission_Vector (1, 1);
            permission_Structure. do_You_Want_the_DataBank_to_Run        = permission_Vector (1, 2);
            permission_Structure. do_You_Want_the_postProc_to_Run        = permission_Vector (1, 3);
            permission_Structure. do_You_Want_the_Classification_to_Run  = permission_Vector (1, 4);
            permission_Structure. do_You_Want_the_Evaluation_to_Run      = permission_Vector (1, 5);

            if ( permission_Vector (1, 3) == 1 )
                 permission_Structure. do_You_Want_the_DataBank_to_Run                                 = 1;

            end

            if ( permission_Vector (1, 4) == 1 )
                permission_Structure. do_You_Want_the_DataBank_to_Run                                  = 1;

            end

            if ( permission_Vector (1, 5) == 1 )
                permission_Structure. do_You_Want_the_DataBank_to_Run                                  = 1;
                permission_Structure. do_You_Want_the_Classification_to_Run                            = 1;

            end 
            
        elseif ( strcmp ( strategy, 'update_for_Evaluation' ) )
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.addParameter( 'run_Permission_Vector', [ 0 1 1 1 1 ] );  
            inputSet.addParameter( 'output_Results', [] );  
            inputSet.parse( varargin{:} );

            run_Permission_Vector = inputSet.Results.run_Permission_Vector;
            output_Results        = inputSet.Results.output_Results;
            
            permission_Structure. do_You_Want_the_DataSet_to_Run                                       = 0;
            permission_Structure. do_You_Want_the_preProc_to_Run                                       = 0;
            permission_Structure. do_You_Want_the_DataBank_to_Run                                      = 0;
            permission_Structure. do_You_Want_the_postProc_to_Run                                      = 0;
            permission_Structure. do_You_Want_the_Classification_to_Run                                = 0;
            permission_Structure. do_You_Want_the_Evaluation_to_Run                                    = run_Permission_Vector (1, 5);
     
        elseif ( strcmp ( strategy, 'update_for_Initialization_in_Application' ) )
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.addParameter( 'run_Permission_Vector', [ 0 1 1 1 1 ] );  
            inputSet.addParameter( 'output_Results', [] );  
            inputSet.parse( varargin{:} );

            run_Permission_Vector = inputSet.Results.run_Permission_Vector;
            output_Results        = inputSet.Results.output_Results;
            
            permission_Structure. do_You_Want_the_DataSet_to_Run                                       = 0;
            permission_Structure. do_You_Want_the_preProc_to_Run                                       = 0;
            permission_Structure. do_You_Want_the_DataBank_to_Run                                      = 0;
            permission_Structure. do_You_Want_the_postProc_to_Run                                      = 1;
            permission_Structure. do_You_Want_the_Classification_to_Run                                = 1;
            permission_Structure. do_You_Want_the_Evaluation_to_Run                                    = run_Permission_Vector (1, 5);
                 
        end
        
end
        