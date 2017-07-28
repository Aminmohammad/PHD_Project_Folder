function output = Plot_Receiver_Operating_Characteristic( varargin )

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
        
        % Level 2: Converting the 'classLabels_from_Net' and 'classLabels_from_Original_or_ReducedForApplication_DataBank' to 'Horizontal Vactors'
            classLabels_from_Net      = [classLabels_from_Net.roundedClamped_Output];
            classLabels_from_Net      = classLabels_from_Net ( : )';                                             
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';             

    %% Section 2: Making the "Table" for each of "Devices" in the "classLabels_from_Original_or_ReducedForApplication_DataBank"
        all_classLabels_in_the_classLabels_from_Original_or_ReducedForApplication_DataBank = unique ( classLabels_from_Original_or_ReducedForApplication_DataBank );   
        
        for classLabel_Index = 1 : numel ( all_classLabels_in_the_classLabels_from_Original_or_ReducedForApplication_DataBank )
            current_Reference_Device = all_classLabels_in_the_classLabels_from_Original_or_ReducedForApplication_DataBank ( 1, classLabel_Index );
            
            indices_of_DataPoints_in_DataBank_ClassLabels_Equal_to_current_Reference_Device = ( classLabels_from_Original_or_ReducedForApplication_DataBank == current_Reference_Device );
            true_Negative = sum ( classLabels_from_Net ( 1, indices_of_DataPoints_in_DataBank_ClassLabels_Equal_to_current_Reference_Device ) == current_Reference_Device );    % summation of all cases that "Selected Classified Devices == current_Reference_Device"
                % True_Negative = Specifity
                
            indices_of_DataPoints_in_DataBank_ClassLabels_NotEqual_to_current_Reference_Device = ( classLabels_from_Original_or_ReducedForApplication_DataBank ~= current_Reference_Device );
            false_Negative = sum ( classLabels_from_Net ( 1, indices_of_DataPoints_in_DataBank_ClassLabels_NotEqual_to_current_Reference_Device ) == current_Reference_Device );   % summation of all cases that "Selected Classified Devices == current_Reference_Device"
                % False_Negative = Type II Error    
                
            indices_of_DataPoints_in_DataBank_ClassLabels_NotEqual_to_current_Reference_Device = ( classLabels_from_Original_or_ReducedForApplication_DataBank ~= current_Reference_Device );
            true_Positive = sum ( classLabels_from_Net ( 1, indices_of_DataPoints_in_DataBank_ClassLabels_NotEqual_to_current_Reference_Device ) ~= current_Reference_Device ); % summation of all cases that "Selected Classified Devices ~= current_Reference_Device"
                % True_Positive = Sensitivity
   
            indices_of_DataPoints_in_DataBank_ClassLabels_Equal_to_current_Reference_Device = ( classLabels_from_Original_or_ReducedForApplication_DataBank == current_Reference_Device );
            false_Positive = sum ( classLabels_from_Net ( 1, indices_of_DataPoints_in_DataBank_ClassLabels_Equal_to_current_Reference_Device ) ~= current_Reference_Device );   % summation of all cases that "Selected Classified Devices ~= current_Reference_Device"
                % False_Positive = Type I Error 
                              
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).current_Device_Label    = current_Reference_Device; 
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).true_Negative           = true_Negative; 
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).false_Negative          = false_Negative; 
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).true_Positive           = true_Positive;             
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).false_Positive          = false_Positive;
            
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).number_of_Ref_Devices   = sum (indices_of_DataPoints_in_DataBank_ClassLabels_Equal_to_current_Reference_Device);            
            structure_of_Infos_of_all_Devices ( classLabel_Index, 1 ).number_of_other_Devices = sum (indices_of_DataPoints_in_DataBank_ClassLabels_NotEqual_to_current_Reference_Device);            

        end
        
    %% Section 3: Printing the Results
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
                    fprintf ( '                     TestResults Matrices (%s)\n', application_or_Training );
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
            
            % Level 1: Showing the "Number of Devices" wich was classified with their "Labels"
                disp( '-------------------------------------------------------------------------' )
                disp( '-------------------------------------------------------------------------' )            
                disp( '-------------------------------------------------------------------------' )
                    fprintf ( '  The "Numbers" and "Data-Points" of Devices that are classified Here. %s\n', type_of_Data );
                disp( '-------------------------------------------------------------------------' )

                number_of_Classified_Devices = size ( number_of_Bursts_for_Classified_Devices, 2 );
                for index = 1 : number_of_Classified_Devices
                    row_Titles ( 1, index ) = {sprintf( 'Device_%d', selected_Indices_of_Devices ( 1, index ) )};

                    number_of_DataPoints_of_all_Devices_that_are_Classified ( 1, index ) = sum ( classLabels_from_Original_or_ReducedForApplication_DataBank == selected_Indices_of_Devices ( 1, index ) );

                end            
                T                       = table;
                T. classified_Devices   = row_Titles';
                T. number_of_DataPoints = number_of_DataPoints_of_all_Devices_that_are_Classified';
                disp(T)
                
            % Level 2: Showing the "TestResult-Set Matrix" and Plotting the Results  
                colors_Vector = hsv ( numel ( structure_of_Infos_of_all_Devices ) );
                
                if ( strcmp ( application_or_Training, 'Application' ) == 1 ) || ...
                        ( ( strcmp ( application_or_Training, 'Training' ) == 1 ) && ( strcmp ( type_of_Data, '(Train_Data)' ) == 1 ) ) 
                    handle = 1000;
                        
                elseif ( ( strcmp ( application_or_Training, 'Training' ) == 1 ) && ( strcmp ( type_of_Data, '(Test_Data)' ) == 1 ) ) 
                    handle = 1005;
                
                end
            
                disp( '-------------------------------------------------------------------------' )
                fprintf ( '  TestResult-Set for RoundedClamped %s\n', type_of_Data );
                disp( '-------------------------------------------------------------------------' )
                for reference_Device_Index = 1 : numel ( structure_of_Infos_of_all_Devices )
                    
                    % Stage 1: Printing the Results
                        current_Reference_Device_Label                         = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).current_Device_Label;
                        true_Negative_for_Current_Reference_Device_Label       = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).true_Negative;
                        false_Negative_for_Current_Reference_Device_Label      = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).false_Negative;
                        true_Positive_for_Current_Reference_Device_Label       = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).true_Positive;
                        false_Positive_for_Current_Reference_Device_Label      = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).false_Positive;

                        number_of_Ref_Devices                                  = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).number_of_Ref_Devices;
                        number_of_other_Devices                                = structure_of_Infos_of_all_Devices ( reference_Device_Index, 1 ).number_of_other_Devices;
                        
                        true_Negative_Rate_for_Current_Reference_Device_Label  = true_Negative_for_Current_Reference_Device_Label/number_of_Ref_Devices;
                        false_Negative_Rate_for_Current_Reference_Device_Label = false_Negative_for_Current_Reference_Device_Label/number_of_other_Devices;
                        true_Positive_Rate_for_Current_Reference_Device_Label  = true_Positive_for_Current_Reference_Device_Label/number_of_other_Devices;
                        false_Positive_Rate_for_Current_Reference_Device_Label = false_Positive_for_Current_Reference_Device_Label/number_of_Ref_Devices;

                        row_Titles    = { sprintf( 'H0: Ref. Dev. %d', current_Reference_Device_Label ), '', '---------------------------------',sprintf( 'H1: all Devices exc. Ref. Dev. %d', current_Reference_Device_Label ), '', '---------------------------------' }';
                        column_Titles = { 'H0', 'H1' };

                        T = table;
                        T. Test_Results = row_Titles;                  

                        true_Negative_Text       = sprintf( 'True Negative = Specificity = True Acceptance of Dev. %d = # of Correctly Classified Data-Points of Dev. %d = %d', current_Reference_Device_Label, current_Reference_Device_Label, true_Negative_for_Current_Reference_Device_Label);
                        true_Negative_Rate_Text  = sprintf( 'True Negative Rate = 1 - False Positive Rate = Class. Rate of Dev. %d = ( True Negative  / # of Data-Points of Dev. %d ) = %1.4f', current_Reference_Device_Label, current_Reference_Device_Label, true_Negative_Rate_for_Current_Reference_Device_Label );
                        false_Negative_Text      = sprintf( 'False Negative = Type II Error = False Acceptance of other Devs. as Dev. %d = # of Incorrectly Classified Data-Points of Dev. other than Dev. %d = %d', current_Reference_Device_Label, current_Reference_Device_Label, false_Negative_for_Current_Reference_Device_Label);
                        false_Negative_Rate_Text = sprintf( 'False Negative Rate = 1 - True Positive Rate = ( False Negative  / # of Data-Points of Dev. other than Dev. %d ) = %1.4f', current_Reference_Device_Label, false_Negative_Rate_for_Current_Reference_Device_Label );
                        false_Positive_Text      = sprintf( 'False Positive = Type I Error = False Alarm = False Rejection of Dev. %d = # of Incorrectly Classified Data-Points of Dev. %d = %d', current_Reference_Device_Label, current_Reference_Device_Label, false_Positive_for_Current_Reference_Device_Label);
                        false_Positive_Rate_Text = sprintf( 'False Positive Rate = P( False Alarm ) = 1 - True Negative Rate = ( False Positive  / # of Data-Points of Dev. other than Dev. %d ) = %1.4f', current_Reference_Device_Label, false_Positive_Rate_for_Current_Reference_Device_Label ); 
                        true_Positive_Text       = sprintf( 'True Positive = Sensitivity = Detection = True Rejection of all Dev. except Dev. %d = # of Correctly Classified Data-Points of Dev. other than Dev. %d  = %d', current_Reference_Device_Label, current_Reference_Device_Label, true_Positive_for_Current_Reference_Device_Label);
                        true_Positive_Rate_Text  = sprintf( 'True Positive Rate = P( Detection ) = 1 - False Negative Rate = ( True Positive  / # of Data-Points of Dev. %d ) = %1.4f', current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label );
                        
                        T. ( char ( column_Titles ( 1, 1 ) ) ) = { true_Negative_Text, ...
                                                                   true_Negative_Rate_Text, ...
                                                                   '---------------------------------------------------------------------------------------------------', ...
                                                                   false_Negative_Text, ...      
                                                                   false_Negative_Rate_Text, ...
                                                                   '---------------------------------------------------------------------------------------------------' }';

                        T. ( char ( column_Titles ( 1, 2 ) ) ) = { true_Positive_Text, ...
                                                                   true_Positive_Rate_Text, ...
                                                                   '---------------------------------------------------------------------------------------------------', ...
                                                                   false_Positive_Text, ...
                                                                   false_Positive_Rate_Text, ...
                                                                   '---------------------------------------------------------------------------------------------------' }';
                        disp(T)
                    
                    % Stage 2: Making the "Plot Title"                       
                        if ( isempty ( general_PlotTitle ) == 0 )
                            part_1  = sprintf ( '%s', general_PlotTitle (1, : ) );
                            part_2  = sprintf ( '%s', general_PlotTitle (2, : ) );
                            part_3  = sprintf ( '%s', general_PlotTitle (3, : ) );
                            part_4  = [ '(' application_or_Training '__' type_of_Data( 2 : end - 1 ) ')' ]';

                            Title   = sprintf ('%s\n%s\n%s\n%s', part_1, part_2, part_3, part_4 ); 

                        else
                            part_1 = [];
                            part_2 = [ '(' application_or_Training '__' type_of_Data( 2 : end - 1 ) ')' ]';

                            Title   = sprintf ('%s\n%s', part_1, part_2 );

                        end  
                        
                    % Stage 2: Plotting the Results
                        % Part 1: Making the 'XLabel' and 'YLabel' Ready
                            true_Negative_Rate_Text  = { 'True Negative Rate = Specificity = 1 - False Positive Rate = True Acceptance Rate of Ref. Dev.';
                                                         '= Class.  Rate of Ref. Dev. = ( # of Correctly Classified Data-Points of Ref. Dev. / # of Data-Points of Ref. Dev. )' };
                                                      
                            false_Negative_Rate_Text = { 'False Negative Rate = Type II Error = = 1 - True Positive Rate = False Acceptance Rate of other Devs.';
                                                         'as Ref. Dev. = ( # of Incorrectly Classified Data-Points of Dev. other than Ref. Dev. / # of Data-Points of Dev. other than Ref. Dev. )' }; 
                                                     
                            false_Positive_Rate_Text = { 'False Positive Rate = P( False Alarm ) = Type I Error = 1 - True Negative Rate = False Rejection Rate of Ref. Dev. '; 
                                                         '= ( # of Incorrectly Classified Data-Points of Ref. Dev. / # of Data-Points of Ref. Dev. )' };
                                                     
                            true_Positive_Rate_Text  = { 'True Positive Rate = Sensitivity = P( Detection ) = 1 - False Negative Rate = True Rejection Rate of all Dev.  '; 
                                                         'except Ref. Dev. = ( # of Correctly Classified Data-Points of Dev. other than Ref. Dev. / # of Data-Points of Dev. other than Ref. Dev. )' };
                            
                            true_Negative_Rate_Text_Y  = { 'True Negative Rate = Specificity = 1 - False Positive Rate' ;
                                                           '= True Acceptance Rate of Ref. Dev.'
                                                           '= Class. Rate of Ref. Dev.';
                                                           '= ( # of Correctly Classified Data-Points of Ref. Dev.'; 
                                                           '/ # of Data-Points of Ref. Dev. )'};


                            true_Positive_Rate_Text_Y  = { 'True Positive Rate = Sensitivity = P( Detection ) = 1 - False Negative Rate'; 
                                                           '= True Rejection Rate of all Dev. except Ref. Dev.'
                                                           '= ( # of Correctly Classified Data-Points of Dev. other than Ref. Dev.';
                                                           '/ # of Data-Points of Dev. other than Ref. Dev. )' };
                                                                                                                                        
                        % Part 2: Plotting
                            fontSize = 12;
                            
                            % Figure 1:
                                figure(handle)
                                A_X = [ 0 false_Negative_Rate_for_Current_Reference_Device_Label 1 ];
                                A_Y = [ 0 true_Negative_Rate_for_Current_Reference_Device_Label 1 ];
                                A (  reference_Device_Index, 1 ) = plot ( A_X, A_Y, 'DisplayName', sprintf( 'Reference Device: Dev. %d', current_Reference_Device_Label ), 'Color', colors_Vector ( reference_Device_Index, : ), 'LineWidth', 2 ); 
                                hold on;

                                % Write on Plot.   
                                    Text = sprintf ( 'F. N. = %1.2f && T. N. = % 1.2f.', false_Negative_Rate_for_Current_Reference_Device_Label, true_Negative_Rate_for_Current_Reference_Device_Label );
                                    Text = [ '\leftarrow' Text ];
                                    text ( false_Negative_Rate_for_Current_Reference_Device_Label, true_Negative_Rate_for_Current_Reference_Device_Label, Text, 'Color', 'k', 'FontSize', 12)

                                % Draw Coordinate Lines on Plot.    
                                    plot ( [ false_Negative_Rate_for_Current_Reference_Device_Label false_Negative_Rate_for_Current_Reference_Device_Label ], [ 0 true_Negative_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5 );                             
                                    plot ( [ 0 false_Negative_Rate_for_Current_Reference_Device_Label ], [ true_Negative_Rate_for_Current_Reference_Device_Label true_Negative_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5  ); 

                                title( Title, 'Interpreter', 'none' );                        
                                xlabel( false_Negative_Rate_Text )
                                ylabel( true_Negative_Rate_Text_Y )
                                set(gca,'fontsize', fontSize)              
                                grid on                              

                            % Figure 2:                                
                                figure(handle + 1)
                                B_X = [ 0 false_Positive_Rate_for_Current_Reference_Device_Label 1 ];
                                B_Y = [ 0 true_Negative_Rate_for_Current_Reference_Device_Label 1 ];
                                B (  reference_Device_Index, 1 ) = plot ( B_X, B_Y, 'DisplayName', sprintf( 'Reference Device: Dev. %d', current_Reference_Device_Label ), 'Color', colors_Vector ( reference_Device_Index, : ), 'LineWidth', 2  ); 
                                hold on;

                                % Write on Plot.   
                                    Text = sprintf ( 'F. P. = %1.2f && T. N. = % 1.2f.', false_Positive_Rate_for_Current_Reference_Device_Label, true_Negative_Rate_for_Current_Reference_Device_Label);
                                    Text = [ '\leftarrow' Text ];
                                    text ( false_Positive_Rate_for_Current_Reference_Device_Label, true_Negative_Rate_for_Current_Reference_Device_Label, Text, 'Color', 'k', 'FontSize', 12)

                                % Draw Coordinate Lines on Plot.    
                                    plot ( [ false_Positive_Rate_for_Current_Reference_Device_Label false_Positive_Rate_for_Current_Reference_Device_Label ], [ 0 true_Negative_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5 );                             
                                    plot ( [ 0 false_Positive_Rate_for_Current_Reference_Device_Label ], [ true_Negative_Rate_for_Current_Reference_Device_Label true_Negative_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5  ); 

                                title( Title, 'Interpreter', 'none' );
                                xlabel( false_Positive_Rate_Text )
                                ylabel( true_Negative_Rate_Text_Y )  
                                set(gca,'fontsize', fontSize)              
                                grid on                              

                            % Figure 3:                                 
                                figure(handle + 2)
                                C_X = [ 0 false_Negative_Rate_for_Current_Reference_Device_Label 1 ];
                                C_Y = [ 0 true_Positive_Rate_for_Current_Reference_Device_Label 1 ];
                                C (  reference_Device_Index, 1 ) = plot ( C_X, C_Y, 'DisplayName', sprintf( 'Reference Device: Dev. %d', current_Reference_Device_Label ), 'Color', colors_Vector ( reference_Device_Index, : ), 'LineWidth', 2  ); 
                                hold on;

                                % Write on Plot.   
                                    Text = sprintf ( 'F. N. = %1.2f && T. P. = % 1.2f.', false_Negative_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label);
                                    Text = [ '\leftarrow' Text ];
                                    text ( false_Negative_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label, Text, 'Color', 'k', 'FontSize', 12)

                                % Draw Coordinate Lines on Plot.    
                                    plot ( [ false_Negative_Rate_for_Current_Reference_Device_Label false_Negative_Rate_for_Current_Reference_Device_Label ], [ 0 true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5 );                             
                                    plot ( [ 0 false_Negative_Rate_for_Current_Reference_Device_Label ], [ true_Positive_Rate_for_Current_Reference_Device_Label true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5  ); 

                                title( Title, 'Interpreter', 'none' );
                                xlabel( false_Negative_Rate_Text )
                                ylabel( true_Positive_Rate_Text_Y ) 
                                set(gca,'fontsize', fontSize)              
                                grid on                              

                            % Figure 4:                                 
                                figure(handle  + 3)
                                D_X = [ 0 false_Positive_Rate_for_Current_Reference_Device_Label 1 ];
                                D_Y = [ 0 true_Positive_Rate_for_Current_Reference_Device_Label 1 ];
                                D (  reference_Device_Index, 1 ) = plot ( D_X, D_Y, 'DisplayName', sprintf( 'Reference Device: Dev. %d', current_Reference_Device_Label ), 'Color', colors_Vector ( reference_Device_Index, : ), 'LineWidth', 2  ); 
                                hold on;

                                % Write on Plot.                               
                                    Text = sprintf ( 'F. P. = %1.2f && T. P. = % 1.2f.', false_Positive_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label);
                                    Text = [ '\leftarrow' Text ];
                                    text ( false_Positive_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label, Text, 'Color', 'k', 'FontSize', 12)

                                % Draw Coordinate Lines on Plot.    
                                    plot ( [ false_Positive_Rate_for_Current_Reference_Device_Label false_Positive_Rate_for_Current_Reference_Device_Label ], [ 0 true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5 );                             
                                    plot ( [ 0 false_Positive_Rate_for_Current_Reference_Device_Label ], [ true_Positive_Rate_for_Current_Reference_Device_Label true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5  ); 

                                title( Title, 'Interpreter', 'none' );
                                xlabel( false_Positive_Rate_Text )
                                ylabel( true_Positive_Rate_Text_Y ) 
                                set(gca,'fontsize', fontSize)              
                                grid on                              
                            
                            % Figure 5: 
                                figure(handle + 4)
                                E_X = [ 0 true_Negative_Rate_for_Current_Reference_Device_Label 1 ];
                                E_Y = [ 0 true_Positive_Rate_for_Current_Reference_Device_Label 1 ];
                                E (  reference_Device_Index, 1 ) = plot ( E_X, E_Y, 'DisplayName', sprintf( 'Reference Device: Dev. %d', current_Reference_Device_Label ), 'Color', colors_Vector ( reference_Device_Index, : ), 'LineWidth', 2  ); 
                                hold on;

                                % Write on Plot.   
                                    Text = sprintf ( 'T. N. = %1.2f && T. P. = % 1.2f.', true_Negative_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label);
                                    Text = [ '\leftarrow' Text ];
                                    text ( true_Negative_Rate_for_Current_Reference_Device_Label, true_Positive_Rate_for_Current_Reference_Device_Label, Text, 'Color', 'k', 'FontSize', 12)

                                % Draw Coordinate Lines on Plot.    
                                    plot ( [ true_Negative_Rate_for_Current_Reference_Device_Label true_Negative_Rate_for_Current_Reference_Device_Label ], [ 0 true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5 );                             
                                    plot ( [ 0 true_Negative_Rate_for_Current_Reference_Device_Label ], [ true_Positive_Rate_for_Current_Reference_Device_Label true_Positive_Rate_for_Current_Reference_Device_Label ], 'Color', [.5 .5 .5], 'LineStyle', '--', 'LineWidth', .5  ); 

                                title( Title, 'Interpreter', 'none' );
                                xlabel( true_Negative_Rate_Text )   
                                ylabel( true_Positive_Rate_Text_Y )
                                set(gca,'fontsize', fontSize)              
                                grid on                                            
                    
                end
                
                figure(handle)
                set(handle, 'Name', 'False Negative vs. True Negative', 'NumberTitle', 'off')
                A (  reference_Device_Index + 1, 1 ) = plot ( [ 0 1 ], [ 0 1 ], 'DisplayName', 'Chance Classification', 'Color', [.5 .5 .5], 'LineWidth', 2  );                
                legend(A, 'Location','best')
                hold off
                
                figure(handle + 1)
                set(handle + 1, 'Name', 'False Positive vs. True Negative', 'NumberTitle', 'off')
                B (  reference_Device_Index + 1, 1 ) = plot ( [ 0 1 ], [ 0 1 ], 'DisplayName', 'Chance Classification', 'Color', [.5 .5 .5], 'LineWidth', 2  );
                legend(B, 'Location','best')
                hold off
                
                figure(handle + 2)
                set(handle + 2, 'Name', 'False Negative vs. True Positive', 'NumberTitle', 'off')
                C (  reference_Device_Index + 1, 1 ) = plot ( [ 0 1 ], [ 0 1 ], 'DisplayName', 'Chance Classification', 'Color', [.5 .5 .5], 'LineWidth', 2  );
                legend(C, 'Location','best')
                hold off
                
                figure(handle + 3)
                set(handle + 3, 'Name', 'False Positive vs. True Positive (ROC Plot)', 'NumberTitle', 'off')
                D (  reference_Device_Index + 1, 1 ) = plot ( [ 0 1 ], [ 0 1 ], 'DisplayName', 'Chance Classification', 'Color', [.5 .5 .5], 'LineWidth', 2  );
                legend(D, 'Location','best')
                hold off
                
                figure(handle + 4)
                set(handle + 4, 'Name', 'True Negative vs. True Positive', 'NumberTitle', 'off')
                E (  reference_Device_Index + 1, 1 ) = plot ( [ 0 1 ], [ 0 1 ], 'DisplayName', 'Chance Classification', 'Color', [.5 .5 .5], 'LineWidth', 2  );
                legend(E, 'Location','best')
                hold off
         
    %% Section 4: Setting the all current Figures Invisible              
            set (handle, 'Visible', 'off')
            set (handle + 1, 'Visible', 'off')
            set (handle + 2, 'Visible', 'off')
            set (handle + 3, 'Visible', 'off')
            set (handle + 4, 'Visible', 'off')
            
    %% Section 5: Output           
        output = [];

end

