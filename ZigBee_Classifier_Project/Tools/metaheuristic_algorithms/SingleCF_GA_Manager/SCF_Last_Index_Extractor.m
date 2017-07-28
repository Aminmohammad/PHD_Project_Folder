function largest_Index = SCF_Last_Index_Extractor ( results_Folder_Address )

    % Extracting the Contents of a 'Folder'
        content = dir ( results_Folder_Address );
    
    % Extracting the Indices of a 'Folder'
        indices_of_Folders = [content.isdir];
        
    % Extracting the Indices of 'Files'    
        [~, index_of_Files]   = find( indices_of_Folders == 0 );
    
        if ( isempty ( index_of_Files ) == 0 ) 
            % Extracting the Names of 'Files' 
                name_of_Files = {content( index_of_Files, 1 ).name};

            % Extracting the Largest-Index of 'Files'
                largest_Index = - inf;
                for file_Index = 1 : size ( name_of_Files, 2 )
                    current_File = char ( name_of_Files ( 1, file_Index ) );

                    if ( strcmp ( current_File ( 1, end - 3 : end ), '.mat' ) == 1 )

                        [ ~, index_of_Underlines ] = find ( current_File == '_');
                        current_Index = str2double ( current_File ( 1, index_of_Underlines ( 1, end ) + 1 : end - 4 ) );

                        if ( isnan ( current_Index ) == 0 ) && ( current_Index > largest_Index )
                            largest_Index = current_Index;
                            
                        elseif  isnan ( current_Index ) ~= 0 
                            largest_Index = 'There are no Appropriate ".mat" File.';

                        end

                    end

                end        
                
        else
            largest_Index = 'There are no Appropriate ".mat" File.';
            
        end

end