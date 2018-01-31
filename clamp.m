function varargout = clamp(varargin)
% CLAMP M-file for clamp.fig
%      CLAMP, by itself, creates a new CLAMP or raises the existing
%      singleton*.
%
%      H = CLAMP returns the handle to a new CLAMP or the handle to
%      the existing singleton*.
%
%      CLAMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLAMP.M with the given input arguments.
%
%      CLAMP('Property','Value',...) creates a new CLAMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clamp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clamp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clamp

% Last Modified by GUIDE v2.5 29-Nov-2008 12:34:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @clamp_OpeningFcn, ...
                   'gui_OutputFcn',  @clamp_OutputFcn, ...
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


% --- Executes just before clamp is made visible.
function clamp_OpeningFcn(hObject, eventdata, handclamp, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handclamp    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clamp (see VARARGIN)

% Choose default command line output for clamp
handclamp.output = hObject;

handclamp.voltaje = -50;
handclamp.JNa=zeros(1,500);
handclamp.JK=zeros(1,500);
handclamp.t=zeros(1,500);

handclamp.band_sodio=false;
handclamp.band_potasio=false;
handclamp.band_total=false;

handclamp.Porctj=1;
handclamp.TTX=0;
handclamp.TEA=0;

% Update handclamp structure
guidata(hObject, handclamp);

% UIWAIT makes clamp wait for user response (see UIRESUME)
% uiwait(handles.clampfigure);


% --- Outputs from this function are returned to the command line.
function varargout = clamp_OutputFcn(hObject, eventdata, handclamp) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handclamp    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handclamp.output;


% --- Executes on button press in menu_button.
function menu_button_Callback(hObject, eventdata, handclamp)
h=guihandles(gcbo);
openfig('menu.fig');
close(h.clampfigure);
% hObject    handle to menu_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handclamp)
if (str2double(get(hObject,'string'))>=-70 && str2double(get(hObject,'string'))<=10)
    handclamp.voltaje=str2double(get(hObject,'string'));
    set(handclamp.slider1,'Value',handclamp.voltaje);
else
    errordlg('El valor debe estar comprendido entre -70 y 10', 'Valor no válido');
    set(handclamp.edit1,'String',num2str(handclamp.voltaje));
end;
guidata(hObject,handclamp);
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in corrpotasio_check.
function corrpotasio_check_Callback(hObject, eventdata, handclamp)
handaux=guihandles(gcbo);
axes(handaux.axes2);
if (get(hObject,'Value')==get(hObject,'Max'))
    handclamp.band_potasio=true;
    hold on;
    plot (handclamp.t,handclamp.JK, 'k');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
else
    handclamp.band_potasio=false;
    hold on;
    plot (handclamp.t,handclamp.JK, 'w');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
end;  
guidata(hObject,handclamp);
if ((handclamp.band_potasio==false) && (handclamp.band_sodio==false) && (handclamp.band_total==false))
    set(handclamp.simular_button,'Enable','on');
else
    set(handclamp.simular_button,'Enable','off');
end;
% hObject    handle to corrpotasio_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corrpotasio_check


% --- Executes on button press in corrtotal_check.
function corrtotal_check_Callback(hObject, eventdata, handclamp)
handaux=guihandles(gcbo);
axes(handaux.axes2);
if (get(hObject,'Value')==get(hObject,'Max'))
    handclamp.band_total=true;
    hold on;
    plot (handclamp.t,handclamp.JK+handclamp.JNa, 'r');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
else
    handclamp.band_total=false;
    hold on;
    plot (handclamp.t,handclamp.JK+handclamp.JNa, 'w');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
end;    
guidata(hObject,handclamp);
if ((handclamp.band_potasio==false) && (handclamp.band_sodio==false) && (handclamp.band_total==false))
    set(handclamp.simular_button,'Enable','on');
else
    set(handclamp.simular_button,'Enable','off');
end;
% hObject    handle to corrtotal_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corrtotal_check


% --- Executes on button press in corrsodio_check.
function corrsodio_check_Callback(hObject, eventdata, handclamp)
handaux=guihandles(gcbo);
axes(handaux.axes2);
if (get(hObject,'Value')==get(hObject,'Max'))
    handclamp.band_sodio=true;
    hold on;
    plot (handclamp.t,handclamp.JNa, 'g');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
else
    handclamp.band_sodio=false;
    hold on;
    plot (handclamp.t,handclamp.JNa, 'w');
    axis ([0 20 -2000 2000]);
    title('Corrientes iónicas en función del tiempo')
    xlabel('Tiempo [ms]'); ylabel('Densidad de corriente [uA/cm2]')
end;   
guidata(hObject,handclamp);
if ((handclamp.band_potasio==false) && (handclamp.band_sodio==false) && (handclamp.band_total==false))
    set(handclamp.simular_button,'Enable','on');
