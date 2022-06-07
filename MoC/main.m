%%%%%%%%%%%%%%
% Title  : Using Method of Characteristics for SERN Design
% Author : Neelay Doshi
%%%%%%%%%%%%%%
%
% This file generates the following datasets:
% -> nozzle_1
% -> nozzle_train 
% -> nozzle_test
%
%%%%%%%%%%%%%%

%% %%%%%%%%%%%%
% Single Dataset
clc
clear
format short g


%%%%%%%%%%%%%%
M0      = 1.5;
Me      = 3;
n       = 50;
gamma   = 1.4;


%%%%%%%%%%%%%%
Table = MoC(M0, Me, n, gamma);
fileID = fopen('data/nozzle_1.txt','w');
fprintf(fileID,'%.4f,%.4f\n', Table([1, 4], :));
fclose(fileID);

fprintf('############# \n');
disp(Table');
fprintf('############# \n');

%% %%%%%%%%%%%%
% Training Dataset
clc
clear
format short g


%%%%%%%%%%%%%%
n       = 50;
gamma   = 1.4;
i = 0;

%%%%%%%%%%%%%%
fprintf('############# \n');
for M0 = 1.4:0.2:2.2

    for Me = 3.4:0.2:5.2
        
        i = i+1;
        fprintf('i = %d \t M0 = %.2f \t Me = %.2f \n', i, M0, Me);

        Table = MoC(M0, Me, n, gamma);
        fileID = fopen('data/nozzle_train.txt','a+');
        fprintf(fileID,'%.4f,%.4f,%.2f,%.2f\n', Table);
        fclose(fileID);       

    end
end

fprintf('############# \n');
fprintf('Number of Nozzles \t\t : %d \n', i );
fprintf('Number of Training Examples \t : %d \n', i*n );
fprintf('############# \n');

%% %%%%%%%%%%%%
% Testing Dataset
clc
clear
format short g


%%%%%%%%%%%%%%
n       = 50;
gamma   = 1.4;
i = 0;

%%%%%%%%%%%%%%
fprintf('############# \n');
for M0 = 1.7 : 0.2 : 2.1

    for Me = 3.7 : 0.2 : 5.1
        
        i = i+1;
        fprintf('i = %d \t M0 = %.2f \t Me = %.2f \n', i, M0, Me);

        Table = MoC(M0, Me, n, gamma);
        fileID = fopen('data/nozzle_test.txt','a+');
        fprintf(fileID,'%.4f,%.4f,%.2f,%.2f\n', Table);
        fclose(fileID);       

    end
end

fprintf('############# \n');
fprintf('Number of Nozzles \t\t : %d \n', i );
fprintf('Number of Testing Examples \t : %d \n', i*n );
fprintf('############# \n');


