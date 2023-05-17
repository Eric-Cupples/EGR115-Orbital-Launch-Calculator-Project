function [GoalPerigee, Inclination] = OrbitData(OrbitType)

    DataMatrix = [607611.6588, 82.5; 1309440, 51.6; 117408000, 50; 1261920000, 85];
    %Row 1 = LEO, Row 2 = ISS, Row 3 = GEO, Row 4 = Luna
    
    if strcmpi(OrbitType, 'LEO')
        GoalPerigee = DataMatrix(1,1);
        Inclination = DataMatrix(1,2);

    elseif strcmpi(OrbitType, 'ISS')
        GoalPerigee = DataMatrix(2,1);
        Inclination = DataMatrix(2,2);

    elseif strcmpi(OrbitType, 'GEO')
        GoalPerigee = DataMatrix(3,1);
        Inclination = DataMatrix(3,2);

    elseif strcmpi(OrbitType, 'Luna')
        GoalPerigee = DataMatrix(4,1);
        Inclination = DataMatrix(4,2);

    elseif strcmpi(OrbitType, 'Optimal')
        GoalPerigee = DataMatrix(1,1);
        Inclination = DataMatrix(1,2);

    elseif strcmpi(OrbitType, 'Custom')
        GoalPerigee = input('Please enter the height you would like this rocket to achive (Enter any number 10000 to 1300000000): ');
        while isempty(GoalPerigee) || GoalPerigee > 1300000000 || GoalPerigee < 10000
            GoalPerigee = input('Error! That is not a valid input! Please enter the height you would like this rocket to achive (Enter any number 10000 to 1300000000): ');
        end

        Inclination = input('Please enter the optimal inclination angle you would like to reach (Enter any number 0 to 100): ');
        while isempty(Inclination) || Inclination < 0 || Inclination > 100
            Inclination = input('Error! That is not a valid input! Please enter the optimal inclination angle you would like to reach (Enter any number 0 to 100): ');
        end

    end
end