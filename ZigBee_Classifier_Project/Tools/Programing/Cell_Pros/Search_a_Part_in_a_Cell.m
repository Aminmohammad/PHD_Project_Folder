function index_of_a_Part_in_the_Cell = Search_a_Part_in_a_Cell ( input_Cell, target_Part )

% target_Part: String

    %% Section 1: 
        temp_Index = strfind(input_Cell, target_Part);
        index_of_a_Part_in_the_Cell = find(not(cellfun('isempty', temp_Index))); 
            
end