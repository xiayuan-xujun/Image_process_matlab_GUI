 function varargout = jiami1(varargin)
% JIAMI1 MATLAB code for jiami1.fig
%      JIAMI1, by itself, creates a new JIAMI1 or raises the existing
%      singleton*.
%
%      H = JIAMI1 returns the handle to a new JIAMI1 or the handle to
%      the existing singleton*.
%
%      JIAMI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JIAMI1.M with the given input arguments.
%
%      JIAMI1('Property','Value',...) creates a new JIAMI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jiami1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jiami1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jiami1

% Last Modified by GUIDE v2.5 31-Oct-2017 16:13:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jiami1_OpeningFcn, ...
                   'gui_OutputFcn',  @jiami1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before jiami1 is made visible.
function jiami1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jiami1 (see VARARGIN)

% Choose default command line output for jiami1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jiami1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jiami1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%打开文件 。matlab不支持图像的无符号整型的计算
% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.tif';'*.png'},'select picture');  %选择图片路径
if isequal(filename,0) || isequal(pathname,0)
    errordlg(' 没有选择文件，出错');
    return;
else
    file=[pathname filename];  %合成路径+文件名
    global SOURCE   %定义一个全局变量img
    global CHANGE;
    SOURCE = file; %保存初始图像路径
    CHANGE=imread(file);   %读取图片
    axes(handles.axes1);  %使用第一个axes,显示图片  
    imshow(CHANGE);  %显示图片
    handles.img=CHANGE; %其实这个也是不必须的，
end

% 保存文件
% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex]=...
    uiputfile({'*.tiff';'*.bmp';'*.jpg';'*.tif';'*.png'},'save picture');%存储图片路径
if filterindex==0
    errordlg(' 没有保存文件。');
    return  %如果取消操作，返回.
else
    file = getframe(handles.axes2);
    %file=[pathname filename];  %合成路径+文件名
    imwrite(file.cdata,[pathname,filename]);  %写入图片信息，即保存图片
end

%退出
% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
close all;
clear;

%还原，也就是撤销啦
% --------------------------------------------------------------------
function restore_Callback(hObject, eventdata, handles)
% hObject    handle to restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
global SOURCE;
CHANGE = imread(SOURCE);
axes(handles.axes1);  %使用第一个axes
imshow(CHANGE);  %显示图片
handles.img=CHANGE; %其实这个也是不必须的，感觉这个以后可以用到，这里我就不说了

%图像旋转
% --------------------------------------------------------------------
function turn_Callback(hObject, eventdata, handles)
% hObject    handle to turn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
f=imrotate(CHANGE,90,'bilinear','crop');
CHANGE = f;
axes(handles.axes2);
imshow(CHANGE);

%灰度图
% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
axes(handles.axes1);
CHANGE = im2double(rgb2gray(CHANGE));
imshow(CHANGE);
handles.img=CHANGE;      %保存最终的灰度图像

%原图的直方图
% --- Executes on button press in SourceGray.
function SourceGray_Callback(hObject, eventdata, handles)
% hObject    handle to SourceGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SOURCE;
I = imread(SOURCE);
axes(handles.axes3);
[w,h,color] = size(I);
if(color == 3)
    x = im2double(rgb2gray(I));
    h = imhist(x);
    h1 = h(1:2:256);
    horz = 1:2:256;
    stem(horz,h1,'.');
else
    h = imhist(I);
    h1 = h(1:10:256);
    horz = 1:10:256;
    stem(horz,h1,'.');
end


% --- Executes on button press in graylist
%变换后灰度直方图
function graylist_Callback(hObject, eventdata, handles)
% hObject    handle to graylist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE
axes(handles.axes5);
[w,h,color] = size(CHANGE);
if(color == 3)
    x = CHANGE;
    x = rgb2gray(x);
    h = imhist(x);
    h1 = h(1:2:256);
    horz = 1:2:256;
    stem(horz,h1,'.');
else
    h = imhist(CHANGE);
    h1 = h(1:2:256);
    horz = 1:2:256;
    stem(horz,h1,'.');
end

