function [ number_of_Folders_that_will_be_Searched, last_Modified_subFolder ] = Latest_Folder_Finder ( root_Folder_Address, number_of_Folders_that_will_be_Searched )
    all_subFolders_in_RootFolder = dir (root_Folder_Address);
    all_subFolders_in_RootFolder = all_subFolders_in_RootFolder ( 3 : end, : );
    
    if ( isempty ( all_subFolders_in_RootFolder ) == 1 )
        error ( 'No Previously Saved Model Exists !!' );
        
    end
    
    if ( number_of_Folders_that_will_be_Searched ~= 0 )
        all_subFolders_in_RootFolder           = all_subFolders_in_RootFolder ( 1 : number_of_Folders_that_will_be_Searched, 1 );        
        
    end
    
    number_of_Folders_that_will_be_Searched = size ( all_subFolders_in_RootFolder, 1 );
    dates_of_all_subFolders_in_RootFolder = [ all_subFolders_in_RootFolder.datenum ];
    [ ~, maxIndex ]         = max ( dates_of_all_subFolders_in_RootFolder );
    last_Modified_subFolder = [ root_Folder_Address   '\'   all_subFolders_in_RootFolder( maxIndex ).name ];

end