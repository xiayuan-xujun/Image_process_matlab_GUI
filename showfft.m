t=0:1/256:1;%��������
y= 2+3*cos(2*pi*50*t-pi*30/180)+1.5*cos(2*pi*75*t+pi*90/180);
N=length(t); %�������
plot(t,y);
fs=256;%����Ƶ��
df=fs/(N-1) ;%�ֱ���
f=(0:N-1)*df;%����ÿ���Ƶ��
Y=fft(y)/N*2;%��ʵ�ķ�ֵ
%Y=fftshift(Y);
figure(2)
plot(f,abs(Y));

