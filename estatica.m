function varargout = estatica(varargin)
% ESTATICA M-file for estatica.fig
%      ESTATICA, by itself, creates a new ESTATICA or raises the existing
%      singleton*.
%
%      H = ESTATICA returns the handle to a new ESTATICA or the handle to
%      the existing singleton*.
%
%      ESTATICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESTATICA.M with the given input arguments.
%
%      ESTATICA('Property','Value',...) creates a new ESTATICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before estatica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to estatica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help estatica

% Last Modified by GUIDE v2.5 18-Feb-2009 10:24:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @estatica_OpeningFcn, ...
                   'gui_OutputFcn',  @estatica_OutputFcn, ...
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


% --- Executes just before estatica is made visible.
function estatica_OpeningFcn(hObject, eventdata, handest, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to estatica (see VARARGIN)

% Choose default command line output for estatica
handest.output = hObject;

handest.tiempo=20;

handest.estim1_duracion=0;
handest.estim1_amplitud=0;

handest.conc_sodio_extra=120;
handest.conc_potasio_extra=7;
handest.conc_sodio_intra=15;
handest.conc_potasio_intra=140;
handest.TTX=0;
handest.TEA=0;

handest.estim2_comienzo=0;
handest.estim2_duracion=0;
handest.estim2_amplitud=0;

%para constantes de tiempo en funcion del potencial
handest.tau_n=zeros(1,handest.tiempo/0.04);
handest.tau_m=zeros(1,handest.tiempo/0.04);
handest.tau_h=zeros(1,handest.tiempo/0.04);


% Update handles structure
guidata(hObject, handest);

% UIWAIT makes estatica wait for user response (see UIRESUME)
% uiwait(handles.estfigure);


% --- Outputs from this function are returned to the command line.
function varargout = estatica_OutputFcn(hObject, eventdata, handest) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Get default command line output from handest structure
varargout{1} = handest.output;


% --- Executes on button press in menu_button.
function menu_button_Callback(hObject, eventdata, handest)
h=guihandles(gcbo);
menu;
close(h.estfigure);
% hObject    handle to menu_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=10 && str2double(get(hObject,'string'))<=60)
    handest.tiempo=str2double(get(hObject,'string'));
    set(handest.slider1,'Value',handest.tiempo);
    set(handest.slider3,'Max',handest.tiempo);
    set(handest.slider4,'Max',handest.tiempo);
else
    errordlg('El valor debe estar comprendido entre 10 y 60', 'Valor no válido');
    set(handest.edit1, 'String', num2str(handest.tiempo));
end;
guidata(hObject,handest);
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=-25 && str2double(get(hObject,'string'))<=25)
    handest.estim1_amplitud=str2double(get(hObject,'string'));
    set(handest.slider2,'Value',handest.estim1_amplitud);
else
    errordlg('El valor debe estar comprendido entre -25 y 25', 'Valor no válido');
    set(handest.edit2, 'String', num2str(handest.estim1_amplitud));
end;
guidata(hObject,handest);
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=handest.tiempo)
    handest.estim1_duracion=str2double(get(hObject,'string'));
    set(handest.slider3,'Value',handest.estim1_duracion);
else
    linea='El valor debe estar comprendido entre 0 y ';
    linea=[linea num2str(handest.tiempo)];
    errordlg(linea, 'Valor no válido');
    set(handest.edit3, 'String', num2str(handest.estim1_duracion));
end;
guidata(hObject,handest);
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=-25 && str2double(get(hObject,'string'))<=25)
    handest.estim2_amplitud=str2double(get(hObject,'string'));
    set(handest.slider5,'Value',handest.estim2_amplitud);
else
    errordlg('El valor debe estar comprendido entre -25 y 25', 'Valor no válido');
    set(handest.edit4, 'String', num2str(handest.estim2_amplitud));
end;
guidata(hObject,handest);
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=-25 && str2double(get(hObject,'string'))<=25)
    handest.estim2_duracion=str2double(get(hObject,'string'));
    set(handest.slider6,'Value',handest.estim2_duracion);
else
    errordlg('El valor debe estar comprendido entre -25 y 25', 'Valor no válido');
    set(handest.edit5, 'String', num2str(handest.estim2_duracion));
