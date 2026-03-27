% DoubleDamBreak_MovingWall.m
% Generates gate motion (displacement) data for the double dam-break cases.
% Output: C**_wdisp.dat files used by OpenFOAM dynamicMeshDict
%         (tabulated6DoFMotion format)
%
% Gate motion profile:
%   Phase 1: Constant acceleration over 1.4 s (a = w_vel / a_prd)
%   Phase 2: Constant velocity (w_vel = 2.5 m/s)

clc; close all; clear;

%% Parameters
dt    = 0.00001;   % time step [s]
w_vel = 2.5;       % final gate velocity [m/s]
a_prd = 1.4;       % acceleration period [s]
t_time = (0:dt:15)';  % total simulation time [s]

% Case index and corresponding delay time [s]
case_list  = [1,    3,    5,    7   ];
delay_list = [0.0,  1.0,  2.0,  3.0 ];
case_names = {'C00', 'C10', 'C20', 'C30'};

%% Generate gate displacement for each case
for ic = 1:length(case_list)

    delay_time = delay_list(ic);
    wall_dst = zeros(size(t_time));
    num = 0;

    for it = 1:length(t_time)
        t = round(t_time(it), 16);

        if t <= delay_time
            % Before gate release: no displacement
            wall_dst(it) = 0;

        elseif t > delay_time && t <= delay_time + a_prd
            % Acceleration phase: s = 0.5 * a * t^2
            num = num + 1;
            wall_dst(it) = w_vel / (a_prd * 2) * dt^2 * num^2;

        else
            % Constant velocity phase: s = s_prev + v * dt
            wall_dst(it) = wall_dst(it-1) + w_vel * dt;
        end
    end

    %% Write output in OpenFOAM tabulated6DoFMotion format
    dat_name = sprintf('%s_wdisp.dat', case_names{ic});
    fileID = fopen(dat_name, 'w');
    fprintf(fileID, '%d\n', length(t_time));
    fprintf(fileID, '(\n');
    for it = 1:length(t_time)
        fprintf(fileID, '(\t%.5f\t((\t%d \t%d\t%.14f\t)\t(\t%d\t%d\t%d\t)))\n', ...
                t_time(it), 0, 0, wall_dst(it), 0, 0, 0);
    end
    fprintf(fileID, ')\n');
    fclose(fileID);

    fprintf('Generated: %s\n', dat_name);
    clear wall_dst num
end
