function valid = runMotor(degrees)
    
    degx = degrees(1,1);
    degy = degrees(1,2);
    degz = degrees(1,3);


    % Undo negatives and assign them to speeds
    if(degx < 0)
        speed1 = -40;
    else
        speed1 = 40;
    end
    if(degy < 0)
        speed2 = -40;
    else 
        speed2 = 40;
    end
    if(degz < 0)
        speed3 = -40;
    else
        speed3 = 40;
    end
    
    % Round the numbers to only input integers to NXC_MotorControl as
    % required
    degx = int64(degx);
    degy = int64(degy);
    degz = int64(degz);
    
    % Run all three motors to each degree
    NXC_MotorControl(0,speed1,degx, false,'Brake',true);
    NXC_MotorControl(1,speed2,degy, false,'Brake',true);
    NXC_MotorControl(2,speed3,degz, false,'Brake',true);

    valid  = 1;

end

