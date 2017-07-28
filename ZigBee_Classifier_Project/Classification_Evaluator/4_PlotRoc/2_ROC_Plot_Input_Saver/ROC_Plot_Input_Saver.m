function [ train_Output, test_Output ] = ROC_Plot_Input_Saver ( input )

if     ( strcmp(input. application_or_Training, 'Training') == 1) 
    
    if      ( strcmp(input. type_of_Data, '(Train_Data)') == 1)
        Persistent_Variable_Saver ( input, 'Writing', 2 );
        train_Output = [];
        test_Output = [];
        
    elseif  ( strcmp(input. type_of_Data, '(Test_Data)') == 1)
        train_Output = Persistent_Variable_Saver ( [], 'Reading', 2 );
        Persistent_Variable_Saver ( [], 'Clearing', 2 );
                
        test_Output  = input;
                
    end      
    
elseif ( strcmp(input. application_or_Training, 'Application') == 1) 
    
end



