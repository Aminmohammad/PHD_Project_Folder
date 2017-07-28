function index_of_an_Exact_Word_in_a_Cell = Search_an_Exact_Word_in_a_Cell ( input_Cell, target_Word )

% target_Word: String

    %% Section 1: 
        temp_Cell = input_Cell (:)';
        for index = 1 : size ( temp_Cell, 2 )
            temp_Cell ( 1, index ) = { temp_Cell( 1, index ) };

        end

        index_of_an_Exact_Word_in_a_Cell = find(strcmp([temp_Cell{:}], target_Word));
            
end