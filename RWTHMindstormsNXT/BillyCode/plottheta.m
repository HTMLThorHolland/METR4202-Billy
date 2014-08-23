

array = []
array2 = []
array3 = []
for ztest = -300:-100

q1 = delta_calcInverse(0, 0, ztest);
array = [array;real(q1)];
array2 = [array2;ztest];
array3 = [array3;imag(q1)];

end

figure
plot(array2, array );
hold on
plot(array2,array3,'r');