function [AltitudeGraph, ThetaGraph, CargoAltitudeGraph, CargoThetaGraph, MaxAlt] = GraphFunction_1Stage(GraphArray, CargoGraphArray, GoalPerigee, GoalAngle) %<SM:PDF_PARAM>  %<SM:PDF_RETURN> 

VelocityGraphY = GraphArray(:,2);
AltitudeGraphY = GraphArray(:,8);
ThetaGraphY = GraphArray(:,11);
DeltaTime = (0:1:length(GraphArray)-1);

CargoVelocityGraphY = GraphArray(:,2);
CargoDeltaTime = (0:1:length(CargoGraphArray)-1);
CargoAltitudeGraphY = CargoGraphArray(:,8); %<SM:SLICE>
CargoThetaGraphY = CargoGraphArray(:,11);

%% Rocket Graphs
    %Altitude Graph
    subplot(2,3,1);
    AltitudeGraph = plot(DeltaTime, AltitudeGraphY);
        hold on;
            title('Dry Altitude vs Time');
            xlabel('Time (Seconds)');
            ylabel('Altitude (Feet)');
            xlim([0, length(DeltaTime)]);
            ylim([0,3000000]);
            if max(AltitudeGraphY) > 3000000
                ylim([0, max(AltitudeGraphY)+5000]);
            end

            AltitudeGraph.LineWidth = 2;

            plot(max(DeltaTime),max(AltitudeGraphY),'r*')
            LabelString = sprintf('%.f Feet',max(AltitudeGraphY));
            text(max(DeltaTime)+10,max(AltitudeGraphY)+10000, LabelString);
            MaxAlt = max(AltitudeGraphY);


            yline(607611.6588, 'r');
            text(20,607611.6588+50000, 'Minimum LEO (607611 ft)');

            if GoalPerigee ~= 607611.6588
                LabelString2 = sprintf('Orbit Goal (%.f ft)', GoalPerigee);
                yline(GoalPerigee, 'g');
                text(20,GoalPerigee+50000, LabelString2); 
            end

    if GoalPerigee ~= 607611.6588
        legend({'Stage 1', 'Stall', 'Stage 2', 'Max Height', 'LEO', 'Goal'},'Location','northwest','NumColumns',2);
    else
        legend({'Stage 1', 'Stall', 'Stage 2', 'Max Height', 'LEO'},'Location','northwest','NumColumns',2);
    end
    hold off;

    %Theta Graph
    subplot(2,3,2);
    ThetaGraph = plot(DeltaTime, ThetaGraphY, 'g');
        hold on;
            title('Dry Theta vs Time');
            xlabel('Time (Seconds)');
            ylabel('Theta (Degrees)');
            xlim([0, length(DeltaTime)]);
            ylim([0,100]);
            if max(ThetaGraphY) > 100
                ylim([0,max(ThetaGraphY) + 10]);
            end
            
            xl = xlim;
            xBox = [xl(1), xl(1), xl(2), xl(2), xl(1)];
            yBox = [75, 90, 90, 75, 75];
            patch(xBox, yBox, 'red', 'FaceColor', 'red', 'FaceAlpha', 0.1);
            ThetaGraph.LineWidth = 2;
            text(50, 78, 'Orbit Inclination Range');

            if GoalPerigee ~= 607611.6588
                OrbitAngleMax = GoalAngle + 7.5;
                OrbitAngleMin = GoalAngle - 7.5;
                yBox = [OrbitAngleMax, OrbitAngleMin, OrbitAngleMin, OrbitAngleMax, OrbitAngleMax];
                patch(xBox, yBox, 'blue', 'FaceColor', 'blue', 'FaceAlpha', 0.1);
                ThetaGraph.LineWidth = 2;
                text(50, OrbitAngleMin+3, 'Orbit Goal Inclination Range');
            end

            plot(max(DeltaTime),max(ThetaGraphY),'r*')
            LabelString = sprintf('%.2f Degrees',max(ThetaGraphY));
            text(max(DeltaTime)+5,max(ThetaGraphY)-5, LabelString);
        hold off;

%Velocity Graph
subplot(2,3,3);
VelocityGraph = plot(DeltaTime, VelocityGraphY);

