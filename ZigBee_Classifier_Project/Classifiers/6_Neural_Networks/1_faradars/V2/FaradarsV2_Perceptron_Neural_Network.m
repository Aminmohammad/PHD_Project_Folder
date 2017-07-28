function output = FaradarsV2_Perceptron_Neural_Network ( varargin )

% Input:
%
%   input_DataPoints_Matrix: 
%                    DataPoints
%                __              __
%                |                |
%                |                |            
%    Dimensions  |                |
%                |_              _|

%   classLabels_from_DataBank:
%                 _              _
%                |_              _|

    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('Saving_Address', [] );
            inputSet.addParameter('selected_Saving_Extension', [] );
            inputSet.addParameter('input_DataPoints_Matrix', []);    
            inputSet.addParameter('classLabels_from_DataBank', []);
            inputSet.addParameter('special_Structure_of_Parameters_for_Classification', []);                        

            inputSet.parse(varargin{:});

            Saving_Address                                     = inputSet.Results.Saving_Address;            
            selected_Saving_Extension                          = inputSet.Results.selected_Saving_Extension;            
            input_DataPoints_Matrix                            = inputSet.Results.input_DataPoints_Matrix;
            classLabels_from_DataBank                          = inputSet.Results.classLabels_from_DataBank;
            special_Structure_of_Parameters_for_Classification = inputSet.Results.special_Structure_of_Parameters_for_Classification;            
            
            if        ( isempty( input_DataPoints_Matrix ) == 1 )        
                error ( 'You should Enter the "input_DataPoints_Matrix" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels_from_DataBank" for Classification in "FaradarsV2_Perceptron_Neural_Network".' );

            end    

            if ( isempty ( special_Structure_of_Parameters_for_Classification ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'number_of_Hidden_Layer_Neurons' ) ) == 0 )
                number_of_Hidden_Layer_Neurons   = special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons;
                
            else
                number_of_Hidden_Layer_Neurons = 3;
                
            end
            
            if ( isempty ( special_Structure_of_Parameters_for_Classification ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'show_NetTraining_Window' ) ) == 0 )
                show_NetTraining_Window         = special_Structure_of_Parameters_for_Classification.show_NetTraining_Window;
                
            else
                show_NetTraining_Window = true;
                
            end                                   

    %% Section 2: Classification 
       % Stage 1: Normalization
            number_of_DataPoints_Dimensions  = size( input_DataPoints_Matrix, 1 );
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );
       
            Minimum_of_Datapoints_in_all_Dimensions  = min ( input_DataPoints_Matrix' ); %#ok<*UDIM>
            Maximum_of_Datapoints_in_all_Dimensions  = max ( input_DataPoints_Matrix' );

            Minimum_of_ClassLabels_in_all_Dimensions = min ( classLabels_from_DataBank' );
            Maximum_of_ClassLabels_in_all_Dimensions = max ( classLabels_from_DataBank' );

            for dimension_Index = 1 : number_of_DataPoints_Dimensions
                normalized_DataPoints ( dimension_Index, : ) = Normalize_Fcn ( input_DataPoints_Matrix ( dimension_Index, : ), Minimum_of_Datapoints_in_all_Dimensions ( dimension_Index ), Maximum_of_Datapoints_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
            end

            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                normalized_ClassLabels ( dimension_Index, : ) = Normalize_Fcn ( classLabels_from_DataBank ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) );
            end
            
            inputs  = normalized_DataPoints;
            targets = normalized_ClassLabels;
                
        % Create a Fitting Network
            hiddenLayerSize = number_of_Hidden_Layer_Neurons;
            net = fitnet(hiddenLayerSize);

        % Choose Input and Output Pre/Post-Processing Functions
        % For a list of all processing functions type: help nnprocess
            net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
            net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


        % Setup Division of Data for Training, Validation, Testing
        % For a list of all data division functions type: help nndivide
            net.divideFcn = 'dividerand';  % Divide data randomly
            net.divideMode = 'sample';  % Divide up every sample
            net.divideParam.trainRatio = 70/100;
            net.divideParam.valRatio = 15/100;
            net.divideParam.testRatio = 15/100;


        % For help on training function 'trainlm' type: help trainlm
        % For a list of all training functions type: help nntrain
            net.trainFcn = 'trainlm';  % Levenberg-Marquardt

        % Choose a Performance Function
        % For a list of all performance functions type: help nnperformance
            net.performFcn = 'mse';  % Mean squared error

        % Choose Plot Functions
        % For a list of all plot functions type: help nnplot
            net.plotFcns = {'plotperform','ploterrhist','plotregression','plotfit'};

        % Net Parameters
            net.trainParam.showWindow = show_NetTraining_Window;
            net.trainParam.showCommandLine=false;
            net.trainParam.show=1;
            net.trainParam.epochs=500;
            net.trainParam.goal=1e-8;
            net.trainParam.max_fail=20;

        % Train the Network
            [net,tr] = train(net,inputs,targets);

        % Test the Network
            outputs     = net(inputs);            
            errors      = gsubtract(targets,outputs);
            performance = perform(net,targets,outputs);

        % Recalculate Training, Validation and Test Performance
            trainTargets     = targets .* tr.trainMask{1};
            valTargets       = targets  .* tr.valMask{1};
            testTargets      = targets  .* tr.testMask{1};
            trainPerformance = perform(net, trainTargets, outputs);
            valPerformance   = perform(net, valTargets, outputs);
            testPerformance  = perform(net, testTargets, outputs);

    %% Section 3: Demonstration
        % Making the Proper Name
            number_of_Hidden_Layer_Neurons_Text = [];
            for index = 1 : size ( number_of_Hidden_Layer_Neurons, 2 )
                number_of_Hidden_Layer_Neurons_Text = [ number_of_Hidden_Layer_Neurons_Text '_' num2str( number_of_Hidden_Layer_Neurons(1, index) ) ];
            end

            number_of_Hidden_Layer_Neurons_Text = [ '(' number_of_Hidden_Layer_Neurons_Text(1, 2: end) ')' ];
                
        % Plot
            handle = Drawing_and_Saving_a_Java_GUI_in_a_Figure ( net, [ Saving_Address '\' 'FaradarsV2_Perceptron_Neural_Network' '_' number_of_Hidden_Layer_Neurons_Text ] , selected_Saving_Extension );
            close ( handle )

    %% Section 4: Outputs            
        % Level 1: Reforming the 'outputs' in the Range of 'initial ClassLabels'
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );                                    
            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                reformed_Outputs ( dimension_Index, : ) = Reform_Fcn ( outputs ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                
            end
            
         % Level 2: Rounding   
            outputs = round ( reformed_Outputs );
            
         % Level 3: Clamping
            outputs ( outputs > max ( classLabels_from_DataBank ) ) = max ( classLabels_from_DataBank );
            outputs ( outputs < min ( classLabels_from_DataBank ) ) = min ( classLabels_from_DataBank );

         % Level 4: Output 
            temp_Raw_outputs                           = reformed_Outputs;  
            temp_Rounded_and_Clampd_outputs            = outputs;
            
            output.outputs_Train.raw_Output            = temp_Raw_outputs;
            output.outputs_Train.roundedClamped_Output = temp_Rounded_and_Clampd_outputs;
            
            output.outputs_Test.raw_Output             = temp_Raw_outputs;
            output.outputs_Test.roundedClamped_Output  = temp_Rounded_and_Clampd_outputs;
                
                