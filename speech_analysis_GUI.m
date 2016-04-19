function varargout = speech_analysis_GUI(varargin)
% SPEECH_ANALYSIS_GUI MATLAB code for speech_analysis_GUI.fig
%      SPEECH_ANALYSIS_GUI, by itself, creates a new SPEECH_ANALYSIS_GUI or raises the existing
%      singleton*.
%
%      H = SPEECH_ANALYSIS_GUI returns the handle to a new SPEECH_ANALYSIS_GUI or the handle to
%      the existing singleton*.
%
%      SPEECH_ANALYSIS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEECH_ANALYSIS_GUI.M with the given input arguments.
%
%      SPEECH_ANALYSIS_GUI('Property','Value',...) creates a new SPEECH_ANALYSIS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speech_analysis_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speech_analysis_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speech_analysis_GUI

% Last Modified by GUIDE v2.5 06-Apr-2016 20:46:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speech_analysis_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @speech_analysis_GUI_OutputFcn, ...
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


% --- Executes just before speech_analysis_GUI is made visible.
function speech_analysis_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speech_analysis_GUI (see VARARGIN)

% Choose default command line output for speech_analysis_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speech_analysis_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speech_analysis_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function speech_file_Callback(hObject, eventdata, handles)
% hObject    handle to speech_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speech_file as text
%        str2double(get(hObject,'String')) returns contents of speech_file as a double


% --- Executes during object creation, after setting all properties.
function speech_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speech_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metronome_track_Callback(hObject, eventdata, handles)
% hObject    handle to metronome_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metronome_track as text
%        str2double(get(hObject,'String')) returns contents of metronome_track as a double


% --- Executes during object creation, after setting all properties.
function metronome_track_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metronome_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampling_rate_Callback(hObject, eventdata, handles)
% hObject    handle to sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampling_rate as text
%        str2double(get(hObject,'String')) returns contents of sampling_rate as a double


% --- Executes during object creation, after setting all properties.
function sampling_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metronome_type_Callback(hObject, eventdata, handles)
% hObject    handle to metronome_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metronome_type as text
%        str2double(get(hObject,'String')) returns contents of metronome_type as a double


% --- Executes during object creation, after setting all properties.
function metronome_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metronome_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metronome_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to metronome_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metronome_bpm as text
%        str2double(get(hObject,'String')) returns contents of metronome_bpm as a double


% --- Executes during object creation, after setting all properties.
function metronome_bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metronome_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


speech_file
metronome_track
sampling_rate
metronome_type
metronome_bpm


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

