function varargout = menu_utama(varargin)
% MENU_UTAMA MATLAB code for menu_utama.fig
%      MENU_UTAMA, by itself, creates a new MENU_UTAMA or raises the existing
%      singleton*.
%
%      H = MENU_UTAMA returns the handle to a new MENU_UTAMA or the handle to
%      the existing singleton*.
%
%      MENU_UTAMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU_UTAMA.M with the given input arguments.
%
%      MENU_UTAMA('Property','Value',...) creates a new MENU_UTAMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before menu_utama_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to menu_utama_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menu_utama

% Last Modified by GUIDE v2.5 22-Nov-2019 18:52:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menu_utama_OpeningFcn, ...
                   'gui_OutputFcn',  @menu_utama_OutputFcn, ...
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


% --- Executes just before menu_utama is made visible.
function menu_utama_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to menu_utama (see VARARGIN)

% Choose default command line output for menu_utama
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes menu_utama wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menu_utama_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
null = 0;
setappdata(0,'nilai',null);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data,path]=uigetfile('C:\Users\MY ROG\Documents\Matlab\test\*.*', 'Pilih gambar');
%Set the value of the text field edit1 to the route of the selected image.
global foto;
fullfilename = fullfile(path,data);
foto = imread(fullfilename);
axes(handles.axes2);
imshow(foto);
setappdata(0,'nilai',foto);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kosong = getappdata(0,'nilai');
if kosong == 0
    uiwait(msgbox('Pilih Gambar Terlebih Dahulu', 'Warning', 'warn'));
else
    pelabelan;
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kosong = getappdata(0,'nilai');
if kosong == 0
    uiwait(msgbox('Pilih Gambar Terlebih Dahulu', 'Warning', 'warn'));
else
    pengujian;
end
