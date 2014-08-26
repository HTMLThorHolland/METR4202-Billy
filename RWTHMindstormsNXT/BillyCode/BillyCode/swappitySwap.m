function [x,y,z,speed1,speed2,speed3] = swappitySwap(degrees)
    
    degx = degrees(1,1);
    degy = degrees(1,2);
    degz = degrees(1,3);
    
    if(degx < 0)
        speed1 = -60;
        %degx = -int16(degx);
    else
        speed1 = 80;
    end
    if(degy < 0)
        speed2 = -60;
        %degy = -int16(degy);
    else 
        speed2 = 80;
    end
    if(degz < 0)
        speed3 = -60;
        %degz = -int16(degz);
    else
        speed3 = 80;
    end
    
    x = uint16(abs(degx));
    y = uint16(abs(degy));
    z = uint16(abs(degz));
end
