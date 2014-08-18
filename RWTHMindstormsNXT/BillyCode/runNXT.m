function [intendedpos] = runNXT (points)
    
    % Reorder points via calculation of Prim's algorithm on optimal path
    % before sending to primfunc - pad points with set level height
    % function newpoints  = primsAlg(points)


    % Connect to NXT and grab the handle
    h =  COM_OpenNXT();
    COM_SetDefaultNXT(h);


    [m,n] = size(X);
    % Assuming inputs are 1-row arrays of subsequent x,y and z co-ords
    j = 0;
    while j<=n
        % Extract each points co-ordinates from the input
        x = points(1,j);
        y = points(1,j+1);
        z = points(1,j+2);
        
        % Run the inverse kinematics for the position of each motor (in
        % degrees)
        degx = inverseKin(x,y,z,0);
        degy = inverseKin(x,y,z,120);
        degz = inverseKin(x,y,z,-120);
        intendedpos = [degx*5 degy*5 degz*5]; % *5 to account for gearing down
        
        % Pass handle to get the current rotation counters of each motor in
        % a 1x3 array
        currentpos = getRTC(h);
        
        % Minus currentpos from intended pos to get the relative movement
        % required
        moveangles = intendedpos - currentpos;
        
        % Run the movement
        runMotor(moveangles);
        
        j= j+3;
    end
    
    
end