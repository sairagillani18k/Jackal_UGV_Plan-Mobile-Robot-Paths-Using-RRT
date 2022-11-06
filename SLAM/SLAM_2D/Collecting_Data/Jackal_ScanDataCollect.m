clc
clear all
close all


scan_cell = {};
count = 1;

jackal_ip = '192.168.131.1';
pc_ip = '192.168.131.204';
initialize_ros(jackal_ip,pc_ip);

laser = rossubscriber('/scan');

tic;
while toc < 600
    % Collect information from laser scan
    scan = receive(laser,1);
    plot(scan);
    scan_cell{1,count} = scan;
    pause(1);
    count = count + 1;
end

turn_off_ros