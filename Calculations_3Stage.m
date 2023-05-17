function [OutputArray, GraphArray, GraphHolds] = Calculations_3Stage(StageArray)

OutputArray = zeros(2, 10);

%% Array Decoding and Initalization
GrossMass = StageArray(1,1);
Propellant = StageArray(1,2);
ISPSeconds = StageArray(1,3);
TWRatio = StageArray(1,4);

GrossMass2 = StageArray(2,1);
Propellant2 = StageArray(2,2);
ISPSeconds2 = StageArray(2,3);
TWRatio2 = StageArray(2,4);

GrossMass3 = StageArray(3,1);
Propellant3 = StageArray(3,2);
ISPSeconds3 = StageArray(3,3);
TWRatio3 = StageArray(3,4);

%Thrust
OutputArray(1,1) = TWRatio * GrossMass;
%Burntime
OutputArray(1,3) = ISPSeconds * Propellant / OutputArray(1,1);
%FlowRate
OutputArray(1,2) = Propellant / OutputArray(1,3);



Thrust = OutputArray(1,1);
FlowRate = OutputArray(1,2);

Calculations_Stage1 = zeros(10000,11);
Calculations_Stage1 = [Calculations_Stage1(:, 1:3), (0:1:9999)', (1:1:10000)', Calculations_Stage1(:, 6:11)];
Calculations_Stage1(1, 6) = 20902000;
Calculations_Stage1(1, 8) = 0;

%% Stage 1 Calculations

%Calculations_Stage1 = [1 Density, 2 Vinital, 3 Vfinal, 4 Time, 5 Time, 6 RInital, 7 RFinal, 8 HeightInital, 9 GammaInital, 10 GammaFinal, 11 Theta]
for k=1:length(Calculations_Stage1) %<SM:FOR>

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


%OutputArray [Thrust, Flowrate, Burntime, Alt(ft), Alt(nmi), Density, Speed, Angle, Mass, Propellant];
EndStageHOLD = round(OutputArray(1,3)+2);
GraphHolds(1,1) = EndStageHOLD;
EndStage1 = Calculations_Stage1(GraphHolds(1,1), :);

OutputArray(1,4) = EndStage1(1,8);
OutputArray(1,5) = OutputArray(1,4) / 6080;
OutputArray(1,6) = EndStage1(1,1);
OutputArray(1,7) = EndStage1(1,3);
OutputArray(1,8) = EndStage1(1,11);
OutputArray(1,9) = GrossMass-FlowRate*(EndStage1(1,5));
OutputArray(1,10) = GrossMass - Propellant;

GraphArray = Calculations_Stage1(1:GraphHolds(1,1), :);

%% Stage 1 Stall Initalization and Decoding

Calculations_StageStall = zeros(2000,11);
Calculations_StageStall = [Calculations_StageStall(:, 1:3), (0:1:1999)', (1:1:2000)', Calculations_StageStall(:, 6:11)];

Calculations_StageStall(1,2) = EndStage1(1,2);
Calculations_StageStall(1,6) = EndStage1(1,6);
Calculations_StageStall(1,9) = EndStage1(1,9);
GravityStage2 = 32.174*(20920000/(20920000+(OutputArray(1,4))))^2;

%% Stage 1 Stall Calculations

for k=1:length(Calculations_StageStall)
    %Delay V (Inital) (2)
    if k > 1
        Calculations_StageStall(k,2) = Calculations_StageStall((k-1), 3);
    end

    %R Inital (6)
    if k > 1
        Calculations_StageStall(k,6) = Calculations_StageStall((k-1), 7);
    end

    %Height (8)
    Calculations_StageStall(k,8) = Calculations_StageStall(k,6) - 20902000;

    %Gamma Inital(9)
    if k > 1
        Calculations_StageStall(k,9) = Calculations_StageStall((k-1), 10);
    end

    %Gamma Final (10)
    Calculations_StageStall(k,10) = (Calculations_StageStall(k,9))+((((Calculations_StageStall(k,2))/(Calculations_StageStall(k,6)))-(GravityStage2/(Calculations_StageStall(k,2))))*cos((Calculations_StageStall(k,9))))*(Calculations_StageStall(k,5) - Calculations_StageStall(k,4));

    %R Final (7)
    Calculations_StageStall(k,7) = (Calculations_StageStall(k,6))+((Calculations_StageStall(k,2))*sin(Calculations_StageStall(k,9)))*(Calculations_StageStall(k,5) - Calculations_StageStall(k,4));

    %Theta (11)
    Calculations_StageStall(k,11) = 90-((Calculations_StageStall(k,9))*180/pi);

    %Air Density (1)
    Calculations_StageStall(k,1) = 0;

    %Delay V (Final) (3)
    Calculations_StageStall(k,3) = (Calculations_StageStall(k,2))+(-(GravityStage2*sin((Calculations_StageStall(k,9))))-((0.5*(Calculations_StageStall(k,1))*25*0.2*(((Calculations_StageStall(k,2)))^2))*32.174/(GrossMass2)))*(Calculations_StageStall(k,5) - Calculations_StageStall(k,4));

