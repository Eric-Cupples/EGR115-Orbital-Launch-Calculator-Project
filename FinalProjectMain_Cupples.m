%{
Documentation 
    Name: Eric Cupples
    Email: cupplese@my.erau.edu
    Date Started: Nov 09, 2022
    Date Due: Dec 11, 2022
    Course: EGR 115 - Section 12DB
    Assignment: Final Project
    Problem: See Previous Project Submission  

%Scoring Marker Locations
    %<SM:ROP> - @Line 120
    %<SM:ROP> - @Line 125
    %<SM:BOP> - @Line 29
    %<SM:BOP> - @Line 263
    %<SM:IF> / %<SM:SWITCH> - @Line 34
    %<SM:IF> / %<SM:SWITCH> - @Line 211
    %<SM:FOR> - @Line 131
    %<SM:FOR> - Calculations_2Stage.m @Line 36
    %<SM:WHILE> - @Line 120
    %<SM:WHILE> - @Line 125
    %<SM:NEST> - @Line 101
    %<SM:NEST> - @Line 171
    %<SM:PDF> - @Line 189
    %<SM:PDF> - @Line 262
    %<SM:PDF_PARAM> - GraphFunction_2Stage @Line 1
    %<SM:PDF_RETURN> - GraphFunction_2Stage @Line 1
    %<SM:STRING> - @Line 29
    %<SM:REF> - @Line 172
    %<SM:SLICE> - GraphFunction.m @Line 8
    %<SM:AUG> - Calculations_2Stage.m @Line 238
    %<SM:DIM> - Calculations_2Stage.m @Line 228
    %<SM:TOTAL> / %<SM:SORT> / %<SM:SEARCH> - @Line 35
    %<SM:RANDGEN> - @Line 90
    %<SM:RANDUSE> - @Line 189
    %<SM:PLOT> - GraphFunction.m @Line 15
    %<SM:READ> - @Line 20
    %<SM:WRITE> - @Line 290
    %<SM:NEWFUN> - GraphFunction.m @Line 54
    %<SM:NEWFUN> - @Line 260

%}

clear
clc
close all
commandwindow

%Primary Init Variables
Repeat = 1;
StageArray = zeros;
BoosterArray = zeros;
RocketDatabase = readcell("RocketDatabase.xlsx"); %<SM:READ>
x = 500000;

%Start of Code%
while Repeat == 1
%% Rocket Configuration 

    fprintf('Welcome to the Launch Vehicle Calculator.') %Primary Mode Select
    CalculatorSetting = input('\nPlease select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): ', 's'); %Database includes Retired, Hypothetical, and Active Databases
    while ~(strcmpi(CalculatorSetting, 'database') || strcmpi(CalculatorSetting, 'saved') || strcmpi(CalculatorSetting, 'random') || strcmpi(CalculatorSetting, 'custom') || strcmpi(CalculatorSetting, 'demo')) %<SM:STRING> %<SM:BOP> 
        CalculatorSetting = input('\nError! That is not a valid input. Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): ', 's');
    end
 
%DATABASE ROCKET
    if strcmpi(CalculatorSetting, 'database')  %<SM:IF>
        SearchedDatabase = RocketDatabase(strcmpi(RocketDatabase(:,2), 'database'), :); %<SM:SEARCH>

        fprintf('This database includes the following rockets: ');
        RowSize = size(SearchedDatabase(:,1));
        for k=1:RowSize
            fprintf('\n\t%s', SearchedDatabase{k,1});
        end

        SelectedRocket = input('\nPlease enter the name of the rocket you would like to use (Enter the name exactly as it is written above): ', 's');
        while ~(strcmpi(SelectedRocket, SearchedDatabase(:,1)))
            SelectedRocket = input('\nError! That is not a valid input. Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): ', 's');
        end

        %Decoding varaibels from selected rocket and translating them into Arrays called by the math function. 
        SearchedDatabase = RocketDatabase(strcmpi(RocketDatabase(:,1), SelectedRocket), :);
        nStages = cell2mat(SearchedDatabase(1,3));
        nBoosters = cell2mat(SearchedDatabase(1,4));
        StageArray = [SearchedDatabase(1,5), SearchedDatabase(1,6), SearchedDatabase(1,8), SearchedDatabase(1,7); SearchedDatabase(1,9), SearchedDatabase(1,10), SearchedDatabase(1,12), SearchedDatabase(1,11); SearchedDatabase(1,13), SearchedDatabase(1,14), SearchedDatabase(1,16), SearchedDatabase(1,15)];
        StageArray = cell2mat(StageArray);
        GeneralRocket = {SearchedDatabase{1,1}, nStages, nBoosters};