%图像的分割
% --- Executes on button press in division.
function division_Callback(hObject, eventdata, handles)
% hObject    handle to division (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
global img1;
global img2;
global img3;
global img4;
[width,height] = size(CHANGE); %获取图像的长宽
img1=CHANGE(1:0.4*height,1:0.4*width,:);
img2=CHANGE(1:0.4*height,0.4*width:end,:);
img3=CHANGE(0.4*height:end,1:0.4*width,:);
img4=CHANGE(0.4*height:end,0.4*width:end,:);
figure;
subplot(2,2,1),imshow(img1);
subplot(2,2,2),imshow(img2);
subplot(2,2,3),imshow(img3);
subplot(2,2,4),imshow(img4);


%图像的合并
% --- Executes on button press in merge.
function merge_Callback(hObject, eventdata, handles)
% hObject    handle to merge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
CHANGE = [img1 img2;img3 img4];
axes(handles.axes2);
imshow(CHANGE);

%猫脸变换
% --- Executes on button press in ArnoldChange.
function ArnoldChange_Callback(hObject, eventdata, handles)
% hObject    handle to ArnoldChange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
a = get(handles.a,'string');
b = get(handles.b,'string');
c = str2double(get(handles.c, 'String'));
[h,w] = size(CHANGE);
N = h;
imgn=zeros(h,w);
for i=1:c  %为什么这里一直报错呢？改变一下写法就好了，why？
    for y=1:h
        for x=1:w 
            %Arnold变换的原理是先作x轴方向的错切变换，
            %再作y轴方向的错切变换，最后的模运算相当于切割回填操作
            xx=mod((x-1)+b*(y-1),N)+1;
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            imgn(yy,xx)=CHANGE(y,x);                
        end
    end
    CHANGE=imgn;
end
axes(handles.axes2); %显示在axes2上
imshow(CHANGE,[]);


%傅立叶变换
% --- Executes on button press in fft2change.
function fft2change_Callback(hObject, eventdata, handles)
% hObject    handle to fft2change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
CHANGE = fft2(CHANGE);
%提出F用于显示的更加好看点
F = CHANGE; 
F = fftshift(F);
F = log(1+abs(F));
axes(handles.axes2);
imshow(F,[]);

%--------------------------------------------------------
%解密图像
%--------------------------------------------------------
%傅立叶逆变换
% --- Executes on button press in niifft2.
function niifft2_Callback(hObject, eventdata, handles)
% hObject    handle to niifft2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE
CHANGE = ifft2(CHANGE);
Fc = abs(log(1+CHANGE));
axes(handles.axes2);
imshow(Fc,[]);


%Arnold变换（猫脸变换)
% --- Executes on button press in niArnold.
function niArnold_Callback(hObject, eventdata, handles)
% hObject    handle to niArnold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE
a1 = get(handles.a1,'string');
b1 = get(handles.b1,'string');
c1 = str2double(get(handles.c1, 'String'));
[h,w] = size(CHANGE);
N = h;
imgn=zeros(h,w);
for i=1:c1
    for y=1:h
        for x=1:w            
            xx=mod((a1*b1+1)*(x-1)-b1*(y-1),N)+1;
            yy=mod(-a1*(x-1)+(y-1),N)+1  ;        
            imgn(yy,xx)=CHANGE(y,x);                   
        end
    end
    CHANGE=imgn;
end
axes(handles.axes2);
imshow(CHANGE);


%图像的隐藏
%如果按照移位隐藏的话需要指定特定的位置。如果只是提取一位的话保真度很高，
%但是会不会过于复杂了呢？2、按照我之前的设计思想，我们不是将整个一幅图仍进去。
%移位：
%   I = bitshift(I,-4);右移
%   R = bitshift(R,-4);
%   R = bitshift(R,4); 将后四位置为0
%   X = R + I; 组合成新的图像
%
% --- Executes on button press in conceal.
function conceal_Callback(hObject, eventdata, handles)
% hObject    handle to conceal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
%选择隐藏到那张图片去
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.tif';'*.png'},'select picture');  %选择图片路径
if isequal(filename,0) || isequal(pathname,0)
    errordlg(' 没有选择文件，出错');
    return;
else
    file=[pathname filename];  %合成路径+文件名
    CONCEAL=imread(file);   %读取图片信息
    %经过相应的变化之后再使用这个就不是很好了，因此我们可以
    %对变换的图像，假设其是八位的，也就是unit8类型的，我们可以
    %每次提取两位进行隐藏，那样会不会更好呢？感觉还是可以的哦
    axes(handles.axes1);  %使用第一个axes
    
