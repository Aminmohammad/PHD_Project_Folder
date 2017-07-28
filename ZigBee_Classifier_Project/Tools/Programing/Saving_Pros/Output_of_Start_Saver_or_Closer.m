function Output_of_Start_Saver_or_Closer ( varargin )

    %% Section 0: Preliminaries
        inputSet = inputParser();
        inputSet.CaseSensitive = false;  
        inputSet.KeepUnmatched = true;  
        inputSet.addParameter( 'saving_Permission_Vector', [ 1 0 1 0 0 0 0 ] );
        inputSet.addParameter( 'saving_Folder_Address', [] );
        inputSet.addParameter( 'loading_Folder_Address', [] );
        inputSet.addParameter( 'cell_of_Addresses_for_Deleting', [] );
        inputSet.addParameter( 'output_Results', [] );
        inputSet.parse( varargin{:} );
             
        saving_Vector                   = inputSet.Results.saving_Permission_Vector;
        saving_Folder_Address           = inputSet.Results.saving_Folder_Address;
        loading_Folder_Address          = inputSet.Results.saving_Folder_Address;
        cell_of_Addresses_for_Deleting  = inputSet.Results.cell_of_Addresses_for_Deleting;
        output_Results                  = inputSet.Results.output_Results;

%         loading_Folder_Address         = inputSet.Results.loading_Folder_Address; 
%         cell_of_Addresses_for_Deleting = inputSet.Results.cell_of_Addresses_for_Deleting; 
        
    %% Section 1: Saving the Outputs as 'Figs' and 'MATFile'        
        % Level 0: Permissions
            do_You_Want_the_Figs_to_be_Saved                                         = saving_Vector ( 1, 1 );
            do_You_Want_to_Save_the_Current_Output_as_a_MATFile                      = saving_Vector ( 1, 2 );
            do_You_Want_to_Write_the_Current_Output_as_a_ExcellFile                  = saving_Vector ( 1, 3 );
            do_You_Want_to_Write_the_Previously_Saved_Output_MATFile_as_a_ExcellFile = saving_Vector ( 1, 4 );
            do_You_Want_to_Load_previosly_Saved_Figs                                 = saving_Vector ( 1, 5 );
            do_You_Want_to_Load_previosly_Saved_ExcellFile                           = saving_Vector ( 1, 6 );
            do_You_Want_to_Delete_Output_Folders_from_Results_Folder                 = saving_Vector ( 1, 7 );
            
        % Level 1: Closing GUIs rather than Figs
            % Part 1: Closing GUIs
                fprintf ( '\n\nProgram is halted until you "Press a Keyboard Button" on the last figure. By this work, all figures will be closed ... !\n' );
                figHandles = findobj('Type','figure');
                if ( isempty ( figHandles ) == 0 )
                    waitforbuttonpress

                end
                nntraintool('close');

            % Part 2: Saving and Closing Figures 
                Saving_and_Closing_Figs ( saving_Folder_Address, do_You_Want_the_Figs_to_be_Saved );

        % Level 2: Saving the Output to the 'Mat File'
           if ( do_You_Want_to_Save_the_Current_Output_as_a_MATFile == 1 )
               fprintf ( '\n\nStarted to Save the Output as a MAT File ... !\n' );

               name_of_Saving_File = 'output.mat';           
               file_that_Should_be_Saved = output_Results;
               Saving_the_Output_to_the_MATFile ( saving_Folder_Address, file_that_Should_be_Saved, name_of_Saving_File );              
               fprintf ( 'Saving the Output as a MAT File Finished.\n' );

           else
                fprintf ( 'You Selected not to Save the Output as a MAT File ... !\n' );                

           end

    %% Writing the Current Output as 'Excell File'
        if ( do_You_Want_to_Write_the_Current_Output_as_a_ExcellFile == 1 )                              
           fprintf ( 'Started to Write the current Output as a Excell File ... !\n' );                                                                                    
           accumulated_Set                                   = Output_Loader_for_Excell (  'address_of_Selected_previosly_Saved_Output_Folder', [], ...
                                                                                           'output_Results',                                    output_Results                             );

           address_of_Selected_previosly_Saved_Output_Folder = saving_Folder_Address;
           Write_to_Excell_File ( accumulated_Set, address_of_Selected_previosly_Saved_Output_Folder, 'OutputResults.xlsx' )                           
           fprintf ( 'Writing the current Output as a Excell File Finished.\n' );

        else
           fprintf ( 'You Selected not to Write the current Output as a Excell File ... !\n' );                

        end 

    %% Writing the previously Saved Output MATFile as 'Excell File'
        if ( do_You_Want_to_Write_the_Previously_Saved_Output_MATFile_as_a_ExcellFile == 1 )                              
           fprintf ( 'Started to Write the previously Saved Output MAT File as a Excell File ... !\n' );                
           address_of_Selected_previosly_Saved_Output_Folder = saving_Folder_Address;                                                                       
           accumulated_Set                                   = Output_Loader_for_Excell (  'address_of_Selected_previosly_Saved_Output_Folder', address_of_Selected_previosly_Saved_Output_Folder, ...
                                                                                           'output_Results',                                    []                             );

           Write_to_Excell_File ( accumulated_Set, address_of_Selected_previosly_Saved_Output_Folder, 'OutputResults.xlsx' )                           
           fprintf ( 'Writing the previously Saved Output MAT File as a Excell File Finished.\n' );

        else
           fprintf ( 'You Selected not to Write the previously Saved Output as a Excell File ... !\n' );                

        end 

    %% Loading the previous Figs
        if ( do_You_Want_to_Load_previosly_Saved_Figs == 1 )                              
           fprintf ( 'Started to Load the previously Saved Figs ... !\n' );              
           address_of_Selected_previosly_Saved_Output_Folder = loading_Folder_Address;                                                                       
           previously_Saved_Figs_Loader (  'address_of_Selected_previosly_Saved_Output_Folder', address_of_Selected_previosly_Saved_Output_Folder );
           fprintf ( 'Loading the previously Saved Figs Finished. \n' );  

        else
           fprintf ( 'You Selected not to Load the previously Saved Fig File ... !\n' );                

        end         

    %% Loading the previous 'Excell File'
        if ( do_You_Want_to_Load_previosly_Saved_ExcellFile == 1 )                              
           fprintf ( 'Started to Load the previously Saved Excell File ... !\n' );              
           address_of_Selected_previosly_Saved_Output_Folder = loading_Folder_Address;                                                                                 
           winopen([ address_of_Selected_previosly_Saved_Output_Folder '\' 'OutputResults.xlsx' ])                                    
           fprintf ( 'Loading the previously Saved Excell File Finished. \n' );  

        else
           fprintf ( 'You Selected not to Load the previously Saved Excell File ... !\n' );                

        end 

    %% Deleting the previous Saved Folder Containing  the Output Files ( '*.fig', '*.mat', '*.xlsx' ) from Results Folder
        if ( do_You_Want_to_Delete_Output_Folders_from_Results_Folder == 1 )                              
           fprintf ( 'Started to Delete the previously Saved Output Folder ... !\n' );                                                                                           
           Deleting_the_Saved_Output_Folders_from_Results ( cell_of_Address_of_Output_Folders_from_Results_Folder_for_Deleting );                                
           fprintf ( 'Deleting the previously Saved Output Folder Finished. \n' );  

        end 
        
end