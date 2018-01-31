function varargout = dinamica(varargin)
% DINAMICA M-file for dinamica.fig
%      DINAMICA, by itself, creates a new DINAMICA or raises the existing
%      singleton*.
%
%      H = DINAMICA returns the handle to a new DINAMICA or the handle to
%      the existing singleton*.
%
%      DINAMICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DINAMICA.M with the given input arguments.
%
%      DINAMICA('Property','Value',...) creates a new DINAMICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dinamica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dinamica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIhandles

% Edit the above text to modify the response to help dinamica

% Last Modified by GUIDE v2.5 01-Dec-2008 20:28:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dinamica_OpeningFcn, ...
                   'gui_OutputFcn',  @dinamica_OutputFcn, ...
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


% --- Executes just before dinamica is made visible.
function dinamica_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dinamica (see VARARGIN)

% Choose default command line output for dinamica
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);


global reg;

reg=handles;

reg.time=timer;
reg.time.Period= 0.001;
reg.time.TimerFcn={@timer_Callback, hObject, handles};

reg.v=zeros(1,300);
reg.t=[0:0.05:15-0.05];
reg.gNavector=zeros(1,300);
reg.gKvector=zeros(1,300);
reg.n=zeros(1,300);
reg.m=zeros(1,300);
reg.h=zeros(1,300);

reg.v(length(reg.v))=0;
reg.n(length(reg.n))=0.3177;
reg.m(length(reg.m))=0.0529;
reg.h(length(reg.h))=0.5961;

reg.Iap=zeros(1,300);%vector de estimulos

reg.estim_amplitud=10;
reg.estim_duracion=2;

reg.band_estim=false;

reg.conc_sodio_extra=120;
reg.conc_sodio_intra=15;
reg.conc_potasio_extra=7;
reg.conc_potasio_intra=140;
reg.TTX=0;
reg.TEA=0;






% UIWAIT makes dinamica wait for user response (see UIRESUME)
% uiwait(handles.dinfigure);

function timer_Callback(timer_object, eventdata, hObject, handles)
global reg;

alfa_n=0.01*(10-reg.v(length(reg.v)))/(exp((10-reg.v(length(reg.v)))/10)-1);
beta_n=0.125*exp(-reg.v(length(reg.v))/80);
alfa_m=0.1*(25-reg.v(length(reg.v)))/(exp((25-reg.v(length(reg.v)))/10)-1);
beta_m=4*exp(-reg.v(length(reg.v))/18);
alfa_h=0.07*exp(-reg.v(length(reg.v))/20);
beta_h=1/(exp((30-reg.v(length(reg.v)))/10)+1);

% ggK=36;
% ggNa=120;
% ggL=0.3;
vK=65+61.55*log10(reg.conc_potasio_extra/reg.conc_potasio_intra);
vNa=65+61.55*log10(reg.conc_sodio_extra/reg.conc_sodio_intra);

vR=61.55*log10((reg.conc_potasio_extra+0.0447*reg.conc_sodio_extra)/...
    (reg.conc_potasio_intra+0.0447*reg.conc_sodio_intra));
vR=round(vR);
% vL=10.6;
% Cm=1;

%reemplazamos las variables por sus valores para hacerlo mas rapido al
%programa

delta=0.04;

gK=(-reg.TEA/1000+1)*36*(reg.n(length(reg.n)))^4;
gNa=(-reg.TTX/0.01+1)*120*(reg.m(length(reg.m))^3)*reg.h(length(reg.h));

reg.v=reg.v(2:length(reg.v));
reg.n=reg.n(2:length(reg.n));
reg.m=reg.m(2:length(reg.m));
reg.h=reg.h(2:length(reg.h));
reg.t=reg.t(2:length(reg.t));

i=length(reg.v);

if reg.band_estim==true
    reg.Iap=reg.Iap(2:length(reg.Iap));
    reg.Iap(i+1)=reg.estim_amplitud;
    reg.contador=reg.contador+1;
    if reg.contador*delta>reg.estim_duracion
        reg.band_estim=false;
        reg.Iap=zeros(1,300);
    end;
end;

reg.v(i+1)=((-gK*(reg.v(i)-vK)-gNa*(reg.v(i)-vNa)-0.3*(reg.v(i)-10.6)+reg.Iap(i+1)))*delta + reg.v(i);
reg.n(i+1)=(alfa_n*(1-reg.n(i))-beta_n*reg.n(i))*delta+reg.n(i);
reg.m(i+1)=(alfa_m*(1-reg.m(i))-beta_m*reg.m(i))*delta+reg.m(i);
reg.h(i+1)=(alfa_h*(1-reg.h(i))-beta_h*reg.h(i))*delta+reg.h(i);

reg.t(i+1)=reg.t(i)+delta;

plot(reg.axes1,reg.t,reg.v+vR,'r');

axis(handles.axes1,[reg.t(1) reg.t(length(reg.t))+5 vR-15 vR+115]);

reg.gNavector=reg.gNavector(2:length(reg.gNavector));
reg.gNavector(length(reg.gNavector)+1)=gNa;
reg.gKvector=reg.gKvector(2:length(reg.gKvector));
reg.gKvector(length(reg.gKvector)+1)=gK;

plot(reg.axes2,reg.t,reg.gNavector, reg.t,reg.gKvector);
axis(handles.axes2,[reg.t(1) reg.t(length(reg.t))+5 -10 50]);

guidata(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = dinamica_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in menu_button.
function menu_button_Callback(hObject, eventdata, handles)
h=guihandles(gcbo);
menu;
close(h.dinfigure);
% hObject    handle to menu_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=-25 && str2double(get(hObject,'string'))<=25)
    reg.estim_amplitud=str2double(get(hObject,'string'));
    set(reg.slider1,'Value',reg.estim_amplitud);