end

EndStall1 = Calculations_StageStall(115, :);

%Final Speed, Final Height, Final Angle
EndStageStall = [EndStall1(1,3), EndStall1(1,8), EndStall1(1,11)];
GraphArray = [GraphArray; Calculations_StageStall(1:115, :)];

%% Stage 2 Decoding

%Thrust
OutputArray(2,1) = TWRatio2 * GrossMass2;
%Burntime
OutputArray(2,3) = ISPSeconds2 * Propellant2 / OutputArray(2,1);
%FlowRate
OutputArray(2,2) = Propellant2 / OutputArray(2,3);

Thrust = OutputArray(2,1);
FlowRate = OutputArray(2,2);

Calculations_Stage2 = zeros(10000,11);


Calculations_Stage2 = [Calculations_Stage2(:, 1:3), (0:1:9999)', (1:1:10000)', Calculations_Stage2(:, 6:11)];
Calculations_Stage2(1,2) = EndStall1(1,2);
Calculations_Stage2(1,6) = EndStall1(1,6);
Calculations_Stage2(1,9) = EndStall1(1,9);

%% Stage 2 Calculations

%Calculations_Stage2 = [1 Density, 2 Vinital, 3 Vfinal, 4 Time, 5 Time, 6 RInital, 7 RFinal, 8 HeightInital, 9 GammaInital, 10 GammaFinal, 11 Theta]
for k=1:length(Calculations_Stage2)

    %V Inital (2)
    if k > 1
        Calculations_Stage2(k,2) = Calculations_Stage2((k-1), 3);
    end

    %R Inital (6)
    if k > 1
        Calculations_Stage2(k,6) = Calculations_Stage2((k-1), 7);
    end

    %Height Inital (8)
    Calculations_Stage2(k,8) = Calculations_Stage2(k,6) - 20902000;

    %Gamma Inital(9) and Gamma Final (10)
    if k > 1
        Calculations_Stage2(k,9) = Calculations_Stage2((k-1),10);
    end

    Calculations_Stage2(k,10) = Calculations_Stage2(k,9) +(((Calculations_Stage2(k,2) / Calculations_Stage2(k,6)) - (GravityStage2 / Calculations_Stage2(k,2)) * cos(Calculations_Stage2(k,9)) * (Calculations_Stage2(k,5) - Calculations_Stage2(k,4))));

    %R Final (7)
    Calculations_Stage2(k,7) = Calculations_Stage2(k,6) + ((Calculations_Stage2(k,2) * sin(Calculations_Stage2(k,9))) * (Calculations_Stage2(k,5) - Calculations_Stage2(k,4)));

    %Theta (11)
    Calculations_Stage2(k,11) = 90 - (Calculations_Stage2(k,9) * 180 / pi);

    %Air Density (1)
    Calculations_Stage2(k,1) = 0;

    %V Final (3)
    Calculations_Stage2(k,3) = Calculations_Stage2(k,2) + ((Thrust*GravityStage2/(GrossMass2-FlowRate*Calculations_Stage2(k,4)) - (GravityStage2*sin(Calculations_Stage2(k,9))))) - ((0.5*Calculations_Stage2(k,1)*25*0.2*((Calculations_Stage2(k,2))^2))*GravityStage2/(GrossMass2-FlowRate*Calculations_Stage2(k,4))) * (Calculations_Stage2(k,5) - Calculations_Stage2(k,4));