end;
guidata(hObject,handest);
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=handest.tiempo)
    handest.estim1_comienzo=str2double(get(hObject,'string'));
    set(handest.slider4,'Value',handest.estim1_comienzo);
else
    linea='El valor debe estar comprendido entre 0 y ';
    linea=[linea num2str(handest.tiempo)];
    errordlg(linea, 'Valor no válido');
    set(handest.edit6, 'String', num2str(handest.estim1_comienzo));
end;
guidata(hObject,handest);
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=20)
    handest.conc_sodio_intra=str2double(get(hObject,'string'));
    set(handest.slider8,'Value',handest.conc_sodio_intra);
else
    errordlg('El valor debe estar comprendido entre 0 y 20', 'Valor no válido');
    set(handest.edit8, 'String', num2str(handest.conc_sodio_intra));
end;
guidata(hObject,handest);
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=150)
    handest.conc_sodio_extra=str2double(get(hObject,'string'));
    set(handest.slider7,'Value',handest.conc_sodio_extra);
else
    errordlg('El valor debe estar comprendido entre 0 y 150', 'Valor no válido');
    set(handest.edit7, 'String', num2str(handest.conc_sodio_extra));
end;
guidata(hObject,handest);
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=150)
    handest.conc_potasio_intra=str2double(get(hObject,'string'));
    set(handest.slider10,'Value',handest.conc_potasio_intra);
else
    errordlg('El valor debe estar comprendido entre 0 y 150', 'Valor no válido');
    set(handest.edit10, 'String', num2str(handest.conc_potasio_intra));
end;
guidata(hObject,handest);
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=20)
    handest.conc_potasio_extra=str2double(get(hObject,'string'));
    set(handest.slider9,'Value',handest.conc_potasio_extra);
else
    errordlg('El valor debe estar comprendido entre 0 y 20', 'Valor no válido');
    set(handest.edit9, 'String', num2str(handest.conc_potasio_extra));
end;
guidata(hObject,handest);
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=1000)
    handest.TEA=str2double(get(hObject,'string'));
    set(handest.slider12,'Value',handest.TEA);
else
    errordlg('El valor debe estar comprendido entre 0 y 0.01', 'Valor no válido');
    set(handest.edit12, 'String', num2str(handest.TEA));
end;
guidata(hObject,handest);
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handest)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=0.01)
    handest.TTX=str2double(get(hObject,'string'));
    set(handest.slider11,'Value',handest.TTX);
else
    errordlg('El valor debe estar comprendido entre 0 y 0.01', 'Valor no válido');
    set(handest.edit11, 'String', num2str(handest.TTX));
end;
guidata(hObject,handest);
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handest)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    empty - handest not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in estim_selec.
function estim_selec_SelectionChangeFcn(hObject, eventdata, handest)
% hObject    handle to the selected object in estim_selec 
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)


% --- Executes on button press in un_estim_band.
function un_estim_band_Callback(hObject, eventdata, handest)
if (get(hObject,'Value')==get(hObject,'Max'))
    set(handest.seg_estim_panel,'Visible','off');
    handest.estim2_comienzo=0;
    handest.estim2_duracion=0;
    handest.estim2_amplitud=0;
end;
guidata(hObject,handest);
    
    
% hObject    handle to un_estim_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handest    structure with handest and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of un_estim_band


% --- Executes on button press in dos_estim_band.
function dos_estim_band_Callback(hObject, eventdata, handest)
if (get(hObject,'Value')==get(hObject,'Max'))
    set(handest.seg_estim_panel,'Visible','on');
    set(handest.edit6,'String',num2str(handest.estim2_comienzo));
    set(handest.edit4,'String',num2str(handest.estim2_amplitud));
    set(handest.edit5,'String',num2str(handest.estim2_duracion));
end;
guidata(hObject,handest);
% hObject    handle to dos_estim_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dos_estim_band


% --- Executes on button press in simular_button.
function simular_button_Callback(hObject, eventdata, handest)
%constantes
vol=0;

alfa_n=0.01*(10-vol)/(exp((10-vol)/10)-1);
beta_n=0.125*exp(-vol/80);
alfa_m=0.1*(25-vol)/(exp((25-vol)/10)-1);
beta_m=4*exp(-vol/18);
alfa_h=0.07*exp(-vol/20);
beta_h=1/(exp((30-vol)/10)+1);