else
    set(handclamp.simular_button,'Enable','off');
end;
    

% hObject    handle to corrsodio_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corrsodio_check


% --- Executes on button press in simular_button.
function simular_button_Callback(hObject, eventdata, handclamp)
vol=handclamp.voltaje;
vol=vol+65;

alfa_n=0.01*(10-vol)/(exp((10-vol)/10)-1);
beta_n=0.125*exp(-vol/80);
alfa_m=0.1*(25-vol)/(exp((25-vol)/10)-1);
beta_m=4*exp(-vol/18);
alfa_h=0.07*exp(-vol/20);
beta_h=1/(exp((30-vol)/10)+1);

ggK=36;
ggNa=120;
ggL=0.3;
vK=-12;
vNa=65+61.55*log10(handclamp.Porctj*6.4915);
%vL=10.6;

%Cm=1;

delta=0.04;
t=[0:delta:20-delta];

v=zeros(1,length(t));
n=zeros(1,length(t));
m=zeros(1,length(t));
h=zeros(1,length(t));
gKvector=zeros(1,length(t));
gNavector=zeros(1,length(t));

%condiciones iniciales
v(1)=vol;
n(1)=0.3177;
m(1)=0.0529;
h(1)=0.5961;

for i=2:length(t)
    gK=(-handclamp.TEA/1000+1)*ggK*(n(i-1))^4;
    gNa=(-handclamp.TTX/0.01+1)*ggNa*(m(i-1)^3)*h(i-1);
    
    %Iap(i)=0.2*i*delta; %para fenomeno de acomodacion
    
    v(i)=vol; %para clampeo de voltaje
    n(i)=(alfa_n*(1-n(i-1))-beta_n*n(i-1))*delta+n(i-1);
    m(i)=(alfa_m*(1-m(i-1))-beta_m*m(i-1))*delta+m(i-1);
    h(i)=(alfa_h*(1-h(i-1))-beta_h*h(i-1))*delta+h(i-1);
    
    gKvector(i-1)=gK;
    gNavector(i-1)=gNa;
    
end;


gKvector(length(gKvector))=gKvector(length(gKvector)-1);
gNavector(length(gNavector))=gNavector(length(gNavector)-1);

JNa=(v-vNa).*gNavector;
JK=(v-vK).*gKvector;
handclamp.JNa=JNa;
handclamp.JK=JK;
handclamp.t=t;

guidata(hObject, handclamp);

axes(handclamp.axes1);
plot(t,v-65,'r');%le restamos 65 a v para estar en referencia al potencial de reposo
axis([0 20 -70 30]);
title('Voltaje de membrana en función del tiempo')
xlabel('Tiempo [ms]'); ylabel('Voltaje [mV]')




% hObject    handle to simular_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handclamp)
    handclamp.voltaje = get(hObject,'Value');
    set(handclamp.edit1, ...
        'String', num2str(handclamp.voltaje)); 
    guidata(hObject,handclamp);
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handclamp)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=100)
    aux=str2double(get(hObject,'string'));
    handclamp.Porctj=aux/100;
    set(handclamp.slider2,'Value',aux);
else
    errordlg('El valor debe estar comprendido entre 0 y 100','Valor no válido');
    set(handclamp.edit2,'String',num2str(handclamp.Porctj*100));
end;
guidata(hObject,handclamp);
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handclamp)
aux=  get(hObject,'Value');  
handclamp.Porctj = aux/100;
    set(handclamp.edit2, ...
        'String', num2str(aux)); 
    guidata(hObject,handclamp);
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handclamp)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=0.01)
    handclamp.TTX=str2double(get(hObject,'string'));
    set(handclamp.slider3,'Value',handclamp.TTX);
else
    errordlg('El valor debe estar comprendido entre 0 y 0.01', 'Valor no válido');
    set(handclamp.edit3, 'String', num2str(handclamp.TTX));
end;
guidata(hObject,handclamp);
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handclamp)
handclamp.TTX = get(hObject,'Value');
    set(handclamp.edit3, ...
        'String', num2str(handclamp.TTX)); 
    guidata(hObject,handclamp);
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handclamp)
if (str2double(get(hObject,'string'))>=0 && str2double(get(hObject,'string'))<=1000)
    handclamp.TEA=str2double(get(hObject,'string'));
    set(handclamp.slider4,'Value',handclamp.TEA);
else
    errordlg('El valor debe estar comprendido entre 0 y 1000', 'Valor no válido');
    set(handclamp.edit4, 'String', num2str(handclamp.TEA));
end;
guidata(hObject,handclamp);
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handclamp)
handclamp.TEA = get(hObject,'Value');
    set(handclamp.edit4, ...
        'String', num2str(handclamp.TEA)); 
    guidata(hObject,handclamp);
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handclamp)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