end


%OutputArray [Thrust, Flowrate, Burntime, Alt(ft), Alt(nmi), Density, Speed, Angle, Mass, Propellant];
EndStageHOLD = round(OutputArray(2,3)+2);
GraphHolds(1,3) = EndStageHOLD;
GraphHolds(1,2) = 115;
EndStage2 = Calculations_Stage2(EndStageHOLD, :); %<SM:DIM> 

OutputArray(2,4) = EndStage2(1,8);
OutputArray(2,5) = OutputArray(2,4) / 6080;
OutputArray(2,6) = EndStage2(1,1);
OutputArray(2,7) = EndStage2(1,3);
OutputArray(2,8) = EndStage2(1,11);
OutputArray(2,9) = GrossMass2-FlowRate*(EndStage2(1,5));
OutputArray(2,10) = GrossMass2 - Propellant2;

GraphArray = [GraphArray; Calculations_Stage2(1:EndStageHOLD, :)]; %<SM:AUG>

%% Clear Statements

clear FinalSpeed;
clear FinalHeight;
clear Angle;
clear EndStageHold;

clear GrossMass;
clear ISPSeconds;
clear Propellant;
clear TWRatio;

clear Thrust;
clear FlowRate;

clear GrossMass2;
clear ISPSeconds2;
clear Propellant2;
clear TWRatio2;
clear GravityStage2;


%% Stage 2 Stall Calculations

Calculations_Stage2Stall = zeros(2000,11);
Calculations_Stage2Stall = [Calculations_Stage2Stall(:, 1:3), (0:1:1999)', (1:1:2000)', Calculations_Stage2Stall(:, 6:11)];

Calculations_Stage2Stall(1,2) = EndStage2(1,2);
Calculations_Stage2Stall(1,6) = EndStage2(1,6);
Calculations_Stage2Stall(1,9) = EndStage2(1,9);
GravityStage3 = 32.174*(20920000/(20920000+(OutputArray(1,4))))^2;

for k=1:length(Calculations_Stage2Stall)
    %Delay V (Inital) (2)
    if k > 1
        Calculations_Stage2Stall(k,2) = Calculations_Stage2Stall((k-1), 3);
    end

    %R Inital (6)
    if k > 1
        Calculations_Stage2Stall(k,6) = Calculations_Stage2Stall((k-1), 7);
    end

    %Height (8)
    Calculations_Stage2Stall(k,8) = Calculations_Stage2Stall(k,6) - 20902000;

    %Gamma Inital(9)
    if k > 1
        Calculations_Stage2Stall(k,9) = Calculations_Stage2Stall((k-1), 10);
    end

    %Gamma Final (10)
    Calculations_Stage2Stall(k,10) = (Calculations_Stage2Stall(k,9))+((((Calculations_Stage2Stall(k,2))/(Calculations_Stage2Stall(k,6)))-(GravityStage3/(Calculations_Stage2Stall(k,2))))*cos((Calculations_Stage2Stall(k,9))))*(Calculations_Stage2Stall(k,5) - Calculations_Stage2Stall(k,4));

    %R Final (7)
    Calculations_Stage2Stall(k,7) = (Calculations_Stage2Stall(k,6))+((Calculations_Stage2Stall(k,2))*sin(Calculations_Stage2Stall(k,9)))*(Calculations_Stage2Stall(k,5) - Calculations_Stage2Stall(k,4));

    %Theta (11)
    Calculations_Stage2Stall(k,11) = 90-((Calculations_Stage2Stall(k,9))*180/pi);

    %Air Density (1)
    Calculations_Stage2Stall(k,1) = 0;

    %Delay V (Final) (3)
    Calculations_Stage2Stall(k,3) = (Calculations_Stage2Stall(k,2))+(-(GravityStage3*sin((Calculations_Stage2Stall(k,9))))-((0.5*(Calculations_Stage2Stall(k,1))*25*0.2*(((Calculations_Stage2Stall(k,2)))^2))*32.174/(GrossMass3)))*(Calculations_Stage2Stall(k,5) - Calculations_Stage2Stall(k,4));

end

EndStall2 = Calculations_Stage2Stall(115, :);