tau_n=1/(alfa_n+beta_n);
tau_m=1/(alfa_m+beta_m);
tau_h=1/(alfa_h+beta_h);

ggK=36;
ggNa=120;
ggL=0.3;
vK=65+58.175*log10(handest.conc_potasio_extra/handest.conc_potasio_intra);
vNa=65+58.175*log10(handest.conc_sodio_extra/handest.conc_sodio_intra);
vL=10.6;

Cm=1;


%vectores
delta=0.04;
t=[0:delta:handest.tiempo];

v=zeros(1,length(t));
n=zeros(1,length(t));
m=zeros(1,length(t));
h=zeros(1,length(t));
gKvector=zeros(1,length(t));
gNavector=zeros(1,length(t));

gKvector(1)=ggK;
gNavector(1)=ggNa;

%condiciones iniciales
v(1)=0;
n(1)=0.3177;
m(1)=0.0529;
h(1)=0.5961;

Iap=zeros(1,length(t));%vector de estimulos

estimulo1.tiempo=handest.estim1_duracion;
estimulo1.amplitud=handest.estim1_amplitud;
i=1;
while i*delta<=estimulo1.tiempo
    Iap(i)=estimulo1.amplitud;
    i=i+1;
end;

estimulo2.comienzo=handest.estim2_comienzo;
estimulo2.tiempo=handest.estim2_duracion;
estimulo2.amplitud=handest.estim2_amplitud;

if ((estimulo1.tiempo+estimulo2.comienzo+estimulo2.tiempo)<=handest.tiempo)
    i=round(estimulo2.comienzo/delta);
    while (i*delta<=(estimulo2.comienzo+estimulo2.tiempo))
        Iap(i+1)=estimulo2.amplitud;
        i=i+1;
    end;
else
    mensaje=errordlg('El tiempo total de estimulos supera el tiempo de simulación','Tiempo de simulación excedido');
    handest.estim2_comienzo=0;
    handest.estim2_amplitud=0;
    handest.estim2_duracion=0;
    set(handest.edit6,'String',num2str(handest.estim2_comienzo));
    set(handest.edit4,'String',num2str(handest.estim2_amplitud));
    set(handest.edit5,'String',num2str(handest.estim2_duracion));
    uiwait(mensaje);
end;
    
for i=2:length(t)
    gK=(-handest.TEA/1000+1)*ggK*(n(i-1))^4;
    gNa=(-handest.TTX/0.01+1)*ggNa*(m(i-1)^3)*h(i-1);
        
    v(i)=((-gK*(v(i-1)-vK)-gNa*(v(i-1)-vNa)-ggL*(v(i-1)-vL)+Iap(i))/Cm)*delta + v(i-1);
    %v(i)=55; %para clampeo de voltaje
    n(i)=(alfa_n*(1-n(i-1))-beta_n*n(i-1))*delta+n(i-1);
    m(i)=(alfa_m*(1-m(i-1))-beta_m*m(i-1))*delta+m(i-1);
    h(i)=(alfa_h*(1-h(i-1))-beta_h*h(i-1))*delta+h(i-1);
    
    alfa_n=0.01*(10-v(i))/(exp((10-v(i))/10)-1);
    beta_n=0.125*exp(-v(i)/80);
    alfa_m=0.1*(25-v(i))/(exp((25-v(i))/10)-1);
    beta_m=4*exp(-v(i)/18);
    alfa_h=0.07*exp(-v(i)/20);
    beta_h=1/(exp((30-v(i))/10)+1);

    gKvector(i)=gK;
    gNavector(i)=gNa;
    
end;



v=v-65;%para estar en referencia a los -70mV de reposo

guidata(hObject,handest);
axes(handest.axes1);
plot(t,v,'r');
axis([0 t(length(t)) -90 60])
title('Voltaje de Membrana en función del tiempo')
ylabel('Voltaje [mV]')

axes(handest.axes4);
plot(t,Iap,'k');
axis([0 t(length(t)) (min(Iap)-2) max(Iap)+2])

xlabel('Tiempo [ms]'); ylabel('Corriente [uA]')

