clc
% clear all
% close all

%%
% load('offlineSlamData.mat');
% load test1_scan.mat;
% scans = lidarScans2d(1,1:16);

% load test_scanlab1.mat;
for i = 1:122
aa{1,i} = lidarScan(scan_cell{1,i});
end
scans_all = aa;
nScansPerSubmap = 1; %3;
submaps = scans_all(1,1:nScansPerSubmap:length(scans_all));
scans = submaps;

%%
maxLidarRange = 5; %20;
mapResolution = 10; %20;
slamAlg = lidarSLAM(mapResolution, maxLidarRange);

slamAlg.LoopClosureThreshold = 210;  
slamAlg.LoopClosureSearchRadius = 8;

%%
for i=1:10
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, scans{i});
    if isScanAccepted
        fprintf('Added scan %d \n', i);
    end
end

%%
figure;
show(slamAlg);
title({'Map of the Environment','Pose Graph for Initial 10 Scans'});

%%

firstTimeLCDetected = false;

figure;
for i=10:length(scans)
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamAlg, scans{i});
    if ~isScanAccepted
        continue;
    end
    % visualize the first detected loop closure, if you want to see the
    % complete map building process, remove the if condition below
    if optimizationInfo.IsPerformed && ~firstTimeLCDetected
        show(slamAlg, 'Poses', 'off');
        hold on;
        show(slamAlg.PoseGraph); 
        hold off;
        firstTimeLCDetected = true;
        drawnow
    end
end
title('First loop closure');

%%
figure
show(slamAlg);
title({'Final Built Map of the Environment', 'Trajectory of the Robot'});


%%
[scans, optimizedPoses]  = scansAndPoses(slamAlg);
map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

%%
figure; 
show(map);
hold on
show(slamAlg.PoseGraph, 'IDs', 'off');
hold off
title('Occupancy Grid Map Built Using Lidar SLAM');

%%

