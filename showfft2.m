clear
t=0:pi/50:30*pi;
x = sin(t); y= cos(t);
x1= sin(2*t);y1= 2*sin(0.5*t);
subplot(2,2,1),plot3(x,y,t);grid on
subplot(2,2,2),plot3(x,y1,t);grid on
subplot(2,2,3),plot3(x1,y,t);grid on
subplot(2,2,4),plot3(x1,y1,t);grid on