%SAVED ROCKET
    elseif strcmpi(CalculatorSetting, 'saved')

        %Same program as above, just searched for a diffrent group of rockets from within the same database. 
        SearchedDatabase = RocketDatabase(strcmpi(RocketDatabase(:,2), 'saved'), :);
        fprintf('This database includes the following rockets: ');
        RowSize = size(SearchedDatabase(:,1));
        for k=1:RowSize
            fprintf('\n\t%s', SearchedDatabase{k,1});
        end

        SelectedRocket = input('\nPlease enter the name of the rocket you would like to use (Enter the name exactly as it is written above): ', 's');
        while ~(strcmpi(SelectedRocket, SearchedDatabase(:,1)))
            SelectedRocket = input('\nError! That is not a valid input. Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): ', 's');
        end

        %Decoding varaibels from selected rocket and translating them into Arrays called by the math function. 
        SearchedDatabase = RocketDatabase(strcmpi(RocketDatabase(:,1), SelectedRocket), :);
        nStages = cell2mat(SearchedDatabase(1,3));
        nBoosters = cell2mat(SearchedDatabase(1,4));
        StageArray = [SearchedDatabase(1,5), SearchedDatabase(1,6), SearchedDatabase(1,8), SearchedDatabase(1,7); SearchedDatabase(1,9), SearchedDatabase(1,10), SearchedDatabase(1,12), SearchedDatabase(1,11); SearchedDatabase(1,13), SearchedDatabase(1,14), SearchedDatabase(1,16), SearchedDatabase(1,15)];
        StageArray = cell2mat(StageArray);
        GeneralRocket = {SearchedDatabase{1,1}, nStages, nBoosters};


%RANDOM ROCKET
    elseif strcmpi(CalculatorSetting, 'random')

        %Randomly generates numbers for atrabutes of a rocket, the same variables that are asked when adding a custom rocket. 
        fprintf('\nHint: Enter any name as a String (Example: Powerful Rocket)');
        RocketName = input('\nPlease enter a name for this rocket: ', 's');
        nStages = randi(3);
        nBoosters = randi(8);

        for k=1:nStages
            StageArray(k,1) = 1000 + rand()*(40000000-1000); %<SM:RANDGEN>
            StageArray(k,1) = StageArray(k,1);

            StageArray(k,2) = StageArray(k,1)*0.4 + rand()*((StageArray(k,1)*0.9)-(StageArray(k,1)*0.4));
            StageArray(k,2) = StageArray(k,2);

            StageArray(k,4) = 0.75 + rand(1)*(4-0.75);
            StageArray(k,4) = StageArray(k,4);

            StageArray(k,3) = 100 + rand(1)*(542-100);
            StageArray(k,3) = StageArray(k,3);
        end

        if nBoosters > 0  %<SM:NEST>
            StageArray(1,1) = StageArray(1,1) + (1300000*nBoosters);
            StageArray(1,2) = StageArray(1,2) + (1100000*nBoosters);
            StageArray(1,3) = (StageArray(1,3) + 242)/1.5;
        end
       GeneralRocket = {RocketName, nStages, nBoosters};

       fprintf('%s will have %d stage(s) and %d booster(s)', GeneralRocket{1,1}, GeneralRocket{1,2}, GeneralRocket{1,3});


