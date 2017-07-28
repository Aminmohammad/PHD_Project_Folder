function output = FaradarsV1_Decision_Tree ( varargin )

    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            
            inputSet.addParameter('training_Inputs', []);
            
            inputSet.addParameter('training_Targets', []);
            
            inputSet.addParameter('testing_Inputs', []);
            
            inputSet.addParameter('application_or_Training', []);            
            
            inputSet.addParameter('selected_Model_Address_for_Application', []);
            
            inputSet.addParameter('Saving_Address', []);
            
            inputSet.parse(varargin{:});

            training_Inputs                          = inputSet.Results.training_Inputs;
            training_Targets                         = inputSet.Results.training_Targets;
            testing_Inputs                           = inputSet.Results.testing_Inputs;
            
            application_or_Training                  = inputSet.Results.application_or_Training; 
            
            selected_Model_Address_for_Application   = inputSet.Results.selected_Model_Address_for_Application;
            Saving_Address                           = inputSet.Results.Saving_Address;
            
    %% Section 1: Training Classifier
        if      ( strcmp ( application_or_Training, 'Training' ) == 1 )
            t = fitctree( training_Inputs, training_Targets );
            save ( [ Saving_Address '\trained_FaradarsV1_Decision_Tree.mat' ], 't' );

            % Stage 1: Training Tree Classifier
                cvmodel          = crossval(t);
                k_Folde_Loss     = kfoldLoss(cvmodel );
                [ training_Outputs, training_Scores ] = predict ( t, training_Inputs );
training_Scores = training_Scores';
        elseif  ( strcmp ( application_or_Training, 'Application' ) == 1 )
            model = load ( selected_Model_Address_for_Application );

            if ( isempty ( fieldnames ( model ) ) == 0 )
                t = model.(char(fieldnames(model)));     

            end

        end                    

    %% Section 2: Testing Classifier
        [ testing_Outputs, testing_Scores ]  = predict ( t, testing_Inputs );
        testing_Scores = testing_Scores';
            
    %% Section 3: Saving and Closing the View Graph        
        view (t, 'mode', 'graph')
        set(0, 'ShowHiddenHandles', 'on');
        handle_of_all_Open_Figures = get(0, 'Children');

        for index = 1 : size ( handle_of_all_Open_Figures, 2 )
        name_of_Current_Figure = handle_of_all_Open_Figures ( index, 1 ).Name;

            if ( strcmp ( name_of_Current_Figure, 'Classification tree viewer' ) == 1 )
                savefig( handle_of_all_Open_Figures ( index, 1 ), [ Saving_Address '\' 'FaradarsV1_Decision_Tree.fig' ] )
                close ( handle_of_all_Open_Figures ( index, 1 ) );
                break;

            end
        end

    %% Section 4: Output from Classifier
        temp_Output = [];
        if      ( strcmp ( application_or_Training, 'Training' ) == 1 )
        temp_Output = { 'training_Outputs', training_Outputs, ...
                        'training_Scores', training_Scores };
            
        end
        
        output = [ temp_Output,                         ...
                   {'testing_Outputs',  testing_Outputs, ...
                    'testing_Scores', testing_Scores }
                 ];  
                   
end