axes(handest.axes2);
plot(t,gNavector,'b',t,gKvector,'k');
axis([0 t(length(t)) 0 50])
title('Conductancias en función del tiempo')
xlabel('Tiempo [ms]'); ylabel('Conductancia [mS]')
legend('g_N_a','g_K','Orientation','Horizontal');


axes(handest.axes3);
plot(t,n,'b',t,m,'k',t,h,'r');
axis([0 t(length(t)) 0 1.4])
title('Proporción de compuertas abiertas en función del tiempo')
xlabel('Tiempo [ms]');
legend('n','m','h','Orientation','Horizontal');
% hObject    handle to simular_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handest)
handest.tiempo = get(hObject,'Value');
    set(handest.edit1, ...
        'String', num2str(handest.tiempo)); 
    set(handest.slider3,'Max',handest.tiempo);
    set(handest.slider4,'Max',handest.tiempo);
    guidata(hObject,handest);
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handest)
handest.estim1_amplitud = get(hObject,'Value');
    set(handest.edit2, ...
        'String', num2str(handest.estim1_amplitud)); 
    guidata(hObject,handest);
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handest)
handest.estim1_duracion = get(hObject,'Value');
    set(handest.edit3, ...
        'String', num2str(handest.estim1_duracion)); 
    guidata(hObject,handest);
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handest)
    handest.estim2_comienzo = get(hObject,'Value');
    set(handest.edit6, ...
        'String', num2str(handest.estim2_comienzo)); 
    guidata(hObject,handest);
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handest)
handest.estim2_amplitud = get(hObject,'Value');
    set(handest.edit4, ...
        'String', num2str(handest.estim2_amplitud)); 
    guidata(hObject,handest);
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handest)
handest.estim2_duracion = get(hObject,'Value');
    set(handest.edit5, ...
        'String', num2str(handest.estim2_duracion)); 
    guidata(hObject,handest);
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handes)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in por_defecto_button.
function por_defecto_button_Callback(hObject, eventdata, handest)
handest.conc_sodio_extra=120;
set(handest.edit7,'String',num2str(handest.conc_sodio_extra));
set(handest.slider7,'Value',handest.conc_sodio_extra);

handest.conc_sodio_intra=15;
set(handest.edit8,'String',num2str(handest.conc_sodio_intra));
set(handest.slider8,'Value',handest.conc_sodio_intra);

handest.conc_potasio_extra=7;
set(handest.edit9,'String',num2str(handest.conc_potasio_extra));
set(handest.slider9,'Value',handest.conc_potasio_extra);

handest.conc_potasio_intra=140;
set(handest.edit10,'String',num2str(handest.conc_potasio_intra));
set(handest.slider10,'Value',handest.conc_potasio_intra);

handest.TTX=0;
set(handest.edit11,'String',num2str(handest.TTX));
set(handest.slider11,'Value',handest.TTX);

handest.TEA=0;
set(handest.edit12,'String',num2str(handest.TEA));
set(handest.slider12,'Value',handest.TEA);

guidata(hObject,handest);
% hObject    handle to por_defecto_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handest)
    handest.conc_sodio_extra = get(hObject,'Value');
    set(handest.edit7, ...
        'String', num2str(handest.conc_sodio_extra)); 
    guidata(hObject,handest);
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handest)
handest.conc_sodio_intra = get(hObject,'Value');
    set(handest.edit8, ...
        'String', num2str(handest.conc_sodio_intra)); 
    guidata(hObject,handest);
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handest)
handest.conc_potasio_extra = get(hObject,'Value');
    set(handest.edit9, ...
        'String', num2str(handest.conc_potasio_extra)); 
    guidata(hObject,handest);
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handest)
handest.conc_potasio_intra = get(hObject,'Value');
    set(handest.edit10, ...
        'String', num2str(handest.conc_potasio_intra)); 
    guidata(hObject,handest);
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handest)
handest.TTX = get(hObject,'Value');
    set(handest.edit11, ...
        'String', num2str(handest.TTX)); 
    guidata(hObject,handest);
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handest)
handest.TEA = get(hObject,'Value');
    set(handest.edit12, ...
        'String', num2str(handest.TEA)); 
    guidata(hObject,handest);
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handest)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


