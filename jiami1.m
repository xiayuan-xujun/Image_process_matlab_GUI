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

%���ļ� ��matlab��֧��ͼ����޷������͵ļ���
% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.tif';'*.png'},'select picture');  %ѡ��ͼƬ·��
if isequal(filename,0) || isequal(pathname,0)
    errordlg(' û��ѡ���ļ�������');
    return;
else
    file=[pathname filename];  %�ϳ�·��+�ļ���
    global SOURCE   %����һ��ȫ�ֱ���img
    global CHANGE;
    SOURCE = file; %�����ʼͼ��·��
    CHANGE=imread(file);   %��ȡͼƬ
    axes(handles.axes1);  %ʹ�õ�һ��axes,��ʾͼƬ  
    imshow(CHANGE);  %��ʾͼƬ
    handles.img=CHANGE; %��ʵ���Ҳ�ǲ�����ģ�
end

% �����ļ�
% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex]=...
    uiputfile({'*.tiff';'*.bmp';'*.jpg';'*.tif';'*.png'},'save picture');%�洢ͼƬ·��
if filterindex==0
    errordlg(' û�б����ļ���');
    return  %���ȡ������������.
else
    file = getframe(handles.axes2);
    %file=[pathname filename];  %�ϳ�·��+�ļ���
    imwrite(file.cdata,[pathname,filename]);  %д��ͼƬ��Ϣ��������ͼƬ
end

%�˳�
% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
close all;
clear;

%��ԭ��Ҳ���ǳ�����
% --------------------------------------------------------------------
function restore_Callback(hObject, eventdata, handles)
% hObject    handle to restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
global SOURCE;
CHANGE = imread(SOURCE);
axes(handles.axes1);  %ʹ�õ�һ��axes
imshow(CHANGE);  %��ʾͼƬ
handles.img=CHANGE; %��ʵ���Ҳ�ǲ�����ģ��о�����Ժ�����õ��������ҾͲ�˵��

%ͼ����ת
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

%�Ҷ�ͼ
% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
axes(handles.axes1);
CHANGE = im2double(rgb2gray(CHANGE));
imshow(CHANGE);
handles.img=CHANGE;      %�������յĻҶ�ͼ��

%ԭͼ��ֱ��ͼ
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
%�任��Ҷ�ֱ��ͼ
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

%ͼ��ķָ�
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
[width,height] = size(CHANGE); %��ȡͼ��ĳ���
img1=CHANGE(1:0.4*height,1:0.4*width,:);
img2=CHANGE(1:0.4*height,0.4*width:end,:);
img3=CHANGE(0.4*height:end,1:0.4*width,:);
img4=CHANGE(0.4*height:end,0.4*width:end,:);
figure;
subplot(2,2,1),imshow(img1);
subplot(2,2,2),imshow(img2);
subplot(2,2,3),imshow(img3);
subplot(2,2,4),imshow(img4);


%ͼ��ĺϲ�
% --- Executes on button press in merge.
function merge_Callback(hObject, eventdata, handles)
% hObject    handle to merge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
CHANGE = [img1 img2;img3 img4];
axes(handles.axes2);
imshow(CHANGE);

%è���任
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
for i=1:c  %Ϊʲô����һֱ�����أ��ı�һ��д���ͺ��ˣ�why��
    for y=1:h
        for x=1:w 
            %Arnold�任��ԭ��������x�᷽��Ĵ��б任��
            %����y�᷽��Ĵ��б任������ģ�����൱���и�������
            xx=mod((x-1)+b*(y-1),N)+1;
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            imgn(yy,xx)=CHANGE(y,x);                
        end
    end
    CHANGE=imgn;
end
axes(handles.axes2); %��ʾ��axes2��
imshow(CHANGE,[]);


%����Ҷ�任
% --- Executes on button press in fft2change.
function fft2change_Callback(hObject, eventdata, handles)
% hObject    handle to fft2change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
CHANGE = fft2(CHANGE);
%���F������ʾ�ĸ��Ӻÿ���
F = CHANGE; 
F = fftshift(F);
F = log(1+abs(F));
axes(handles.axes2);
imshow(F,[]);

%--------------------------------------------------------
%����ͼ��
%--------------------------------------------------------
%����Ҷ��任
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


%Arnold�任��è���任)
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


%ͼ�������
%���������λ���صĻ���Ҫָ���ض���λ�á����ֻ����ȡһλ�Ļ�����Ⱥܸߣ�
%���ǻ᲻����ڸ������أ�2��������֮ǰ�����˼�룬���ǲ��ǽ�����һ��ͼ�Խ�ȥ��
%��λ��
%   I = bitshift(I,-4);����
%   R = bitshift(R,-4);
%   R = bitshift(R,4); ������λ��Ϊ0
%   X = R + I; ��ϳ��µ�ͼ��
%
% --- Executes on button press in conceal.
function conceal_Callback(hObject, eventdata, handles)
% hObject    handle to conceal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
%ѡ�����ص�����ͼƬȥ
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.tif';'*.png'},'select picture');  %ѡ��ͼƬ·��
if isequal(filename,0) || isequal(pathname,0)
    errordlg(' û��ѡ���ļ�������');
    return;
