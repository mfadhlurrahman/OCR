function varargout = pelatihan(varargin)
% PELATIHAN MATLAB code for pelatihan.fig
%      PELATIHAN, by itself, creates a new PELATIHAN or raises the existing
%      singleton*.
%
%      H = PELATIHAN returns the handle to a new PELATIHAN or the handle to
%      the existing singleton*.
%
%      PELATIHAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PELATIHAN.M with the given input arguments.
%
%      PELATIHAN('Property','Value',...) creates a new PELATIHAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pelatihan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pelatihan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pelatihan

% Last Modified by GUIDE v2.5 22-Nov-2019 22:02:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pelatihan_OpeningFcn, ...
                   'gui_OutputFcn',  @pelatihan_OutputFcn, ...
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


% --- Executes just before pelatihan is made visible.
function pelatihan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pelatihan (see VARARGIN)

% Choose default command line output for pelatihan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pelatihan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pelatihan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

I = getappdata(0,'nilai'); 
resize = imresize(I,[700,900],'bilinear');
blur = imgaussfilt(resize,2);
for i = 1 : 700
    for j = 1 : 900
    gambarabu(i,j) = max(blur(i,j,:));
    end
end
abu = rgb2gray(resize);
[bw,hys]=hysteresis3d(abu,0.4,0.6,8)
hitamputih = ~bw;
gambarbersih = double(hitamputih);
%%segmentasi baris
kolomgb4 = 1;
ketemuhitam = 0;
jumlahbaris = 1;
jumlahkarakter = 1;
[barisgb,kolomgb] = size(gambarbersih);
kolomgb2 = 0.71 * kolomgb;
jumlahhitam = 0;
temp = 1;
arraybaris = cell(1,1);
arraykarakter = cell(1,1);
for i = 1 : barisgb
    for j = 1 : kolomgb
        if gambarbersih(i,j) == 1 && j <= (kolomgb/2)
            ketemuhitam = 1;
            jumlahhitam = jumlahhitam + 1;            
        end
    end
    if jumlahhitam > 0
        if jumlahbaris > 2
            kolomgb = kolomgb2;
            kolomgb4 = 200;
       end
       if jumlahbaris > 3
            kolomgb = kolomgb2;
            kolomgb4 = 230;
       end
        for y = kolomgb4 : kolomgb
            arraybaris{jumlahbaris,1}(temp,y) = gambarbersih(i,y);
        end
        temp = temp+1;
    end
    if (jumlahhitam == 0) && (ketemuhitam == 1)
        temp = 1;
        jumlahbaris = jumlahbaris+1;
        ketemuhitam = 0;
    end
    jumlahhitam = 0;
end
[barisab,kolomab] = size(arraybaris);
%%hapus noise
for i = 1 : barisab
        kosong = isempty(arraybaris{i,1});
         if kosong == 1
             continue;
         end
         hai = double(cell2mat(arraybaris(i,1)));
         hai2 = sum(hai(:));
         if hai2 < 20
            arraybaris{i,1} = [];
         end
end
%%hapus array
arraybaris = arraybaris(~cellfun('isempty',arraybaris));
[barisab,kolomab] = size(arraybaris);
[barisgbnew,kolomgbnew] = size(arraybaris{6,1});

for i = barisab+1 : -1 : 8
    arraybaris{i,1} = arraybaris{i-1,1};
end

for i = 1 : barisgbnew
    for z = round(kolomgbnew*0.6) : kolomgbnew
    arraybaris{7,1}(i,z-round(kolomgbnew*0.6)+1) = arraybaris{6,1}(i,z);
    end
    for z = round(kolomgbnew*0.4) : kolomgbnew
    arraybaris{7,1}(i,z) = 0;
    end
end

for i = 1 : barisgbnew
    for z = round(kolomgbnew*0.6) : kolomgbnew
        arraybaris{6,1}(i,z) = 0;
    end
end

barisab = barisab + 1;
%%segmentasi karakter
ketemuhitam = 0;
jumlahhitam = 0;
temp = 1;
for jumlahbaris = 1 : barisab
    [barisgh,kolomgh] = size(arraybaris{jumlahbaris,1});
    jumlahkarakter = 1;
    for i = 1 : kolomgh
        for j = 1 : barisgh
            if arraybaris{jumlahbaris,1}(j,i) == 1
                ketemuhitam = 1;
                jumlahhitam = jumlahhitam + 1;            
            end
        end
        if jumlahhitam > 0
            for z = 1 : barisgh
                arraykarakter1{jumlahbaris,jumlahkarakter}(z,temp) = arraybaris{jumlahbaris,1}(z,i);
            end
            temp = temp+1;
        end
        if (jumlahhitam == 0) && (ketemuhitam == 1)
            temp = 1;
            jumlahkarakter = jumlahkarakter+1;
            ketemuhitam = 0;
        end
        jumlahhitam = 0;
    end
