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
    
        % Run all three motors to each degree
        NXC_MotorControl(0,speed1,degx, false,'Brake',true);
        NXC_MotorControl(1,speed2,degy, false,'Brake',true);
        NXC_MotorControl(2,speed3,degz, false,'Brake',true);

        valid  = 1;
        
        
        kp = 1;
        ki = 0.01;
        currentPos = [0 0 0];
        error0sum = 0;
        error1sum = 0;
        error2sum = 0;
        while 1
            lastPos = currentPos;
            [a b c] = getRTC(h);
            currentPos = [a b c]
            error0 = degx - currentPos(1,1);
            error1 = degy - currentPos(1,2);
            error2 = degz - currentPos(1,3);
            error0sum = error0sum + error0;
            error1sum = error1sum + error1;
            error2sum = error2sum + error2;
            
            angle0 = kp*error0 + ki*error0sum;
            angle1 = kp*error1 + ki*error1sum;
            angle2 = kp*error2 + ki*error2sum;
            
            if (isequal(lastPos,currentPos)&&(currentPos(1,1)==degx)&&(currentPos(1,2)==degy)&&(currentPos(1,3)==degz))
                break
            end
            
            if angle0 < 0
                NXC_MotorControl(0,-abs(speed1),abs(angle0), false,'Brake',true);
            else
                NXC_MotorControl(0,abs(speed1),angle0, false,'Brake',true);
            end
            if angle1 < 0
                NXC_MotorControl(1,-abs(speed2),abs(angle1), false,'Brake',true);
            else
                NXC_MotorControl(1,abs(speed2),angle1, false,'Brake',true);
            end
            if angle2 < 0
                NXC_MotorControl(2,-abs(speed2),abs(angle2), false,'Brake',true);
            else
                NXC_MotorControl(2,abs(speed2),angle2, false,'Brake',true);
            end
            %NXC_MotorControl(0,speed1,error0, false,'Brake',true);
            %NXC_MotorControl(1,speed2,error1, false,'Brake',true);
            %NXC_MotorControl(2,speed3,error2, false,'Brake',true);
            
        end
    else
        return
    end
end