else
    errordlg('El valor debe estar comprendido entre -25 y 25', 'Valor no válido');
    set(reg.edit1, 'String', num2str(reg.estim_amplitud));
end;
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



function edit2_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=20)
    reg.estim_duracion=str2double(get(hObject,'string'));
    set(reg.slider2,'Value',reg.estim_duracion);
else
    errordlg('El valor debe estar comprendido entre 0 y 20', 'Valor no válido');
    set(reg.edit2, 'String', num2str(reg.estim_duracion));
end;
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ahora_button.
function ahora_button_Callback(hObject, eventdata, handles)
global reg;
reg.band_estim=true;
reg.contador=0;

% hObject    handle to ahora_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function dinfigure_DeleteFcn(hObject, eventdata, handles)
global reg;
delete(reg.time);
% hObject    handle to dinfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when user attempts to close dinfigure.
function dinfigure_CloseRequestFcn(hObject, eventdata, handles)
global reg;
stop(reg.time);
delete(reg.time);
% hObject    handle to dinfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
global reg;
reg.time.ExecutionMode='FixedSpacing';
start(reg.time);
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
global reg;
stop(reg.time);
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
global reg;
reg.time.ExecutionMode='SingleShot';
start(reg.time);

% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global reg;
reg.estim_amplitud = get(hObject,'Value');
    set(reg.edit1, ...
        'String', num2str(reg.estim_amplitud)); 

% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
global reg;
reg.estim_duracion = get(hObject,'Value');
    set(reg.edit2, ...
        'String', num2str(reg.estim_duracion)); 
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
global reg;
    reg.conc_sodio_extra = get(hObject,'Value');
    set(reg.edit7, ...
        'String', num2str(reg.conc_sodio_extra));    
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
global reg;
reg.conc_sodio_intra = get(hObject,'Value');
    set(reg.edit8, ...
        'String', num2str(reg.conc_sodio_intra)); 
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
global reg;
reg.conc_potasio_extra = get(hObject,'Value');
    set(reg.edit9, ...
        'String', num2str(reg.conc_potasio_extra)); 
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
global reg;
reg.conc_potasio_intra = get(hObject,'Value');
    set(reg.edit10, ...
        'String', num2str(reg.conc_potasio_intra)); 
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
global reg;
reg.TTX = get(hObject,'Value');
    set(reg.edit11, ...
        'String', num2str(reg.TTX));
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
global reg;
reg.TEA = get(hObject,'Value');
    set(reg.edit12, ...
        'String', num2str(reg.TEA)); 
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit7_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=150)
    reg.conc_sodio_extra=str2double(get(hObject,'string'));
    set(reg.slider7,'Value',reg.conc_sodio_extra);
else
    errordlg('El valor debe estar comprendido entre 0 y 150', 'Valor no válido');
    set(reg.edit7, 'String', num2str(reg.conc_sodio_extra));
end;
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=20)
    reg.conc_sodio_intra=str2double(get(hObject,'string'));
    set(reg.slider8,'Value',reg.conc_sodio_intra);
else
    errordlg('El valor debe estar comprendido entre 0 y 20', 'Valor no válido');
    set(reg.edit8, 'String', num2str(reg.conc_sodio_intra));
end;
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit9_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=20)
    reg.conc_potasio_extra=str2double(get(hObject,'string'));
    set(reg.slider9,'Value',reg.conc_potasio_extra);
else
    errordlg('El valor debe estar comprendido entre 0 y 20', 'Valor no válido');
    set(reg.edit9, 'String', num2str(reg.conc_potasio_extra));
end;
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=150)
    reg.conc_potasio_intra=str2double(get(hObject,'string'));
    set(reg.slider10,'Value',reg.conc_potasio_intra);
else
    errordlg('El valor debe estar comprendido entre 0 y 150', 'Valor no válido');
    set(reg.edit10, 'String', num2str(reg.conc_potasio_intra));
end;
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=0.01)
    reg.TTX=str2double(get(hObject,'string'));
    set(reg.slider11,'Value',reg.TTX);
else
    errordlg('El valor debe estar comprendido entre 0 y 0.01', 'Valor no válido');
    set(reg.edit11, 'String', num2str(reg.TTX));
end;
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
global reg;
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=1000)
    reg.TEA=str2double(get(hObject,'string'));
    set(reg.slider12,'Value',reg.TEA);
else
    errordlg('El valor debe estar comprendido entre 0 y 1000', 'Valor no válido');
    set(reg.edit12, 'String', num2str(reg.TEA));
end;
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in por_defecto_button.
function por_defecto_button_Callback(hObject, eventdata, handles)
global reg;
reg.conc_sodio_extra=120;
set(reg.edit7,'String',num2str(reg.conc_sodio_extra));
set(reg.slider7,'Value',reg.conc_sodio_extra);

reg.conc_sodio_intra=15;
set(reg.edit8,'String',num2str(reg.conc_sodio_intra));
set(reg.slider8,'Value',reg.conc_sodio_intra);

reg.conc_potasio_extra=7;
set(reg.edit9,'String',num2str(reg.conc_potasio_extra));
set(reg.slider9,'Value',reg.conc_potasio_extra);

reg.conc_potasio_intra=140;
set(reg.edit10,'String',num2str(reg.conc_potasio_intra));
set(reg.slider10,'Value',reg.conc_potasio_intra);

reg.TTX=0;
set(reg.edit11,'String',num2str(reg.TTX));
set(reg.slider11,'Value',reg.TTX);

reg.TEA=0;
set(reg.edit12,'String',num2str(reg.TEA));
set(reg.slider12,'Value',reg.TEA);

% hObject    handle to por_defecto_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