hold on;

    VelocityGraph.LineWidth = 2;

    title('Dry Velcoity vs Time');
    xlabel('Time (Seconds)');
    ylabel('Speed (Feet/Sec))');
    xlim([0, length(DeltaTime)]);
    ylim([0,50000]);
    if max(VelocityGraphY) > 50000
        ylim([0, max(AltitudeGraphY)+2500]);
    end
    
    yline(36745.41, 'r');
    text(20, 36745.41+1500, 'Earth Escape Velocity');

    yline(25666.667, 'g');
    text(20, 25666.667+1500, 'Earth Orbit Velocity');
hold off;

%% Cargo Graphs

    %Altitude Graph
    subplot(2,3,4);
    CargoAltitudeGraph = plot(CargoDeltaTime, CargoAltitudeGraphY);
        hold on;
            title('Cargo Altitude vs Time');
            xlabel('Time (Seconds)');
            ylabel('Altitude (Feet)');
            xlim([0, length(DeltaTime)]);
            ylim([0,3000000]);
            if max(AltitudeGraphY) > 3000000
                ylim([0, max(AltitudeGraphY)+5000]);
            end

            CargoAltitudeGraph.LineWidth = 2;

            plot(max(CargoDeltaTime),max(CargoAltitudeGraphY),'r*')
            LabelString = sprintf('%.f Feet',max(CargoAltitudeGraphY));
            text(max(CargoDeltaTime)+10,max(CargoAltitudeGraphY)+10000, LabelString);

            yline(607611.6588, 'r');
            text(20,607611.6588+50000, 'Minimum LEO (607611 ft)');

            if GoalPerigee ~= 607611.6588
                LabelString2 = sprintf('Orbit Goal (%.f ft)', GoalPerigee);
                yline(GoalPerigee, 'g');
                text(20,GoalPerigee+50000, LabelString2); 
            end
            
    if GoalPerigee ~= 607611.6588
        legend({'Stage 1', 'Stall', 'Stage 2', 'Max Height', 'LEO', 'Goal'},'Location','northwest','NumColumns',2);
    else
        legend({'Stage 1', 'Stall', 'Stage 2', 'Max Height', 'LEO'},'Location','northwest','NumColumns',2);
    end
    hold off;

    %Theta Graph
    subplot(2,3,5);
    CargoThetaGraph = plot(CargoDeltaTime, CargoThetaGraphY, 'g');
        hold on;
            title('Cargo Theta vs Time');
            xlabel('Time (Seconds)');
            ylabel('Theta (Degrees)');
            xlim([0, length(DeltaTime)]);
            ylim([0,100]);
            if max(ThetaGraphY) > 100
                ylim([0,max(ThetaGraphY) + 10]);
            end

            xl = xlim;
            xBox = [xl(1), xl(1), xl(2), xl(2), xl(1)];
            yBox = [75, 90, 90, 75, 75];
            patch(xBox, yBox, 'red', 'FaceColor', 'red', 'FaceAlpha', 0.1);
            CargoThetaGraph.LineWidth = 2;
            text(50, 78, 'Orbit Inclination Range');

            if GoalPerigee ~= 607611.6588
                OrbitAngleMax = GoalAngle + 7.5;
                OrbitAngleMin = GoalAngle - 7.5;
                yBox = [OrbitAngleMax, OrbitAngleMin, OrbitAngleMin, OrbitAngleMax, OrbitAngleMax];
                patch(xBox, yBox, 'blue', 'FaceColor', 'blue', 'FaceAlpha', 0.1);
                ThetaGraph.LineWidth = 2;
                text(50, OrbitAngleMin+3, 'Orbit Goal Inclination Range');
            end

            plot(max(CargoDeltaTime),max(CargoThetaGraphY),'r*')
            LabelString = sprintf('%.2f Degrees',max(CargoThetaGraphY));
            text(max(CargoDeltaTime)+5,max(CargoThetaGraphY)-5, LabelString);
        hold off;

%Velocity Graph
subplot(2,3,6);
CargoVelocityGraph = plot(DeltaTime, CargoVelocityGraphY);

hold on;
    
    CargoVelocityGraph.LineWidth = 2;
    
    title('Cargo Velcoity vs Time');
    xlabel('Time (Seconds)');
    ylabel('Speed (Feet/Sec))');
    xlim([0, length(DeltaTime)]);
    ylim([0,50000]);
    if max(CargoVelocityGraphY) > 50000
        ylim([0, max(AltitudeGraphY)+2500]);
    end
    
    yline(36745.41, 'r');
    text(20, 36745.41+1500, 'Earth Escape Velocity');

    yline(25666.667, 'g');
    text(20, 25666.667+1500, 'Earth Orbit Velocity');
hold off;