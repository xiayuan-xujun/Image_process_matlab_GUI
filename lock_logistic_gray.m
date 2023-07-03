%图像像素的改变，利用的是Logistic产生相应的混沌序列，然后和原图像进行与操作
%还有一种就是可以利用这个改变位置
function v=lock_logistic_gray(picture,x0,u)
%picture为灰度图像
%x0,u都是初始值

[M,N]=size(picture);
x=x0;
%迭代100次，达到充分混沌状态
for i=1:100
    x=u*x*(1-x);    %Logistic混沌改变
end
%产生一维混沌加密序列
A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
    A(i+1)=u*A(i)*(1-A(i));%混沌改变
end
%归一化序列
B=uint8(255*A); %将随机数组中数据变成0，或者1

%转化为二维混沌加密序列
Fuck=reshape(B,M,N);
Rod=bitxor(picture,Fuck);%异或操作加密
v=Rod;
t = bitxor(v,Fuck);
figure;
imshow([picture,v,t]);
%完
