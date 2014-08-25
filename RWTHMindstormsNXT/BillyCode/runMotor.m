function valid = runMotor(degrees, h)
    
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
    
    
    % Break if there are any imaginary components (and therefore is not a
    % valid move to position to
    if (~isreal(degx))||(~isreal(degy))||(~isreal(degz))
        error('One of the moves is not valid');
    end
    
    
    disp(degx/5);
    disp(degy/5);
    disp(degz/5);
        
    % Round the numbers to only input integers to NXC_MotorControl as
    % required
    degx = uint64(abs(degx));
    degy = uint64(abs(degy));
    degz = uint64(abs(degz));
    
    
    
    str = input('Do you want to run with these angles?','s');
    
    if strcmp(str,'yes')
    
        mA = NXTMotor('A','Power',speed1,'TachoLimit',degx,'ActionAtTachoLimit','HoldBrake');
        mB = NXTMotor('B','Power',speed2,'TachoLimit',degy,'ActionAtTachoLimit','HoldBrake');
        mC = NXTMotor('C','Power',speed3,'TachoLimit',degz,'ActionAtTachoLimit','HoldBrake');
        mA.SendToNXT();
        mB.SendToNXT();
        mC.SendToNXT();
        
        
        % Run all three motors to each degree
        %NXC_MotorControl(0,speed1,degx, false,'Brake',true);
        %NXC_MotorControl(1,speed2,degy, false,'Brake',true);
        %NXC_MotorControl(2,speed3,degz, false,'Brake',true);
        
        
        
    else
        return
    end
end

