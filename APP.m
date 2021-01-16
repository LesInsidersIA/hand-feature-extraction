
function varargout = APP(varargin)
%APP MATLAB code file for APP.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('Property','Value',...) creates a new APP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to APP_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      APP('CALLBACK') and APP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in APP.M with the given input
%      arguments.
%
%      *See APP Options on GUIDE's Tools menu.  Choose "APP allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APP

% Last Modified by GUIDE v2.5 24-Nov-2020 22:00:16

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APP_OpeningFcn, ...
                   'gui_OutputFcn',  @APP_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before APP is made visible.
function APP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for APP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_image_btn.
function load_image_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_image_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.jpg'; '*.png'; '*.bmp'}, 'Select image', 'M:\Sagaf\images');

if (filename ~=0)
    
    % browse image, load and display on axe 1
    img = strcat(pathname, filename);
    axes(handles.axes1)
    original_image = imread(img);
    imshow(original_image);
    set(handles.pathname_edit, 'String', img);
    
    % get the ROI coordinate using mouse and crop the image
    rect = getrect;
    cropped_image = imcrop(original_image, rect);
    
    % expose the cropped image variable for future use within function
    % callback
    handles.cropped_image = cropped_image; 
    handles.original_image = original_image;
    guidata(hObject, handles);    
    return;
    
end

% --- Executes on button press in crop_btn.
function crop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to crop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% display the cropped image on the axes 2 
cropped_image1 = handles.cropped_image;
axes(handles.axes2)
imshow(cropped_image1);

% expose the cropped image to be used for binarization
handles.cropped_image1 = cropped_image1; 
guidata(hObject, handles);

% --- Executes on button press in histogram_equ.
function histogram_equ_Callback(hObject, eventdata, handles)
% hObject    handle to histogram_equ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_to_equalized = handles.cropped_image1;
equalized_image = histogram_equalization(img_to_equalized);
axes(handles.axes3)
imshow(equalized_image);

% expose equalized img to be used withing gui functions
handles.equalized_image = equalized_image; 
guidata(hObject, handles);

% --- Executes on button press in binarization_pb.
function binarization_pb_Callback(hObject, eventdata, handles)
% hObject    handle to binarization_pb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
to_be_binarized = handles.equalized_image;
binarized_image = binarization(to_be_binarized);
axes(handles.axes4);
imshow(binarized_image);

% expose equalized img to be used withing gui functions
handles.binarized_image = binarized_image; 
guidata(hObject, handles);


function browse_image_Callback(hObject, eventdata, handles)
% hObject    handle to browse_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of browse_image as text
%        str2double(get(hObject,'String')) returns contents of browse_image as a double


% --- Executes during object creation, after setting all properties.
function browse_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to browse_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in skeletonization_btn.
function skeletonization_btn_Callback(hObject, eventdata, handles)
% hObject    handle to skeletonization_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
to_be_skeletonized = handles.binarized_image;
skeletonized_image = skeletonization(to_be_skeletonized);
axes(handles.axes5);
imshow(skeletonized_image);


% expose equalized img to be used withing gui functions
handles.skeletonized_image = skeletonized_image; 
guidata(hObject, handles);

function pathname_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pathname_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathname_edit as text
%        str2double(get(hObject,'String')) returns contents of pathname_edit as a double


% --- Executes during object creation, after setting all properties.
function pathname_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathname_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in detect_minutiae.
function detect_minutiae_Callback(hObject, eventdata, handles)
% hObject    handle to detect_minutiae (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

detect_minutiae_image = handles.skeletonized_image;
[CentroidFinX, CentroidFinY, CentroidSepX, CentroidSepY] = detect_minutiae(detect_minutiae_image);

cf = [CentroidFinX, CentroidFinY];
cs = [CentroidSepX, CentroidSepY];

save('centroid_fin.mat', 'cf');
save('centroid_sep.mat', 'cs');

% --- Executes on button press in ending_points.
function ending_points_Callback(hObject, eventdata, handles)
% hObject    handle to ending_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
detect_minutiae_image = handles.skeletonized_image;
axes(handles.axes6);
load centroid_fin.mat
imshow(detect_minutiae_image);
hold on
% plot ending points
plot(cf(:,1), cf(:,2),'ro')

% --- Executes on button press in bifuractions.
function bifuractions_Callback(hObject, eventdata, handles)
% hObject    handle to ending_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
detect_minutiae_image = handles.skeletonized_image;
axes(handles.axes7);
load centroid_sep.mat
imshow(detect_minutiae_image);

hold on
% plot bifurcations
plot(cs(:,1), cs(:,2),'g^')

% --- Executes on button press in show_results_btn.
function show_results_btn_Callback(hObject, eventdata, handles)
% hObject    handle to show_results_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% display the cropped image on the axes 2 

load centroid_sep.mat
load centroid_fin.mat

axes(handles.axes8);
cropped_image1 = handles.cropped_image;
imshow(cropped_image1);

hold on;
plot(cs(:,1), cs(:,2),'g^')
plot(cf(:,1), cf(:,2),'ro')

% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close APP

% --- Executes on button press in process_all.
function process_all_Callback(hObject, eventdata, handles)
% hObject    handle to process_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.original_image;
img_to_process = histogram_equalization(img);
img_to_process = binarization(img_to_process);
img_to_process = skeletonization(img_to_process);
[CFX, CFY, CSX, CSY] = detect_minutiae(img_to_process);

% specify rectangle with mouse
roi = getrect
crp_img = imcrop(img_to_process, roi);
[rows, column, chanel] = size(crp_img)

x0 = roi(1)
y0 = roi(2)
x1 = x0 + roi(3)-1 % roi(3) is width of the rectangle
y1 = y0 + roi(4)-1 % roi(4) is heigth of the rectangle

%img(x0:x1,y0:y1) = crp_img(1:rows,1:column);
axes(handles.axes1);
%imshow(img(x0:x1,y0:y1,:))
hold on
plot(x0,y0, 'ro')
plot(x1,y1, 'ro')
%plot(CFX,CFY,'g^')
%plot(CSX,CSY,'ro')

