# Orbital Launch Calculator EGR115 MATLAB/Simulink Project

This project aims to develop an application that uses both user inputs and a database to calculate launch parameters for rockets. The application will provide outputs such as deltaV, best launch trajectory, maximum height, optimized orbital periods, orbital heights, and other relevant data. The program will support the following features:

Searching and Sorting: The application will implement a database to store rockets, including real and fictional ones. Users will be able to search and sort this database for convenient recall of rocket information.

Analysis: The database will store various variables, numbers, and graphs related to each rocket. Users can analyze this data using MATLAB and within the application itself. The program will utilize arrays and data files to store and process the information effectively.

User Inputs: The application will allow users to enter their own values and variables, enabling customization and calculation of launch parameters based on user-defined inputs. Users can also save their rocket designs to the database for future reference.

Data Export: The program will provide the functionality to export the calculated data in various formats, such as numbers, graphs, and pictures. This feature allows users to use the data outside of the application or reuse it within the program for different purposes.

By integrating user inputs, a comprehensive database, analysis capabilities, and data export options, this application simplifies the process of extrapolating launch parameters for rockets, providing users with valuable insights and facilitating efficient rocket design and optimization.

![image](https://github.com/Eric-Cupples/EGR115-Orbital-Launch-Calculator-Project/assets/69020250/f16c4101-9b11-44b8-bb89-000ed34eb869)

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
    Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): SpaceX 
    Falcon 9
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal (Default), Custom): Luna
    
    Will the launch vehicle be carrying a payload? (Enter "yes" or "no"): yes
    
    Enter the payload mass (in kg) (Enter any number above 0): 5000
    
    
    Rocket Calculations Complete!
    
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    SpaceX Falcon 9 will achieve a maximum height of 8694758.08ft without cargo.
	    SpaceX Falcon 9 will have an inclination at burnout of 48.79 degrees without cargo.
	    SpaceX Falcon 9 will have a maximum speed of 39099 ft/sec without cargo.
	    SpaceX Falcon 9 will be able to achieve its goal of LUNA orbit.
    
	    SpaceX Falcon 9 will achieve a maximum height of 7191996.13ft with cargo.
	    SpaceX Falcon 9 will have an inclination at burnout of 57.69 degrees with cargo.
	    SpaceX Falcon 9 will have a maximum speed of a 30552 ft/sec with cargo.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no


Sample 2 - Random Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): random
    
    Hint: Enter any name as a String (Example: Powerful Rocket)
    Please enter a name for this rocket: Sample Rocket
    Sample Rocket will have 3 stage(s) and 2 booster(s)
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal (Default), Custom): ISS
    
    Will the launch vehicle be carrying a payload? (Enter "yes" or "no"): yes
    
    Enter the payload mass (in kg) (Enter any number above 0): 5000
    
    
    Rocket Calculations Complete!
    
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Sample Rocket will achieve a maximum height of 11173215.01ft without cargo.
	    Sample Rocket will have an inclination at burnout of 6.00 degrees without cargo.
	    Sample Rocket will have a maximum speed of 36766 ft/sec without cargo.
	    Sample Rocket will be able to achieve its goal of an ISS orbit.
    
	    Sample Rocket will achieve a maximum height of 11162612.92ft with cargo.
	    Sample Rocket will have an inclination at burnout of 6.02 degrees with cargo.
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
    
    Hint:80% of a rockets gross mass should be dedicated to fuel. With a 200000.00 kg rocket, we recommend 
    160000.00 kg of propellant.
    Enter the propellant of this stage: 150000
    
    ISP Hint: 250 to 500 (Enter a number 60 to 542)
    Enter the Specific Impulse (ISP) of this stage: 320
    
    Thrust to Weight Ratio Hint: 1.1 to 2 and up to 4 when in space (Enter a number 0.1 to 4)
    Enter the thrust to weight ratio of this stage: 1.1
    
    
    Data for Stage 2:
    Hint: Enter any number between 1000 to 40000000
    Enter the Gross Mass of this stage: 33000
    
    Hint:80% of a rockets gross mass should be dedicated to fuel. With a 33000.00 kg rocket, we recommend 
    26400.00 kg of propellant.
    Enter the propellant of this stage: 28000
    
    ISP Hint: 250 to 500 (Enter a number 60 to 542)
    Enter the Specific Impulse (ISP) of this stage: 290
    
    Thrust to Weight Ratio Hint: 1.1 to 2 and up to 4 when in space (Enter a number 0.1 to 4)
    Enter the thrust to weight ratio of this stage: 2.6
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal (Default), Custom): LEO
    
    Will the launch vehicle be carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Sample Rocket will achieve a maximum height of 800714.37ft without cargo.
	    Sample Rocket will have an inclination at burnout of 89.05 degrees without cargo.
	    Sample Rocket will have a maximum speed of 24268 ft/sec without cargo.
	    Sample Rocket will be able to achieve its goal of a LEO orbit.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no


Sample 4 - Demo Mode
    Welcome to the Launch Vehicle Calculator.
    Please select the configuration of launch vehicle. (Demo, Database, Saved, Random, or Custom): Demo
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal (Default), Custom): LEO
    
    Will the launch vehicle be carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Demo Rocket will achieve a maximum height of 800714.37ft without cargo.
	    Demo Rocket will have an inclination at burnout of 89.05 degrees without cargo.
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
    Please enter the name of the rocket you would like to use (Enter the name exactly as it is written above): Saved 
    3 Stage
    
    
    Rocket Calculations Complete!
    
    
    Please select desired orbit. (Enter: LEO, ISS, GEO, Luna, Optimal (Default), Custom): GEO
    
    Will the launch vehicle be carrying a payload? (Enter "yes" or "no"): no
    
    This rocket is STABLE!
    
    Rocket Statistics:
	    Saved 3 Stage will achieve a maximum height of 2049008.95ft without cargo.
	    Saved 3 Stage will have an inclination at burnout of 81.58 degrees without cargo.
	    Saved 3 Stage will have a maximum speed of 30370 ft/sec without cargo.
	    Saved 3 Stage will FAIL to achieve its goal of a GEO orbit.
    
    Would you like to save your Rocket Data? (Enter "yes" or "no"): no
    
    Would you like to run the program again? (Enter "yes" or "no"): no