%CUSTOM ROCKET
    elseif strcmpi(CalculatorSetting, 'custom')

        fprintf('\nHint: Enter any name as a String (Example: Powerful Rocket).');
        RocketName = input('\nPlease enter a name for this rocket: ', 's');
       
        %Main Rocket Inputs%
        nStages = input('\nEnter the number of rocket stages (Maximum of 3 Core Stages): ');
        while isempty(nStages) || nStages > 3 || nStages <= 0 %<SM:WHILE>   %<SM:ROP> 
            nStages = input('Error, that is an invalid input. Enter the number of rocket stages: ');
        end

        nBoosters = input('\nEnter the number of side boosters (Maximum of 8 Boosters): ');
        while isempty(nBoosters) || nBoosters > 8 || nBoosters < 0 %<SM:WHILE>   %<SM:ROP> 
            nBoosters = input('Error, that is an invalid input. Enter the number of side boosters: ');
        end

        GeneralRocket = {RocketName, nStages, nBoosters};

        %Questions for each stage: Mass, Propellant, ISP, and TW Ratio
        for k=1:nStages %<SM:FOR>
            fprintf('\n\nData for Stage %d:', k)
            fprintf('\nHint: Enter any number between 1000 to 40000000');
            StageArray(k,1) = input('\nEnter the Gross Mass of this stage: ');
            while isempty(StageArray(k,1)) || StageArray(k,1) > 40000000 || StageArray(k,1) <= 1000
                StageArray(k,1) = input('\nError, that is an invalid input. Enter the Gross Mass of this stage: ');
            end
            StageArray(k,1) = StageArray(k,1);

            RecPropellant = StageArray(k,1) * 0.80;
            fprintf('\nHint:80%% of a rockets gross mass should be dedicated to fuel. With a %.2f kg rocket, we recommend %.2f kg of propellant.', StageArray(k,1), RecPropellant);
            StageArray(k,2) = input('\nEnter the propellant of this stage: ');
            while isempty(StageArray(k,2)) || StageArray(k,2) > StageArray(k,1) || StageArray(k,2) <= (0.4*StageArray(k,1))
                StageArray(k,2) = input('\nError, that is an invalid input. Enter the propellant of this stage: ');
            end

            fprintf('\nISP Hint: 250 to 500 (Enter a number 60 to 542)');
            StageArray(k,3) = input('\nEnter the Specfic Impulse (ISP) of this stage: ');
            while isempty(StageArray(k,3)) || StageArray(k,3) > 542 || StageArray(k,3) <= 60
                StageArray(k,3) = input('\nError, that is an invalid input. Enter the ISP of this stage : ');
            end

            fprintf('\nThrust to Weight Ratio Hint: 1.1 to 2 and up to 4 when in space (Enter a number 0.1 to 4)');
            StageArray(k,4) = input('\nEnter the thrust to weight ratio of this stage: ');
            while isempty(StageArray(k,4)) || StageArray(k,4) > 4 || StageArray(k,4) <= 0.1
                StageArray(k,4) = input('\nError, that is an invalid input. Enter the thrust to weight ratio of this stage: ');
            end

        end

        %Booster Inputs%
        if nBoosters > 0  %<SM:NEST>
            StageArray(1,1) = StageArray(1,1) + (1300000*nBoosters); %<SM:REF>
            StageArray(1,2) = StageArray(1,2) + (1100000*nBoosters);
            StageArray(1,3) = (StageArray(1,3) + 242)/1.5; 
        end

%Demo Rocket
    elseif strcmpi(CalculatorSetting, 'Demo')
        %Rocket used for testing later functions in code and providing a quick and easy demo for the user. 
        StageArray = [200000, 150000, 320, 1.1; 33000, 28000, 290, 2.6];
        nStages = 2;
        nBoosters = 0;
        GeneralRocket = {'Demo Rocket', 2, 0};

    end

%PRIMARY MATH PROGRAM DECLERATION
%Takes the data from whatever mode was selected and sends it to the math PDF
    if nStages == 1
        [OutputArray, GraphArray, GraphHold] = Calculations_1Stage(StageArray);%<SM:PDF> %<SM:RANDUSE>(When Random is Selected from the menu)

    elseif nStages == 2
        [OutputArray,GraphArray, GraphHold] = Calculations_2Stage(StageArray);

    elseif nStages == 3
        [OutputArray, GraphArray, GraphHold] = Calculations_3Stage(StageArray);

    end

    fprintf(2, '\n\nRocket Calculations Complete!\n\n');

%% General Rocket Questions

%Orbit
    Orbit = input('\nPlease select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): ', 's');
        while ~(strcmpi(Orbit, 'LEO') || strcmpi(Orbit, 'ISS') || strcmpi(Orbit, 'GEO') || strcmpi(Orbit, 'Luna') || strcmpi(Orbit, 'Optimal') || strcmpi(Orbit, 'Custom'))
            Orbit = input('\nError! That is not a valid input. Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default)): ', 's');
        end
    [GoalPerigee, Inclination] = OrbitData(Orbit);

