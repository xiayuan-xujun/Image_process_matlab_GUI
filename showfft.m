t=0:1/256:1;%采样步长
y= 2+3*cos(2*pi*50*t-pi*30/180)+1.5*cos(2*pi*75*t+pi*90/180);
N=length(t); %样点个数
plot(t,y);
fs=256;%采样频率
df=fs/(N-1) ;%分辨率
f=(0:N-1)*df;%其中每点的频率
Y=fft(y)/N*2;%真实的幅值
%Y=fftshift(Y);
figure(2)
plot(f,abs(Y));

