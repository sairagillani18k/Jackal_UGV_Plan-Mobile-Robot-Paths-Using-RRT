 clc
 clear all
%  close all
scan_cell = {};
%%
jackal_ip = '192.168.131.1';
%pc_ip = '169.254.216.191';
pc_ip = '192.168.131.235';
initialize_ros(jackal_ip,pc_ip);
% setenv('ROS_MASTER_URI','http://192.168.131.1:11311/')
%%
turnspeed = 0;   % Angular velocity (rad/s)
robotspeed = 0.1;    % Linear velocity (m/s)
distanceThreshold = 0.4;  % Distance threshold (m) for turning
ros_topic0 = '/cmd_vel';
ros_topic1 = '/zed_node/point_cloud/cloud_registered';
robot = rospublisher(ros_topic0);
% zed_camera = rossubscriber(ros_topic1);
laser_data = rossubscriber('/velodyne_points');
velmsg = rosmessage(robot);
%  cammsg = rosmessage(zed_camera);  
 lidarmsg= rosmessage(laser_data)
% pause(1)
% msg2 = receive(zed_camera,1)
%   scatter3(msg2)
 %pcshow(cammsg)
 %rosPlot(msg2)
 for j=0:27
   
     
for i=0:3
%     velmsg.Angular.Z = turnspeed;
%     velmsg.Linear.X = robotspeed;
    send(robot,velmsg);
    msg3 = receive(laser_data,1)
        scan_cell{1,j} =readXYZ( msg3);
%     scatter3(msg3)
    pause(0.6)
end
for i=0:2
    %velmsg.Angular.Z = turnspeed;
    %velmsg.Linear.X = -robotspeed;
    %send(robot,velmsg);
    pause(0.5)
end
 end
 save(['cell_test.mat'],'cell_test');
turn_off_ros