end
ketemuhitam = 0;
jumlahhitam = 0;
temp = 1;
[barisak1,kolomak1] = size(arraykarakter1);
for i = 1 : barisak1
    for j = 1 : kolomak1
        kosong = isempty(arraykarakter1{i,j});
         if kosong == 1
             continue;
         end
         [barisak2 kolomak2] = size(arraykarakter1{i,j});
         temp = 1;
         for k = 1 : barisak2
             for l = 1 : kolomak2
                 if arraykarakter1{i,j}(k,l) == 1
                    ketemuhitam = 1;
                    jumlahhitam = jumlahhitam + 1;            
                end
             end
             if jumlahhitam > 0
                for z = 1 : kolomak2
                    arraykarakter{i,j}(temp,z) = arraykarakter1{i,j}(k,z);
                end
                temp = temp+1;
                ketemuhitam = 0;
                jumlahhitam = 0;
             end
         end
    end
end

%%hapus noise
for i = 1 : barisak1
    for j = 1 : kolomak1
        kosong = isempty(arraykarakter{i,j});
         if kosong == 1
             continue;
         end
         hai = double(cell2mat(arraykarakter(i,j)));
         hai2 = sum(hai(:));
         if hai2 < 20
            arraykarakter{i,j} = [];
         end
    end
end
[barisak kolomak] = size(arraykarakter);

help = find(~cellfun(@isempty,arraykarakter(7,:)))
help(help==max(help)) = []
[helpsize,helpsize1] = size(help);

for i = 1 : helpsize1
    arraykarakter{7,help(i)} = [];
end


for x = 1 : barisak
    for y = 1 : kolomak
        %inisialisasi boolean, array yang dicek kosong atau tidak
        kosong = isempty(arraykarakter{x,y});
        %kalau arraynya kosong maka resize tidak akan dilakukan dan lanjut
        if kosong == 1
            continue;
        end
        %resize karakter
        arraykarakter{x,y} = logical(imresize(arraykarakter{x,y},[128 128], 'bilinear'));
    end
end
[barisak2 kolomak2] = size(arraykarakter);
for x = 1 : barisak2
    for y = 1 : kolomak2
        %inisialisasi boolean, array yang dicek kosong atau tidak
        kosong = isempty(arraykarakter{x,y});
        %kalau arraynya kosong maka resize tidak akan dilakukan dan lanjut
        if kosong == 1
            continue;
        end
        %resize karakter
        arraykarakter{x,y} = double(arraykarakter{x,y});
    end
end
angka = 0;
setappdata(0,'gambarresize',resize);
setappdata(0,'gambarabu',abu);
setappdata(0,'gambarbw',bw);
setappdata(0,'arraybaris',arraybaris);
setappdata(0,'gambarkarakter',arraykarakter);
axes(handles.axes1);
imshow(resize);
axes(handles.axes2);
imshow(abu);
axes(handles.axes3);
imshow(bw);
axes(handles.axes4);
imshow(arraybaris{1,1});
axes(handles.axes5);
imshow(arraykarakter{1,1});
axes(handles.axes6);
imshow(arraykarakter{1,1});

matlabroot = 'C:\Users\MY ROG\Documents\MATLAB';
Datasetpath = fullfile(matlabroot,'test','dataset');
Data = imageDatastore(Datasetpath,'IncludeSubfolders',true,'LabelSource','foldernames');

layers=[imageInputLayer([128 128 1])
    convolution2dLayer(3,2)
    reluLayer
    maxPooling2dLayer(2,'stride',2)
    convolution2dLayer(3,4)
    reluLayer
    maxPooling2dLayer(2,'stride',2)
    convolution2dLayer(3,6)
    reluLayer
    maxPooling2dLayer(2,'stride',2)
    fullyConnectedLayer(36)
    softmaxLayer
    classificationLayer();]

%options=trainingOptions('sgdm','MaxEpooch',3,);
options = trainingOptions('sgdm', ...
    'MaxEpochs',10, ...
    'ValidationData',Data, ...
    'initialLearnRate',0.005, ...
    'Plots','training-progress')
convnet = trainNetwork(Data,layers,options);

fid = fopen('test.txt','wt');
for a = 1 : barisak2
     for b = 1 : kolomak2
        kosong = isempty(arraykarakter{a,b});
        %kalau arraynya kosong maka resize tidak akan dilakukan dan lanjut
        if kosong == 1
            continue;
       end
       output1 = classify(convnet,arraykarakter{a,b});
       hasil_ocr{a,b} = char(output1);
       fprintf(fid, '%s', string(output1));
     end
    fprintf(fid, '\n');
end

[barischar kolomchar] = size(hasil_ocr);
for d = 1 : barisak2
   temp1 = char.empty;
   for e = 1 : kolomak2
       kosong = isempty(hasil_ocr{d,e});
       if kosong == 1
            continue;
       end
       temp1 = strcat(temp1,hasil_ocr{d,e});
   end
   data_ocr{d,1} = temp1;
end
setappdata(0,'dataocr',data_ocr);
fclose(fid);
msgbox('Proses Pengujian Telah Selesai','Success','help');





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ekstraksi;
