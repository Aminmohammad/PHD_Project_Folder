function output = ResubLoss( varargin )

% output.classification_Rate_for_all_Devices_for_RoundedClamped || output.misClassification_Rate_for_all_Devices_for_RoundedClamped:
%
%                  'Class 1' 'Class 2' 'Class 3' ... 
%                __                                __
%   Class 1     |                                   |
%   Class 2     |                                   |           
%   Class 3     |                                   |
%     .         |                                   |
%     .         |                                   |
%     .         |_                                 _|

% output.overall_Classification_Rate_for_RoundedClamped || output.overall_mislassification_Rate_for_RoundedClamped
%
%                            scalar

    %% Section 0: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter('classLabels_from_Net', []);
            inputSet.addParameter('classLabels_from_Original_or_ReducedForApplication_DataBank', []);  
            inputSet.addParameter('number_of_Devices_from_Original_DataBank', []);
            inputSet.addParameter('number_of_Bursts_for_Classified_Devices', []);
            inputSet.addParameter('selected_Indices_of_Devices', []);
            inputSet.addParameter('type_of_Data', []);  
            inputSet.addParameter('general_PlotTitle', []);        
            inputSet.addParameter('application_or_Training', []);
            
            inputSet.parse(varargin{:});

            classLabels_from_Net                                        = inputSet.Results.classLabels_from_Net;
            classLabels_from_Original_or_ReducedForApplication_DataBank = inputSet.Results.classLabels_from_Original_or_ReducedForApplication_DataBank;
            number_of_Devices_from_Original_DataBank                    = inputSet.Results.number_of_Devices_from_Original_DataBank;
            general_PlotTitle                                           = inputSet.Results.general_PlotTitle;
            type_of_Data                                                = inputSet.Results.type_of_Data;
            application_or_Training                                     = inputSet.Results.application_or_Training;
            selected_Indices_of_Devices                                 = inputSet.Results.selected_Indices_of_Devices;
            number_of_Bursts_for_Classified_Devices                     = inputSet.Results.number_of_Bursts_for_Classified_Devices;
           
            if    ( isempty( classLabels_from_Net ) == 1 )        
                error ( 'You should Enter the "classLabels from Net" for evaluation of "Confusion Matrix".' );

            elseif    ( isempty( classLabels_from_Original_or_ReducedForApplication_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for evaluation of "Confusion Matrix".' );

            end       
            
   %% Section 1: Calculation of "Rates" and "Losses"
            classLabels_from_Net                                        = [classLabels_from_Net.roundedClamped_Output];
            classLabels_from_Net                                        = classLabels_from_Net ( : )';                                             
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';             

            % Sorting the ClassLabels ( for the case that bursts of devices are not in order)
                [ ~, sorting_Indices ] = sort( classLabels_from_Original_or_ReducedForApplication_DataBank );
                classLabels_from_Net   = classLabels_from_Net ( :, sorting_Indices);
            
    %% Section 2: Calculation of "Rates" and "Losses"
            varargin = [ varargin { 'permission_for_Printing_the_Results', 0 } ];

            confusion_Output                                = Confusion_Matrix( varargin{:} );
            confusion_Matrix_for_RoundedClamped             = confusion_Output. confusion_Matrix_for_RoundedClamped;
            confusion_Probability_Matrix_for_RoundedClamped = confusion_Output. confusion_Probability_Matrix_for_RoundedClamped;

            % Level 1: Formation of "Classification Rate"
                number_of_Classified_Devices = size ( number_of_Bursts_for_Classified_Devices, 2 );
                if     ( strcmp ( application_or_Training, 'Application' ) == 1 )
                    unique_all_ClassLabels_form_Original_DataBank   = 1 : number_of_Devices_from_Original_DataBank;

                    for index = 1 : number_of_Classified_Devices
                        label_of_Current_Classified_Device = selected_Indices_of_Devices ( 1, index );

                        temp ( index, index ) = confusion_Probability_Matrix_for_RoundedClamped ( index, ( label_of_Current_Classified_Device == unique_all_ClassLabels_form_Original_DataBank ) );

                    end
                elseif ( strcmp ( application_or_Training, 'Training' )    == 1 )
                    
                    if ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 )
                        temp = diag ( diag ( confusion_Probability_Matrix_for_RoundedClamped ) );
                    
                    elseif ( strcmp ( type_of_Data, '(Test_Data)' ) == 1 )                    
                        unique_all_ClassLabels_form_Original_DataBank   = unique ( [ selected_Indices_of_Devices unique(classLabels_from_Net) ] );
                        
                        for index = 1 : number_of_Classified_Devices
                            label_of_Current_Classified_Device = selected_Indices_of_Devices ( 1, index );
                            
                            temp ( index, index ) = confusion_Probability_Matrix_for_RoundedClamped ( index, ( label_of_Current_Classified_Device == unique_all_ClassLabels_form_Original_DataBank ) );

                        end

                    end
                    
                end                    
                output.classification_Rate_for_all_Devices_for_RoundedClamped = temp;

            % Level 2: Formation of "mis-Classification Rate" 
                temp = diag ( 1 - diag ( [output.classification_Rate_for_all_Devices_for_RoundedClamped] ) );
                    
                output.misClassification_Rate_for_all_Devices_for_RoundedClamped = temp;
                
            % Level 3: Formation of "overall Classification Rate" 
                if     ( strcmp ( application_or_Training, 'Application' ) == 1 )  
                    temp = zeros(number_of_Classified_Devices, number_of_Classified_Devices);
                    for index = 1 : number_of_Classified_Devices
                        label_of_Current_Classified_Device = selected_Indices_of_Devices ( 1, index );

                        temp ( index, index ) = confusion_Matrix_for_RoundedClamped ( index, ( label_of_Current_Classified_Device == unique_all_ClassLabels_form_Original_DataBank ) );
                                                 
                    end
                    unique_all_ClassLabels_form_Original_DataBank = selected_Indices_of_Devices;
                    
                elseif ( strcmp ( application_or_Training, 'Training' )    == 1 )
                    if ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 )
                        temp = diag ( diag ( confusion_Matrix_for_RoundedClamped ) );
                    
                    elseif ( strcmp ( type_of_Data, '(Test_Data)' ) == 1 )                    
                        unique_all_ClassLabels_form_Original_DataBank   = unique ( [ selected_Indices_of_Devices unique(classLabels_from_Net) ] );
                        
                        for index = 1 : number_of_Classified_Devices
                            label_of_Current_Classified_Device = selected_Indices_of_Devices ( 1, index );
                            
                            temp ( index, index ) = confusion_Matrix_for_RoundedClamped ( index, ( label_of_Current_Classified_Device == unique_all_ClassLabels_form_Original_DataBank ) );

                        end
                        
                        unique_all_ClassLabels_form_Original_DataBank = selected_Indices_of_Devices;
                    end
                end

                output.overall_Classification_Rate_for_RoundedClamped = sum ( sum(temp) )/sum(number_of_Bursts_for_Classified_Devices);

            % Level 4: Formation of "overall mis-Classification Rate" 
                output.overall_misclassification_Rate_for_RoundedClamped = 1 - [ output.overall_Classification_Rate_for_RoundedClamped ];                                
                          
    %% Section 3: Printing the "Rates" and "Losses"
            temp_1 = [output.classification_Rate_for_all_Devices_for_RoundedClamped ];
            temp_2 = [output.misClassification_Rate_for_all_Devices_for_RoundedClamped ];
            temp_3 = [output.overall_Classification_Rate_for_RoundedClamped ];
            temp_4 = output.overall_misclassification_Rate_for_RoundedClamped;
            
            if  ( ( strcmp ( application_or_Training, 'Training' ) == 1 ) && ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 ) )  ||  ...
                ( strcmp ( application_or_Training, 'Application' ) == 1 )
                disp( ' ' )
                disp( ' ' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                    fprintf ( '                     ResubLoss Matrices Resuls (%s)\n', application_or_Training );
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( '|-------------------------------------------------------------------------|' )
                disp( ' ' )
                disp( ' ' )

                disp(general_PlotTitle)
                disp( ' ' )
                
            end
            
            % Stage 1: Showing the "Number of Devices" wich was classified with their "Labels"
                disp( '-------------------------------------------------------------------------' )
                    fprintf ( '  The "Numbers" and "Data-Points" of Devices that are classified Here. %s\n', type_of_Data );
                disp( '-------------------------------------------------------------------------' )

                for index = 1 : number_of_Classified_Devices
                    row_Titles ( 1, index ) = {sprintf( 'Device_%d', selected_Indices_of_Devices ( 1, index ) )};

                    number_of_DataPoints_of_all_Devices_that_are_Classified ( 1, index ) = sum ( classLabels_from_Original_or_ReducedForApplication_DataBank == selected_Indices_of_Devices ( 1, index ) );

                end            
                T                       = table;
                T. classified_Devices   = row_Titles';
                T. number_of_DataPoints = number_of_DataPoints_of_all_Devices_that_are_Classified';
                disp(T)                        

            if     ( strcmp ( application_or_Training, 'Training' ) == 1 ) && ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 )
                unique_all_ClassLabels_form_Original_DataBank   = selected_Indices_of_Devices;

            end
            
            for index = 1 : size ( unique_all_ClassLabels_form_Original_DataBank, 2 )
                column_Titles ( 1, index ) = {sprintf( 'Device_%d', unique_all_ClassLabels_form_Original_DataBank ( 1, index ) )};
                
            end           
            
            disp( '-------------------------------------------------------------------------' )
            fprintf ( '  Classification Rate for all Devices for RoundedClamped %s\n', type_of_Data );
            disp( '-------------------------------------------------------------------------' )
            T = table;
            T. classified_Devices = row_Titles';
            for column_Title_Index = 1 : size ( column_Titles, 2 )      
                T. ( char ( column_Titles ( 1, column_Title_Index ) ) ) = temp_1 ( :, column_Title_Index );

            end
            disp(T)
            disp( '-------------------------------------------------------------------------' )
            fprintf ( '  mis-Classification Rate for all Devices for RoundedClamped %s\n', type_of_Data );
            disp( '-------------------------------------------------------------------------' )
            T = table;
            T. classified_Devices = row_Titles';
            for column_Title_Index = 1 : size ( column_Titles, 2 )      
                T. ( char ( column_Titles ( 1, column_Title_Index ) ) ) = temp_2 ( :, column_Title_Index );

            end
            disp(T)
            disp( '-------------------------------------------------------------------------' )
            fprintf ( '  Overall Classification Rate for RoundedClamped %s\n', type_of_Data );
            disp( '-------------------------------------------------------------------------' )
            fprintf( '%3.3f\n', temp_3 );
            fprintf( '= sum (number of correctly classified Data-Points for each device) / (number of all Data-Points in Data_Bank)\n= %3.3f\n', temp_3 );
            disp( '-------------------------------------------------------------------------' )
            fprintf ( '  Overall mis-Classification Rate for RoundedClamped %s\n', type_of_Data );
            disp( '-------------------------------------------------------------------------' )
            fprintf( '= 1 - Overall Classification Rat = sum (number of incorrectly classified Data-Points for each device) / (number of all Data-Points in Data_Bank)\n= %3.3f\n', temp_4 );
            disp( '-------------------------------------------------------------------------' )
            disp( '-------------------------------------------------------------------------' )
            disp( '-------------------------------------------------------------------------' )
  
end