%CARGO
    %Crates a second rocket but with a payload and compares it to the one previously generated
    Cargo = input('\nWill the launch vehicle being carrying a payload? (Enter "yes" or "no"): ', 's');
    while ~(strcmpi(Cargo, 'Yes') || strcmpi(Cargo, 'No'))
        Cargo = input('\nError! That is not a valid input. Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): ', 's');
    end


    if strcmpi(Cargo, 'Yes')  %<SM:IF>
        CargoWeight = input('\nEnter the payload mass (in kg) (Enter any number above 0): ');
        

        while isempty(CargoWeight) || CargoWeight <= 0
            CargoWeight = input('\nError, that is not a valid input. Enter the payload mass (in kg): ');
        end
   
        CargoStageArray = StageArray;
        for k=1:nStages
            CargoStageArray(k,1) = CargoStageArray(k,1) + CargoWeight;
            CargoStageArray(k,4) = OutputArray(k,1) / CargoStageArray(k,1);
        end

        if size(StageArray(:,1),1) == 1
            [CargoOutputArray, CargoGraphArray, CargoGraphHold] = Calculations_1Stage(CargoStageArray);

        elseif size(StageArray(:,1),1) == 2
            [CargoOutputArray,CargoGraphArray, CargoGraphHold] = Calculations_2Stage(CargoStageArray);

        elseif size(StageArray(:,1),1) == 3
            [CargoOutputArray, CargoGraphArray, CargoGraphHold] = Calculations_3Stage(CargoStageArray);

        end

        fprintf('\n\nRocket Calculations Complete!\n\n');
    else 
        CargoOutputArray = OutputArray;
        CargoGraphArray = GraphArray; 
    end
    
%% Outputs
%MasterGraphCell = {mat2cell(GraphArray, GraphHold, 11), mat2cell(CargoGraphArray, GraphHold, 11)};

%Graph Function dependent on how many stages
if nStages == 1
    [AltitudeGraph, ThetaGraph, CargoAltitudeGraph, CargoThetaGraph, MaxAlt] = GraphFunction_1Stage(GraphArray, CargoGraphArray, GoalPerigee, Inclination);

elseif nStages == 2
    [AltitudeGraph, ThetaGraph, CargoAltitudeGraph, CargoThetaGraph, MaxAlt] = GraphFunction_2Stage(GraphArray, CargoGraphArray, GraphHold, GoalPerigee, Inclination);

elseif nStages == 3
    [AltitudeGraph, ThetaGraph, CargoAltitudeGraph, CargoThetaGraph, MaxAlt] = GraphFunction_3Stage(GraphArray, CargoGraphArray, GraphHold, GoalPerigee, Inclination);
end

%Prompts if the rocket is stable or unstable
if OutputArray(nStages, 4) > 607611.6588 %<SM:BOP> 
    fprintf(2, '\nThis rocket is STABLE!');
elseif MaxAlt > 50000 && OutputArray(nStages, 4) < 607611.6588
    fprintf(2, '\nThis rocket will return, it does not need to be orbit stable.')
else
    fprintf(2, '\nWARNING! This rocket is UNSTABLE!');
end


%Primary Print Statements
fprintf('\n\nRocket Statistics:');
fprintf('\n\t%s will achieve a maximum height of %.2fft without cargo.', GeneralRocket{1,1}, OutputArray(nStages, 4));
fprintf('\n\t%s will have a inclination at burnout of %.2f degrees without cargo.', GeneralRocket{1,1}, OutputArray(nStages, 8));
fprintf('\n\t%s will have a maximum speed of %.f ft/sec without cargo.', GeneralRocket{1,1}, OutputArray(nStages, 7));

%Will it be able to reach the orbit goal print statements
if strcmpi(Orbit, 'LEO') || strcmpi(Orbit, 'ISS') || strcmpi(Orbit, 'GEO') || strcmpi(Orbit, 'Luna') || strcmpi(Orbit, 'Custom')
    if GoalPerigee <= OutputArray(nStages, 4)
        fprintf('\n\t%s will be able to achieve its goal of a %s orbit.', GeneralRocket{1,1}, Orbit);
    elseif strcmpi(Orbit, 'Custom') && GoalPerigee <= OutputArray(nStages, 4)
        fprintf('\n\t%s will be able to achieve its custom goal of %.f foot orbit.', GeneralRocket{1,1}, GoalPerigee)
    elseif strcmpi(Orbit, 'Luna') && 36745.41 <= max(GraphArray(:,2))
        fprintf('\n\t%s will be able to achieve its goal of LUNA orbit.', GeneralRocket{1,1})
    else
        fprintf(2, '\n\t%s will be FAIL to achive its goal of a %s orbit.', GeneralRocket{1,1}, Orbit);
    end
