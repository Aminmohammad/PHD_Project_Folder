function output = Confusion_Matrix( varargin )

% output.confusion_Matrix || output.confusion_Probability_Matrix:
%
%                  labels from Net
%                __              __
%    labels      |                |
%    from        |                |            
%    DataBank    |                |
%                |_              _|

  %% Section 0: Preliminaries

    %% Section 1: Extraction of Essential Parameters
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
            
            inputSet.addParameter('permission_for_Printing_the_Results', 1); % Optional
            
            inputSet.parse(varargin{:});

            classLabels_from_Net                                        = inputSet.Results.classLabels_from_Net;
            classLabels_from_Original_or_ReducedForApplication_DataBank = inputSet.Results.classLabels_from_Original_or_ReducedForApplication_DataBank;
            number_of_Devices_from_Original_DataBank                    = inputSet.Results.number_of_Devices_from_Original_DataBank;
            general_PlotTitle                                           = inputSet.Results.general_PlotTitle;
            type_of_Data                                                = inputSet.Results.type_of_Data;
            application_or_Training                                     = inputSet.Results.application_or_Training;
            selected_Indices_of_Devices                                 = inputSet.Results.selected_Indices_of_Devices;
            number_of_Bursts_for_Classified_Devices                     = inputSet.Results.number_of_Bursts_for_Classified_Devices;
            permission_for_Printing_the_Results                         = inputSet.Results.permission_for_Printing_the_Results;
           
            if    ( isempty( classLabels_from_Net ) == 1 )        
                error ( 'You should Enter the "classLabels from Net" for evaluation of "Confusion Matrix".' );

            elseif    ( isempty( classLabels_from_Original_or_ReducedForApplication_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for evaluation of "Confusion Matrix".' );

            end          

        % Level 2: Converting the 'classLabels_from_Net' and 'classLabels_from_DataBank' to 'Horizontal Vactors'
            classLabels_from_Net                                        = [classLabels_from_Net.roundedClamped_Output];
            classLabels_from_Net                                        = classLabels_from_Net ( : )';                                            
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';             

            % Sorting the ClassLabels ( for the case that bursts of devices are not in order)
                [ ~, sorting_Indices ]                                      = sort ( classLabels_from_Original_or_ReducedForApplication_DataBank );
                classLabels_from_Net                                        = classLabels_from_Net ( :, sorting_Indices);
                classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( :, sorting_Indices);

    %% Section 1: Calculation of Confusion Matrix
        % Level 1: Extracting the Labels of Devices in the DataBank
            if     ( strcmp ( application_or_Training, 'Training' ) == 1 )
                
                if ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 )
                    unique_all_ClassLabels_form_Original_DataBank   = selected_Indices_of_Devices;
                    
                elseif ( strcmp ( type_of_Data, '(Test_Data)' ) == 1 )                    
                    unique_all_ClassLabels_form_Original_DataBank   = unique ( [ selected_Indices_of_Devices unique(classLabels_from_Net) ] );
                    
                end
                
            elseif ( strcmp ( application_or_Training, 'Application' ) == 1 )
               unique_all_ClassLabels_form_Original_DataBank   = 1 : number_of_Devices_from_Original_DataBank;

            end

        % Level 2: Formation of "Confusion Matrix"       
            number_of_Classified_Devices = size ( number_of_Bursts_for_Classified_Devices, 2 );
            for classified_Device_Index = 1 : number_of_Classified_Devices
                
                starting_Index =  sum ( number_of_Bursts_for_Classified_Devices ( 1, 1 : classified_Device_Index - 1 ) ) + 1;
                ending_Index   =  sum ( number_of_Bursts_for_Classified_Devices ( 1, 1 : classified_Device_Index ) );
                temp_Part_of_Labels_from_the_NetLabels_for_Current_Device = classLabels_from_Net ( 1, starting_Index : ending_Index );
               
                for DataBank_Device_Index = 1 : size ( unique_all_ClassLabels_form_Original_DataBank, 2 )
                    number_of_Matched_Labels_from_Current_Part_of_NetLabels_with_Current_Label_from_DataBank = sum ( temp_Part_of_Labels_from_the_NetLabels_for_Current_Device == unique_all_ClassLabels_form_Original_DataBank ( 1, DataBank_Device_Index ) );
                    confusion_Matrix ( classified_Device_Index, DataBank_Device_Index ) = number_of_Matched_Labels_from_Current_Part_of_NetLabels_with_Current_Label_from_DataBank;
                end
            end

        % Level 4: Normalizing 'Confusion Matrix' to produce 'Confusion Probability Matrix'            
            normalizer_Vertical_Matrix   = repmat ( number_of_Bursts_for_Classified_Devices', 1, size ( confusion_Matrix, 2 ) );
            confusion_Probability_Matrix = ( confusion_Matrix ./ normalizer_Vertical_Matrix );
        
        % Level 6: Printing the Confusion Matrix
            if ( permission_for_Printing_the_Results == 1 )
                
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
                        fprintf ( '                     Confusion Matrices Resuls (%s)\n', application_or_Training );
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

                for index = 1 : size ( unique_all_ClassLabels_form_Original_DataBank, 2 )
                    column_Titles ( 1, index ) = {sprintf( 'Device_%d', unique_all_ClassLabels_form_Original_DataBank ( 1, index ) )};

                end

                disp( '-------------------------------------------------------------------------' )
                fprintf ( '  Confusion Matrix %s\n', type_of_Data );
                disp( '-------------------------------------------------------------------------' )
                T = table;
                T. classified_Devices = row_Titles';
                for column_Title_Index = 1 : size ( column_Titles, 2 )      
                    T. ( char ( column_Titles ( 1, column_Title_Index ) ) ) = confusion_Matrix ( :, column_Title_Index );

                end
                disp(T)
                disp( '-------------------------------------------------------------------------' )
                fprintf ( 'Confusion Probability Matrix %s\n', type_of_Data );
                disp( '-------------------------------------------------------------------------' )
                T = table;
                T. classified_Devices = row_Titles';
                for column_Title_Index = 1 : size ( column_Titles, 2 )      
                    T. ( char ( column_Titles ( 1, column_Title_Index ) ) ) = confusion_Probability_Matrix ( :, column_Title_Index );

                end
                disp(T)
                disp( '-------------------------------------------------------------------------' )
                disp( '-------------------------------------------------------------------------' )
                disp( '-------------------------------------------------------------------------' )

            end

        % Level 6: Accumulation of Output
            output. confusion_Matrix_for_RoundedClamped             = confusion_Matrix;
            output. confusion_Probability_Matrix_for_RoundedClamped = confusion_Probability_Matrix;
            
end

