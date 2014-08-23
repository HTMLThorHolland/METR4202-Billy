function [intendedpos] = runNXT (points)
    % Beginning point is to get a reference from the starting point as all
    % encoders default to 0 when the NXT is turned on
    beginz = -320;
    % Reorder points via calculation of shortest path at each step. This is
    % essentially djikstra's algorithm in this case because we have every
    % point fully connected to every other point (there is no limit to
    % where we can move from one to another). Because of this, Prim's
    % algorithm also has no computational benefit over djikstra's
    newpoints = primsAlg(points);
    disp(newpoints);
    
    % Connect to NXT and grab the handle
    h =  COM_OpenNXT();
    COM_SetDefaultNXT(h);
    
    % Reset the rotationCounter on the motors
    %NXT_ResetMotorPosition(0, false, h);
    %NXT_ResetMotorPosition(1, false, h);
    %NXT_ResetMotorPosition(2, false, h);


    [m,n] = size(newpoints);
    % Assuming inputs are 1-row arrays of subsequent x,y and z co-ords
    j = 1;
    while j<=m
        % Extract each points co-ordinates from the input
        x = newpoints(j,1);
        y = newpoints(j,2);
        z = newpoints(j,3);
        
        % Run the inverse kinematics for the position of each motor (in
        % degrees)
        %degx = inverseKin(x,y,z+beginz,0);
        %degy = inverseKin(x,y,z+beginz,120);
        %degz = inverseKin(x,y,z+beginz,-120);
        [ang1 ang2 ang3] = delta_calcInverse(x,y,z+beginz);
        %intendedpos = [ang1 ang2 ang3];
        %disp(intendedpos);
        intendedpos = [(ang1-60.2668)*5 (ang2-60.2668)*5 (ang3-60.2668)*5]; % *5 to account for gearing down
       
        
        % Pass handle to get the current rotation counters of each motor in
        % a 1x3 array
        w1 = NXT_GetOutputState(0,h);
        w2 = NXT_GetOutputState(1,h);
        w3 = NXT_GetOutputState(2,h);
        r1 = w1.RotationCount;
        r2 = w2.RotationCount;
        r3 = w3.RotationCount;
        
        currentpos = [r1 r2 r3];
        %[currentpos(1), currentpos(2), currentpos(3)] = getRTC(h);
        disp(currentpos);
      
        
        % Minus currentpos from intended pos to get the relative movement
        % required
        moveangles = intendedpos - currentpos;
                
        % Run the movement
        runMotor(-moveangles,h);
        
        
        
        w1 = NXT_GetOutputState(0,h);
        w2 = NXT_GetOutputState(1,h);
        w3 = NXT_GetOutputState(2,h);
        r1 = w1.RotationCount;
        r2 = w2.RotationCount;
        r3 = w3.RotationCount;

        disp([r1, r2, r3]);
        
        j= j+1;
    end
    
    
end