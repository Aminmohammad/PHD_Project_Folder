

dataPoints = rand ( 4, 100 );
class_Labels  = rand ( 1, 100 );
structure_of_Fixed_Variables_for_Cost_Function. dataPoints   = dataPoints;
structure_of_Fixed_Variables_for_Cost_Function. class_Labels = class_Labels;


number_of_Vars    = 348;
var_Min_Vector    = zeros ( 1,number_of_Vars );
var_Max_Vector    = inf * ones ( 1,number_of_Vars );
maximum_Iteration = 5;
population_Size   = 100;
p_CrossOver       = .8;
p_Mutation        = .1;
deviation         = 10;
ranking_Policy    = 'Ascend';

GA_Parameters_Structure. number_of_Vars    = number_of_Vars;            
GA_Parameters_Structure. var_Min_Vector    = var_Min_Vector;                                 
GA_Parameters_Structure. var_Max_Vector    = var_Max_Vector;
GA_Parameters_Structure. maximum_Iteration = maximum_Iteration;                       
GA_Parameters_Structure. population_Size   = population_Size;                            
GA_Parameters_Structure. p_CrossOver       = p_CrossOver;                                   
GA_Parameters_Structure. p_Mutation        = p_Mutation;                                    
GA_Parameters_Structure. deviation         = deviation;                                     
GA_Parameters_Structure. ranking_Policy    = ranking_Policy;
        
addpath ( 'D:\PHD_Project_Folder\ZigBee_Classifier_Project\Classifiers\5_Neural_Networks\2_Written\V1' )



SCF_Genetic_Algorithm_Manager ( GA_Parameters_Structure,                          ...
                                structure_of_Fixed_Variables_for_Cost_Function  )
                            
                            
                            
                            
                            