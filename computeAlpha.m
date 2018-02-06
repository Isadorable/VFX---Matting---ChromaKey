function computeAlpha(handles)

%according to the background, we apply the same type of matting formula
switch get(get(handles.uibuttonColor,'SelectedObject'),'Tag')
      case 'Blue',
          for i = 1:size(handles.imgOriginal,1)
              for j = 1:size(handles.imgOriginal,2)
                  %(1-a1)*(b-a2*g)
                  alpha = 1-handles.a1*(handles.blue(i,j)-handles.a2*handles.green(i,j));
                  handles.a(i,j) = alpha;
                  if(alpha>1)
                      handles.a(i,j) = 1;
                  elseif(alpha < 0)
                      handles.a(i,j) = 0;
                  end
              end
          end
    case 'Green',
        for i = 1:size(handles.imgOriginal,1)
            for j = 1:size(handles.imgOriginal,2)
                %(1-a1)*(g-a2*g)
                alpha = 1-handles.a1*(handles.green(i,j)-handles.a2*handles.blue(i,j));
                handles.a(i,j) = alpha;
                if(alpha>1)
                    handles.a(i,j) = 1;
                elseif(alpha < 0)
                    handles.a(i,j) = 0;
                end
            end
        end;
end

%final alpha
axes(handles.axesAlpha);
imshow(handles.a);

%final foreground
res = bsxfun(@times, handles.imgOriginal, handles.a);
axes(handles.axesResult);
imshow(res);

%composite image
invA = imcomplement(handles.a);
BG = bsxfun(@times, handles.imgBG, invA);
resBG = bsxfun(@plus, res, BG);
axes(handles.axesBG);
imshow(resBG);
end