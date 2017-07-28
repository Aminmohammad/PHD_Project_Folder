function saving_Folder_Address = Making_the_Target_Folder ( folder_Name, cell_of_Parts_of_Name, do_you_Want_the_Folder_to_be_Made )

    % Making the Direcctory
        % Conformation of the Name of Directory
            [ target_Folder_Address, ~ ] = Folder_Address_Extractor ( 'PHD_Project_Folder', char ( folder_Name ) );
            current_Date_and_Time     = datetime('now');
            current_Date_and_Time     = char  ( current_Date_and_Time );
            current_Date_and_Time     = strrep( current_Date_and_Time, ' ', '_');
            current_Date_and_Time     = strrep( current_Date_and_Time, '-', '_');
            new_Current_Date_and_Time = strrep( current_Date_and_Time, ':', '_');

            cell_of_Parts_of_Name        = cell_of_Parts_of_Name (:)';            
            temp = [];
            for index = 1 : size ( cell_of_Parts_of_Name, 2 )
                temp = [ temp '_' char(cell_of_Parts_of_Name( 1, index )) ];
                
            end
            names_of_all_Classifiers = [ '(' temp(1, 2:end) ')' ];                      

            saving_Folder_Address = [ char( target_Folder_Address ) '\' 'Results' '\' new_Current_Date_and_Time '_' names_of_all_Classifiers ];     
        % Making the Direcctory
            if ( do_you_Want_the_Folder_to_be_Made == 1 )
                mkdir ( saving_Folder_Address )   
                
            end
        
                
end