end

%Secondary Print Statements (When Comparing 2 rockets one with and one without cargo onboard)
if strcmpi(Cargo, 'Yes')
    fprintf('\n\n\t%s will achieve a maximum height of %.2fft with cargo.', GeneralRocket{1,1}, CargoOutputArray(nStages, 4));
    fprintf('\n\t%s will have a inclination at burnout of %.2f degrees with cargo.', GeneralRocket{1,1}, CargoOutputArray(nStages, 8));
    fprintf('\n\t%s will have a maximum speed of a %.f ft/sec with cargo.', GeneralRocket{1,1}, CargoOutputArray(nStages, 7));
end

%% File Save and Repeat
Save = input('\n\nWould you like to save your Rocket Data? (Enter "yes" or "no"): ', 's');
    while ~(strcmpi(Save, 'Yes') || strcmpi(Save, 'No'))
        Save = input('\nError! That is not a valid input. Would you like to save your rocket data? (Enter "yes" or "no"): ', 's');
    end
    
    if strcmpi(Save, 'Yes')
        writecell(GeneralRocket); %<SM:WRITE>
        writematrix(OutputArray);
        OpenRow = size(RocketDatabase(:,1));
        OpenRow = OpenRow(1,1) +1;

        %Convertes all data collected into storable data that can be recalled from the database. 
        RocketDatabase(OpenRow,1) = GeneralRocket(1,1);
        RocketDatabase{OpenRow,2} = 'Saved';
        RocketDatabase{OpenRow,3} = nStages;
        RocketDatabase{OpenRow,4} = nBoosters;

        RocketDatabase{OpenRow,5} = StageArray(1,1);
        RocketDatabase{OpenRow,6} = StageArray(1,2);
        RocketDatabase{OpenRow,7} = StageArray(1,4);
        RocketDatabase{OpenRow,8} = StageArray(1,3);
        
        if nStages > 1
            RocketDatabase{OpenRow,9} = StageArray(2,1);
            RocketDatabase{OpenRow,10} = StageArray(2,2);
            RocketDatabase{OpenRow,11} = StageArray(2,4);
            RocketDatabase{OpenRow,12} = StageArray(2,3);
            
            if nStages > 2
                RocketDatabase{OpenRow,13} = StageArray(3,1);
                RocketDatabase{OpenRow,14} = StageArray(3,2);
                RocketDatabase{OpenRow,15} = StageArray(3,4);
                RocketDatabase{OpenRow,16} = StageArray(3,3);
            end
        end
        writecell(RocketDatabase, 'RocketDatabase.xlsx');
        fprintf(2, '\nYour rocket data has been saved. To access it again, select "save" at the start of the program.\n');
    end

%Master Code Repeat
Repeat = input('\nWould you like to run the program again? (Enter "yes" or "no"): ', 's');
    while ~(strcmpi(Repeat, 'Yes') || strcmpi(Repeat, 'No'))
        Repeat = input('\nError! That is not a valid input. Would you like to run the program again? (Enter "yes" or "no"): ', 's');
    end

    if strcmpi(Repeat, 'No')
        Repeat = 0;
    else
        Repeat = 1;
    end
end

%{
Sample Runs

Sample 1 - Database Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): Database
    This database includes the following rockets: 
	    NASA Saturn V
	    Launcher Light
	    SpaceX Starship
	    Blue Origin New Glenn (V3)
	    Sea Dragon
	    ULA Atlas V (401)
	    ULA Atlas V (506)
	    SpaceX Falcon 9
	    SpaceX Falcon 9 Heavy
    Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): SpaceX Falcon 9
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): Luna
    
    Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): yes
    
    Enter the payload mass (in kg) (Enter any number above 0): 5000
    
    
    Rocket Calculations Complete!
    
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    SpaceX Falcon 9 will achive a maximum height of 8694758.08ft without cargo.
	    SpaceX Falcon 9 will have a inclination at burnout of 48.79 degrees without cargo.
	    SpaceX Falcon 9 will have a maximum speed of 39099 ft/sec without cargo.
	    SpaceX Falcon 9 will be able to achive its goal of LUNA orbit.
    
	    SpaceX Falcon 9 will achive a maximum height of 7191996.13ft with cargo.
	    SpaceX Falcon 9 will have a inclination at burnout of 57.69 degrees with cargo.
	    SpaceX Falcon 9 will have a maximum speed of a 30552 ft/sec with cargo.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no


