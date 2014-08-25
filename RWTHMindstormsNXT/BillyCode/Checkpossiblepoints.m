rf = 184;%142.5;
re = 232.5; %154.4
h = 336;

possiblepoints
l1 = size(possiblepoints2);
l2 = l1(1);
for i=1:l2
    a = possiblepoints2(j,:);
    x0 = a(1);
    y0 = a(2);
    z0 = a(3);
    [theta1, theta2, theta3] = delta_calcInverse_design(x0, y0, z0, rf, re, h)
end