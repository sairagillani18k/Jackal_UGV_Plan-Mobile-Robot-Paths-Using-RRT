function initialize_ros(jackal_ip,pc_ip)
rosshutdown
rosinit(jackal_ip, 'NodeHost', pc_ip)
end