end


%图像的显示
% --- Executes on button press in separate.
function separate_Callback(hObject, eventdata, handles)
% hObject    handle to separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Logistic变换
% --- Executes on button press in Logistic.
function Logistic_Callback(hObject, eventdata, handles)
% hObject    handle to Logistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%图像像素的改变，利用的是Logistic产生相应的混沌序列，然后和原图像进行与操作
%还有一种就是可以利用这个改变位置
%picture为灰度图像
%x0,u都是初始值
global CHANGE;
x0 = get(handles.logisticx0,'string');
u = get(handles.logisticu,'string');
[M,N]=size(CHANGE);
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
CHANGE=Rod;
axes(handles.axes2);
imshow(CHANGE);


%Logistic逆变换它与Logistic变换就是一样的，我的想法把他们组合起来
% --- Executes on button press in InverseLogistic.
function InverseLogistic_Callback(hObject, eventdata, handles)
% hObject    handle to InverseLogistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
x0 = get(handles.nilogisticx0,'string');
u = get(handles.nilogisticu,'string');
[M,N]=size(CHANGE);
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
Rod=bitxor(CHANGE,Fuck);%异或操作加密
CHANGE=Rod;
axes(handles.axes2);
imshow(CHANGE);


%--------------------------------------------------------
%模拟实际环境，加入相应的噪声,以及去除噪声
% --- Executes on button press in salt.
%椒盐噪声
function salt_Callback(hObject, eventdata, handles)
% hObject    handle to salt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
saltnumber = str2double(get(handles.saltnumber, 'String'));
%set(handles.slider1, 'Value', saltnumber); %动态调节
CHANGE = imnoise(CHANGE,'salt & pepper',saltnumber);%加入椒盐噪声
axes(handles.axes4);
imshow(CHANGE);


% --- Executes on button press in gauss.
%高斯噪声
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
gaussnumber = str2double(get(handles.gaussnumber, 'String'));
%set(handles.slider1, 'Value', gaussnumber); %动态调节
CHANGE = imnoise(CHANGE,'gaussian',gaussnumber);%加入高斯噪声
axes(handles.axes4);
imshow(CHANGE,[])

%模拟图片损坏

% --- Executes on button press in imgedamage.
function imgedamage_Callback(hObject, eventdata, handles)
% hObject    handle to imgedamage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
damagenumber = str2double(get(handles.damagenumber, 'String'));
damagenumber2 = str2double(get(handles.damagenumber2, 'String'));
[w,h] = size(CHANGE);
demo = zeros(w);    %作为填补空白使用
damage1=CHANGE(1:damagenumber*w,1:h*damagenumber2,:);    %剩余图像
%用空白填补 
damage2 = demo(1:damagenumber*w,damagenumber2*h:end,:);
damage3 = demo(damagenumber*w:end,1:h*damagenumber2,:);
damage4 = demo(damagenumber*w:end,h*damagenumber2:end,:);
CHANGE = [damage1 damage2;damage3 damage4];%记住顺序
axes(handles.axes2);
imshow(CHANGE,[])


%--------------------------------------------------------
%线性滤波
% --- Executes on button press in linearSmoothing.
function linearSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to linearSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
h=[1 1 1;1 1 1;1 1 1];  %注意h为掩模
I=double(CHANGE);
H = 3*3;
%k=convn(I,h)/H;
k = imfilter(I,h,'replicate')/H;
CHANGE = k;
axes(handles.axes4);
imshow(CHANGE,[]);

%自适应滤波
% --- Executes on button press in AdaptionSmoothing.
function AdaptionSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to AdaptionSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
k=wiener2(CHANGE,[3,3]); %调用系统函数
CHANGE=k;
axes(handles.axes4);
imshow(CHANGE,[]);

%低通滤波器 ,二阶巴特沃斯低通滤波器
% --- Executes on button press in DownSmoothing.
function DownSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to DownSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
[w,h]=size(CHANGE);
nn=2;       %二阶巴特沃斯低通
d0 = str2double(get(handles.ditong, 'String'));           %截止频率50
m=fix(w/2); n=fix(h/2);
for i=1:w
       for j=1:h
           d=sqrt((i-m)^2+(j-n)^2);
           k=1/(1+0.414*(d/d0)^(2*nn));     % 计算低通滤波器传递函数
           CHANGE(i,j)=k*CHANGE(i,j);
       end
