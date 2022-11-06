clc
clear all
% close all
%%
jackal_ip = '192.168.131.1';
pc_ip = '192.168.131.204';
%%
initialize_ros(jackal_ip,pc_ip);
%%

turnspeed = 0.4;   % Angular velocity (rad/s)
robotspeed = 1;    % Linear velocity (m/s)
distanceThreshold = 0.4;  % Distance threshold (m) for turning

ros_topic0 = '/cmd_vel';

robot = rospublisher(ros_topic0);
velmsg = rosmessage(robot);

for i=0:2
    velmsg.Angular.Z = 0;
    velmsg.Linear.X = robotspeed;
    send(robot,velmsg);
    pause(0.5)
end

for i=0:2
    velmsg.Angular.Z = 0;
    velmsg.Linear.X = -robotspeed;
    send(robot,velmsg);
    pause(0.5)
end


turn_off_ros