Sample 2  - Random Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): random
    
    Hint: Enter any name as a String (Example: Powerful Rocket)
    Please enter a name for this rocket: Sample Rocket
    Sample Rocket will have 3 stage(s) and 2 booster(s)
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): ISS
    
    Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): yes
    
    Enter the payload mass (in kg) (Enter any number above 0): 5000
    
    
    Rocket Calculations Complete!
    
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Sample Rocket will achive a maximum height of 11173215.01ft without cargo.
	    Sample Rocket will have a inclination at burnout of 6.00 degrees without cargo.
	    Sample Rocket will have a maximum speed of 36766 ft/sec without cargo.
	    Sample Rocket will be able to achive its goal of a ISS orbit.
    
	    Sample Rocket will achive a maximum height of 11162612.92ft with cargo.
	    Sample Rocket will have a inclination at burnout of 6.02 degrees with cargo.
	    Sample Rocket will have a maximum speed of a 36734 ft/sec with cargo.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no


Sample 3 - Custom Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): Custom
    
    Hint: Enter any name as a String (Example: Powerful Rocket).
    Please enter a name for this rocket: Sample Rocket
    
    Enter the number of rocket stages (Maximum of 3 Core Stages): 2
    
    Enter the number of side boosters (Maximum of 8 Boosters): 200000
    Error, that is an invalid input. Enter the number of side boosters: 150000
    Error, that is an invalid input. Enter the number of side boosters: 0
    
    
    Data for Stage 1:
    Hint: Enter any number between 1000 to 40000000
    Enter the Gross Mass of this stage: 200000
    
    Hint:80% of a rockets gross mass should be dedicated to fuel. With a 200000.00 kg rocket, we recommend 160000.00 kg of propellant.
    Enter the propellant of this stage: 150000
    
    ISP Hint: 250 to 500 (Enter a number 60 to 542)
    Enter the Specfic Impulse (ISP) of this stage: 320
    
    Thrust to Weight Ratio Hint: 1.1 to 2 and up to 4 when in space (Enter a number 0.1 to 4)
    Enter the thrust to weight ratio of this stage: 1.1
    
    
    Data for Stage 2:
    Hint: Enter any number between 1000 to 40000000
    Enter the Gross Mass of this stage: 33000
    
    Hint:80% of a rockets gross mass should be dedicated to fuel. With a 33000.00 kg rocket, we recommend 26400.00 kg of propellant.
    Enter the propellant of this stage: 28000
    
    ISP Hint: 250 to 500 (Enter a number 60 to 542)
    Enter the Specfic Impulse (ISP) of this stage: 290
    
    Thrust to Weight Ratio Hint: 1.1 to 2 and up to 4 when in space (Enter a number 0.1 to 4)
    Enter the thrust to weight ratio of this stage: 2.6
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): LEO
    
    Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Sample Rocket will achive a maximum height of 800714.37ft without cargo.
	    Sample Rocket will have a inclination at burnout of 89.05 degrees without cargo.
	    Sample Rocket will have a maximum speed of 24268 ft/sec without cargo.
	    Sample Rocket will be able to achive its goal of a LEO orbit.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no

Sample 4 - Demo Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): Demo
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): LEO
    
    Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Demo Rocket will achieve a maximum height of 800714.37ft without cargo.
	    Demo Rocket will have a inclination at burnout of 89.05 degrees without cargo.
	    Demo Rocket will have a maximum speed of 24268 ft/sec without cargo.
	    Demo Rocket will be able to achieve its goal of a LEO orbit.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no

Would you like to run the program again? (Enter "yes" or "no"): no


Sample 5 - Saved Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): Saved
    This database includes the following rockets: 
	    Stock Save (2 Stage)
	    Stock Save (3 Stage)
	    Saved 3 Stage
	    Random
    Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): Saved 3 Stage
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal(Default), Custom): GEO
    
    Will the launch vehicle being carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Saved 3 Stage will achieve a maximum height of 2049008.95ft without cargo.
	    Saved 3 Stage will have a inclination at burnout of 81.58 degrees without cargo.
	    Saved 3 Stage will have a maximum speed of 30370 ft/sec without cargo.
	    Saved 3 Stage will be FAIL to achive its goal of a GEO orbit.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no

%}