end
axes(handles.axes4);
imshow(CHANGE,[]);


%高通滤波
% --- Executes on button press in HightSmoothing.
function HightSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to HightSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
[w,h]=size(CHANGE);
d0=get(handles.gaotong,'string');                                  %截止频率25
m=fix(w/2); n=fix(h/2);
for i=1:w
        for j=1:h
            d=sqrt((i-m)^2+(j-n)^2);        % 计算高通滤波器传递函数
            if d<=d0
                k=0;
            else k=1;
            end
            CHANGE(i,j)=k*CHANGE(i,j);
        end
end
axes(handles.axes4);
imshow(CHANGE,[]);


%----------------------------------------------------------------
%定义的一些相应的参数，以及我们需要获取东东
function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%a,b,c 以及a1,b1,c1分别是进行猫脸变换是需要的敏感值，c是迭代值
function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double

% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double

% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of c as text
%        str2double(get(hObject,'String')) returns contents of c as a double

% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a1_Callback(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of a1 as text
%        str2double(get(hObject,'String')) returns contents of a1 as a double

% --- Executes during object creation, after setting all properties.
function a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function b1_Callback(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of b1 as text
%        str2double(get(hObject,'String')) returns contents of b1 as a double

% --- Executes during object creation, after setting all properties.
function b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function c1_Callback(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of c1 as text
%        str2double(get(hObject,'String')) returns contents of c1 as a double

% --- Executes during object creation, after setting all properties.
function c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%高斯噪声与椒盐噪声的占比
%椒盐噪声
function saltnumber_Callback(hObject, eventdata, handles)
% hObject    handle to saltnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of saltnumber as text
%        str2double(get(hObject,'String')) returns contents of saltnumber as a double

% --- Executes during object creation, after setting all properties.
function saltnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saltnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%高斯噪声
function gaussnumber_Callback(hObject, eventdata, handles)
% hObject    handle to gaussnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of gaussnumber as text
%        str2double(get(hObject,'String')) returns contents of gaussnumber as a double

% --- Executes during object creation, after setting all properties.
function gaussnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function damagenumber_Callback(hObject, eventdata, handles)
% hObject    handle to damagenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damagenumber as text
%        str2double(get(hObject,'String')) returns contents of damagenumber as a double


% --- Executes during object creation, after setting all properties.
function damagenumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damagenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function damagenumber2_Callback(hObject, eventdata, handles)
% hObject    handle to damagenumber2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damagenumber2 as text
%        str2double(get(hObject,'String')) returns contents of damagenumber2 as a double


% --- Executes during object creation, after setting all properties.
function damagenumber2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damagenumber2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ditong_Callback(hObject, eventdata, handles)
% hObject    handle to ditong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ditong as text
%        str2double(get(hObject,'String')) returns contents of ditong as a double


% --- Executes during object creation, after setting all properties.
function ditong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ditong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaotong_Callback(hObject, eventdata, handles)
% hObject    handle to gaotong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaotong as text
%        str2double(get(hObject,'String')) returns contents of gaotong as a double


% --- Executes during object creation, after setting all properties.
function gaotong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaotong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function logisticu_Callback(hObject, eventdata, handles)
% hObject    handle to logisticu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of logisticu as text
%        str2double(get(hObject,'String')) returns contents of logisticu as a double


% --- Executes during object creation, after setting all properties.
function logisticu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logisticu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function logisticx0_Callback(hObject, eventdata, handles)
% hObject    handle to logisticx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of logisticx0 as text
%        str2double(get(hObject,'String')) returns contents of logisticx0 as a double


% --- Executes during object creation, after setting all properties.
function logisticx0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logisticx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nilogisticu_Callback(hObject, eventdata, handles)
% hObject    handle to nilogisticu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nilogisticu as text
%        str2double(get(hObject,'String')) returns contents of nilogisticu as a double


% --- Executes during object creation, after setting all properties.
function nilogisticu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nilogisticu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nilogisticx0_Callback(hObject, eventdata, handles)
% hObject    handle to nilogisticx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nilogisticx0 as text
%        str2double(get(hObject,'String')) returns contents of nilogisticx0 as a double


% --- Executes during object creation, after setting all properties.
function nilogisticx0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nilogisticx0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