%Final Speed, Final Height, Final Angle
EndStage2Stall = [EndStall2(1,3), EndStall2(1,8), EndStall2(1,11)];
GraphArray = [GraphArray; Calculations_Stage2Stall(1:115, :)];

%% Stage 3 Decoding

%Thrust
OutputArray(3,1) = TWRatio3 * GrossMass3;
%Burntime
OutputArray(3,3) = ISPSeconds3 * Propellant3 / OutputArray(3,1);
%FlowRate
OutputArray(3,2) = Propellant3 / OutputArray(3,3);

Thrust = OutputArray(3,1);
FlowRate = OutputArray(3,2);

Calculations_Stage3 = zeros(10000,11);


Calculations_Stage3 = [Calculations_Stage3(:, 1:3), (0:1:9999)', (1:1:10000)', Calculations_Stage3(:, 6:11)];
Calculations_Stage3(1,2) = EndStall2(1,2);
Calculations_Stage3(1,6) = EndStall2(1,6);
Calculations_Stage3(1,9) = EndStall2(1,9);

%% Stage 3 Calculations

%Calculations_Stage3 = [1 Density, 2 Vinital, 3 Vfinal, 4 Time, 5 Time, 6 RInital, 7 RFinal, 8 HeightInital, 9 GammaInital, 10 GammaFinal, 11 Theta]
for k=1:length(Calculations_Stage3)

    %V Inital (2)
    if k > 1
        Calculations_Stage3(k,2) = Calculations_Stage3((k-1), 3);
    end

    %R Inital (6)
    if k > 1
        Calculations_Stage3(k,6) = Calculations_Stage3((k-1), 7);
    end

    %Height Inital (8)
    Calculations_Stage3(k,8) = Calculations_Stage3(k,6) - 20902000;

    %Gamma Inital(9) and Gamma Final (10)
    if k > 1
        Calculations_Stage3(k,9) = Calculations_Stage3((k-1),10);
    end

    Calculations_Stage3(k,10) = Calculations_Stage3(k,9) +(((Calculations_Stage3(k,2) / Calculations_Stage3(k,6)) - (GravityStage3 / Calculations_Stage3(k,2)) * cos(Calculations_Stage3(k,9)) * (Calculations_Stage3(k,5) - Calculations_Stage3(k,4))));

    %R Final (7)
    Calculations_Stage3(k,7) = Calculations_Stage3(k,6) + ((Calculations_Stage3(k,2) * sin(Calculations_Stage3(k,9))) * (Calculations_Stage3(k,5) - Calculations_Stage3(k,4)));

    %Theta (11)
    Calculations_Stage3(k,11) = 90 - (Calculations_Stage3(k,9) * 180 / pi);

    %Air Density (1)
    Calculations_Stage3(k,1) = 0;

    %V Final (3)
    Calculations_Stage3(k,3) = Calculations_Stage3(k,2) + ((Thrust*GravityStage3/(GrossMass3-FlowRate*Calculations_Stage3(k,4)) - (GravityStage3*sin(Calculations_Stage3(k,9))))) - ((0.5*Calculations_Stage3(k,1)*25*0.2*((Calculations_Stage3(k,2))^2))*GravityStage3/(GrossMass3-FlowRate*Calculations_Stage3(k,4))) * (Calculations_Stage3(k,5) - Calculations_Stage3(k,4));

end


%OutputArray [Thrust, Flowrate, Burntime, Alt(ft), Alt(nmi), Density, Speed, Angle, Mass, Propellant];
EndStageHOLD = round(OutputArray(2,3)+2);
GraphHolds(1,5) = EndStageHOLD;
GraphHolds(1,4) = 115;
EndStage3 = Calculations_Stage3(EndStageHOLD, :); %<SM:DIM> 

OutputArray(3,4) = EndStage3(1,8);
OutputArray(3,5) = OutputArray(2,4) / 6080;
OutputArray(3,6) = EndStage3(1,1);
OutputArray(3,7) = EndStage3(1,3);
OutputArray(3,8) = EndStage3(1,11);
OutputArray(3,9) = GrossMass3-FlowRate*(EndStage3(1,5));
OutputArray(3,10) = GrossMass3 - Propellant3;

GraphArray = [GraphArray; Calculations_Stage3(1:EndStageHOLD, :)]; %<SM:AUG>