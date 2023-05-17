function [OutputArray, GraphArray, GraphHold] = Calculations_1Stage(StageArray)
%% Burn Calculations
%Array Decoding%
GrossMass = StageArray(1,1);
Propellant = StageArray(1,2);
ISPSeconds = StageArray(1,3);
TWRatio = StageArray(1,4);

%OutputArray Init
OutputArray(1,1) = TWRatio * GrossMass; %Thrust
OutputArray(1,3) = (ISPSeconds * Propellant / OutputArray(1,1)); %Burntime
OutputArray(1,2) = Propellant / OutputArray(1,3); %FlowRate

Thrust = OutputArray(1,1);
FlowRate = OutputArray(1,2);


%Calculations Burn 1
    %1 Density, 2 Vinital, 3 Vfinal, 4 Time, 5 Time, 6 RInital, 7 RFinal, 8 HeightInital, 9 GammaInital, 10 GammaFinal, 11 Theta
    
    %Array Init%
    Calculations_Stage1 = zeros(10000,11);
    Calculations_Stage1 = [Calculations_Stage1(:, 1:3), (0:1:9999)', (1:1:10000)', Calculations_Stage1(:, 6:11)];

    %Array PreDefined%
    Calculations_Stage1(1, 6) = 20902000;
    Calculations_Stage1(1, 8) = 0;

    %Main Calculations%
    for k=1:length(Calculations_Stage1)

        %V Inital (2)
        if k > 1
            Calculations_Stage1(k,2) = Calculations_Stage1((k-1), 3);
        end

        %R Inital (6)
        if k > 1
            Calculations_Stage1(k,6) = Calculations_Stage1((k-1), 7);
        end

        %Height Inital (8)
        Calculations_Stage1(k,8) = Calculations_Stage1(k,6) - 20902000;

        %Gamma Inital(9) and Gamma Final (10)
        if Calculations_Stage1(k,8) < 30000
            Calculations_Stage1(k,9) = pi/2;
        elseif Calculations_Stage1(k,8) > 30000 && Calculations_Stage1((k-1),10) == pi/2
            Calculations_Stage1(k,9) = ((pi/2) - 10*pi/180);
        else
            Calculations_Stage1(k,9) = Calculations_Stage1((k-1),10);
        end

        if Calculations_Stage1(k,9) == pi/2
            Calculations_Stage1(k,10) = pi/2;
        else
            %Calculations_Stage1(k,10) = Calculations_Stage1(k,9) + (((Calculations_Stage1(k,2) / Calculations_Stage1(1,6)) - (32.174 / Calculations_Stage1(k,2)) * cos(Calculations_Stage1(k,9)) * ((Calculations_Stage1(k,5) - Calculations_Stage1(k,4)))));
            Calculations_Stage1(k,10) = Calculations_Stage1(k,9) +(((Calculations_Stage1(k,2) / Calculations_Stage1(k,6)) - (32.174 / Calculations_Stage1(k,2)) * cos(Calculations_Stage1(k,9)) * (Calculations_Stage1(k,5) - Calculations_Stage1(k,4))));

        end

        %R Final (7)
        Calculations_Stage1(k,7) = Calculations_Stage1(k,6) + ((Calculations_Stage1(k,2) * sin(Calculations_Stage1(k,9))) * (Calculations_Stage1(k,5) - Calculations_Stage1(k,4)));

        %Theta (11)
        Calculations_Stage1(k,11) = 90 - (Calculations_Stage1(k,9) * 180 / pi);

        %Air Density (1)
        if Calculations_Stage1(k,8) < 36000
            Calculations_Stage1(k,1) = (2.38*10^-3)*((519-0.00357*(Calculations_Stage1(k,8)))/519)^4.25;

        elseif Calculations_Stage1(k,8) < 65600
            Calculations_Stage1(k,1) = (7.05*10^-4)*(exp((4.808*10^-5)*(36000-Calculations_Stage1(k,8))));

        elseif Calculations_Stage1(k,8) < 106600
            Calculations_Stage1(k,1) = (1.699*10^-4)*((390+(9.8*10^-4)*((Calculations_Stage1(k,8))-65600))/390)^(-20.13);
        else
            Calculations_Stage1(k,1) = 0;

        end

        %V Final (3)
        Calculations_Stage1(k,3) = Calculations_Stage1(k,2) + ((Thrust*32.174/(GrossMass-FlowRate*Calculations_Stage1(k,4)) - (32.174*sin(Calculations_Stage1(k,9))))) - ((0.5*Calculations_Stage1(k,1)*75*0.2*((Calculations_Stage1(k,2))^2))*32.174/(GrossMass-FlowRate*Calculations_Stage1(k,4))) * (Calculations_Stage1(k,5) - Calculations_Stage1(k,4));
        %Calculations_Stage1(k,3) = (Calculations_Stage1(k,2) + ((Thrust*32.174/(GrossMass-FlowRate*Calculations_Stage1(k,4)) - (32.174*sin(Calculations_Stage1(k,9))))) - ((0.5*Calculations_Stage1(k,1)*75*0.2*((Calculations_Stage1(k,2))^2))*32.174/(GrossMass-FlowRate*Calculations_Stage1(k,4))) * (Calculations_Stage1(k,5) - Calculations_Stage1(k,4)))/10;

    end

%% OutputArray

    %[Thrust, Flowrate, Burntime, Alt(ft), Alt(nmi), Density, Speed, Angle, Mass, Propellant];
    EndBurn = round(OutputArray(1,3)+2);
    GraphHold(1,1) = EndBurn;
    GraphHold(1,2:3) = 0;
    EndStage1 = Calculations_Stage1(EndBurn, :);
    
    OutputArray(1,4) = EndStage1(1,8);
    OutputArray(1,5) = OutputArray(1,4) / 6080;
    OutputArray(1,6) = EndStage1(1,1);
    OutputArray(1,7) = EndStage1(1,3);
    OutputArray(1,8) = EndStage1(1,11);
    OutputArray(1,9) = GrossMass-FlowRate*(EndStage1(1,5));
    OutputArray(1,10) = GrossMass - Propellant;

    GraphArray = Calculations_Stage1(1:EndBurn, :);