else
    file=[pathname filename];  %�ϳ�·��+�ļ���
    CONCEAL=imread(file);   %��ȡͼƬ��Ϣ
    %������Ӧ�ı仯֮����ʹ������Ͳ��Ǻܺ��ˣ�������ǿ���
    %�Ա任��ͼ�񣬼������ǰ�λ�ģ�Ҳ����unit8���͵ģ����ǿ���
    %ÿ����ȡ��λ�������أ������᲻������أ��о����ǿ��Ե�Ŷ
    axes(handles.axes1);  %ʹ�õ�һ��axes
    
end


%ͼ�����ʾ
% --- Executes on button press in separate.
function separate_Callback(hObject, eventdata, handles)
% hObject    handle to separate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Logistic�任
% --- Executes on button press in Logistic.
function Logistic_Callback(hObject, eventdata, handles)
% hObject    handle to Logistic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%ͼ�����صĸı䣬���õ���Logistic������Ӧ�Ļ������У�Ȼ���ԭͼ����������
%����һ�־��ǿ�����������ı�λ��
%pictureΪ�Ҷ�ͼ��
%x0,u���ǳ�ʼֵ
global CHANGE;
x0 = get(handles.logisticx0,'string');
u = get(handles.logisticu,'string');
[M,N]=size(CHANGE);
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
CHANGE=Rod;
axes(handles.axes2);
imshow(CHANGE);


%Logistic��任����Logistic�任����һ���ģ��ҵ��뷨�������������
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
Rod=bitxor(CHANGE,Fuck);%����������
CHANGE=Rod;
axes(handles.axes2);
imshow(CHANGE);


%--------------------------------------------------------
%ģ��ʵ�ʻ�����������Ӧ������,�Լ�ȥ������
% --- Executes on button press in salt.
%��������
function salt_Callback(hObject, eventdata, handles)
% hObject    handle to salt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
saltnumber = str2double(get(handles.saltnumber, 'String'));
%set(handles.slider1, 'Value', saltnumber); %��̬����
CHANGE = imnoise(CHANGE,'salt & pepper',saltnumber);%���뽷������
axes(handles.axes4);
imshow(CHANGE);


% --- Executes on button press in gauss.
%��˹����
function gauss_Callback(hObject, eventdata, handles)
% hObject    handle to gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
gaussnumber = str2double(get(handles.gaussnumber, 'String'));
%set(handles.slider1, 'Value', gaussnumber); %��̬����
CHANGE = imnoise(CHANGE,'gaussian',gaussnumber);%�����˹����
axes(handles.axes4);
imshow(CHANGE,[])

%ģ��ͼƬ��

% --- Executes on button press in imgedamage.
function imgedamage_Callback(hObject, eventdata, handles)
% hObject    handle to imgedamage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
damagenumber = str2double(get(handles.damagenumber, 'String'));
damagenumber2 = str2double(get(handles.damagenumber2, 'String'));
[w,h] = size(CHANGE);
demo = zeros(w);    %��Ϊ��հ�ʹ��
damage1=CHANGE(1:damagenumber*w,1:h*damagenumber2,:);    %ʣ��ͼ��
%�ÿհ�� 
damage2 = demo(1:damagenumber*w,damagenumber2*h:end,:);
damage3 = demo(damagenumber*w:end,1:h*damagenumber2,:);
damage4 = demo(damagenumber*w:end,h*damagenumber2:end,:);
CHANGE = [damage1 damage2;damage3 damage4];%��ס˳��
axes(handles.axes2);
imshow(CHANGE,[])


%--------------------------------------------------------
%�����˲�
% --- Executes on button press in linearSmoothing.
function linearSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to linearSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
h=[1 1 1;1 1 1;1 1 1];  %ע��hΪ��ģ
I=double(CHANGE);
H = 3*3;
%k=convn(I,h)/H;
k = imfilter(I,h,'replicate')/H;
CHANGE = k;
axes(handles.axes4);
imshow(CHANGE,[]);

%����Ӧ�˲�
% --- Executes on button press in AdaptionSmoothing.
function AdaptionSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to AdaptionSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
k=wiener2(CHANGE,[3,3]); %����ϵͳ����
CHANGE=k;
axes(handles.axes4);
imshow(CHANGE,[]);

%��ͨ�˲��� ,���װ�����˹��ͨ�˲���
% --- Executes on button press in DownSmoothing.
function DownSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to DownSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
[w,h]=size(CHANGE);
nn=2;       %���װ�����˹��ͨ
d0 = str2double(get(handles.ditong, 'String'));           %��ֹƵ��50
m=fix(w/2); n=fix(h/2);
for i=1:w
       for j=1:h
           d=sqrt((i-m)^2+(j-n)^2);
           k=1/(1+0.414*(d/d0)^(2*nn));     % �����ͨ�˲������ݺ���
           CHANGE(i,j)=k*CHANGE(i,j);
       end
end
axes(handles.axes4);
imshow(CHANGE,[]);


%��ͨ�˲�
% --- Executes on button press in HightSmoothing.
function HightSmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to HightSmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CHANGE;
[w,h]=size(CHANGE);
d0=get(handles.gaotong,'string');                                  %��ֹƵ��25
m=fix(w/2); n=fix(h/2);
for i=1:w
        for j=1:h
            d=sqrt((i-m)^2+(j-n)^2);        % �����ͨ�˲������ݺ���
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
%�����һЩ��Ӧ�Ĳ������Լ�������Ҫ��ȡ����
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



%a,b,c �Լ�a1,b1,c1�ֱ��ǽ���è���任����Ҫ������ֵ��c�ǵ���ֵ
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


%��˹�����뽷��������ռ��
%��������
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

%��˹����
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
