%%%%%%%%%%%%%%%%%%%%%%%%%%CHROMA KEY MATTING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following program consist in a simple implementation of a chroma key
%algorithm. After picking one of the images available in the
%Lab1chromakeyimgs folder, you should select the BG color through
%the radio buttons in the UI. You can change the values of alpha1 and
%alpha2 to get the most appealing result. You can compare the result
%with different backgrounds.
%An example of the final result can be found in this same folder.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = ui(varargin)
% Last Modified by GUIDE v2.5 19-Feb-2016 10:34:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
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


% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


%load the desired image and show it
handles.imgOriginal = im2double(imread('Lab1chromakeyimgs\bluescreeneeyore.png'));
axes(handles.axesOriginal);
imshow(handles.imgOriginal);
[handles.r, handles.c, handles.d] = size(handles.imgOriginal);
%load the desired background and show it
%1
handles.imgBG1 = im2double(imread('Backgrounds\bg1.png'));
handles.imgBG1=imresize(handles.imgBG1,[handles.r handles.c]);
handles.imgBG = handles.imgBG1;
axes(handles.axesBG);
imshow(handles.imgBG);
%3
%load the desired background and show it
handles.imgBG2 = im2double(imread('Backgrounds\bg2.png'));
handles.imgBG2=imresize(handles.imgBG2,[handles.r handles.c]);
%3
handles.imgBG3 = im2double(imread('Backgrounds\bg3.png'));
handles.imgBG3=imresize(handles.imgBG3,[handles.r handles.c]);


handles.red = handles.imgOriginal(:,:,1); % Red channel
handles.green = handles.imgOriginal(:,:,2); % Green channel
handles.blue = handles.imgOriginal(:,:,3); % Blue channel
handles.a = zeros(size(handles.imgOriginal, 1), size(handles.imgOriginal, 2));

handles.a1 = get(handles.alpha1Slider,'value');
handles.a2 = get(handles.alpha2Slider,'value');

computeAlpha(handles);
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function alpha1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
switch get(get(handles.uibuttonBackground,'SelectedObject'),'Tag')
    case 'radioBG1', handles.imgBG = handles.imgBG1;
    case 'radioBG2', handles.imgBG = handles.imgBG2;
    case 'radioBG3', handles.imgBG = handles.imgBG3;
end
handles.a1 = get(hObject,'value');
computeAlpha(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function alpha1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function alpha2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
switch get(get(handles.uibuttonBackground,'SelectedObject'),'Tag')
    case 'radioBG1', handles.imgBG = handles.imgBG1;
    case 'radioBG2', handles.imgBG = handles.imgBG2;
    case 'radioBG3', handles.imgBG = handles.imgBG3;
end
handles.a2 = get(hObject,'value');
computeAlpha(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function alpha2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
