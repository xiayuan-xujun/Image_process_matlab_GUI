%ͼ�����صĸı䣬���õ���Logistic������Ӧ�Ļ������У�Ȼ���ԭͼ����������
%����һ�־��ǿ�����������ı�λ��
function v=lock_logistic_gray(picture,x0,u)
%pictureΪ�Ҷ�ͼ��
%x0,u���ǳ�ʼֵ

[M,N]=size(picture);
x=x0;
%����100�Σ��ﵽ��ֻ���״̬
for i=1:100
    x=u*x*(1-x);    %Logistic����ı�
end
%����һά�����������
A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
    A(i+1)=u*A(i)*(1-A(i));%����ı�
end
%��һ������
B=uint8(255*A); %��������������ݱ��0������1

%ת��Ϊ��ά�����������
Fuck=reshape(B,M,N);
Rod=bitxor(picture,Fuck);%����������
v=Rod;
t = bitxor(v,Fuck);
figure;
imshow([picture,v,t]);
%��
