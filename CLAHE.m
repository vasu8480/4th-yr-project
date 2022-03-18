function[]=CLAHE(img)
close all;
%Reading the image, resizing the image and then converting it to gray-scale
img=load_image


resized_image=imresize(img,[512 512]);
img_gray=0.21*resized_image(:,:,1) + 0.72*resized_image(:,:,2) + 0.07*resized_image(:,:,3);


img_pad=double(padarray(img_gray,[8 8],'symmetric')); %Padding the image 
[row,col]=size(img_pad); %Storing the row and column number of the padded image
clip_limit=0.1; %Setting the clip limit
eqcount=zeros(row,col);
y_size=1;
x_size=1;
while(y_size<col)
    %Calculating the pixel count for every conextual area
    for x=x_size:x_size+16;
        for y=y_size:y_size+16;
            eqcount(x,y)=0;
            for i=x_size:x_size+16;
                for j=y_size:y_size+16;
                    if img_pad(i,j)==img_pad(x,y)
                        eqcount(x,y)=eqcount(x,y) + 1;
                    end
                end
            end
        end
    end
    if x_size==1;
        x_size=x_size+15;
    else
        x_size=x_size+16;
    end
    if x_size>=row
        x_size=1;
        if y_size==1;
            y_size=y_size+15;
        else
            y_size=y_size+16;
        end
    end    
end
output=(zeros(row,row));
y_size=1;
x_size=1;
while(y_size<col)
    %Calculating the various values for the computing CLAHE
    for x=x_size:x_size+16;
        for y=y_size:y_size+16;
            cliptotal=0;
            partialrank=0;
            for i=x_size:x_size+16;
                for j=y_size:y_size+16;
                    if eqcount(i,j) > clip_limit
                        incr=clip_limit/eqcount(i,j);
                    else
                        incr=1;
                    end
                    cliptotal=cliptotal+(1-incr);
                    if img_pad(x,y) >= img_pad(i,j)
                        partialrank = partialrank + incr;
                    end
                end
            end
            redistr = (cliptotal / (16*16)) * img_pad(x,y);
            output(x,y) = partialrank + redistr;
        end
    end
    if x_size==1;
        x_size=x_size+15;
    else
        x_size=x_size+16;
    end
    if x_size==row
        x_size=1;
        if y_size==1;
            y_size=y_size+15;
        else
            y_size=y_size+16;
        end
    end
end
    u=uint8(output);
    figure;
    imshow(u);
    title('CLAHE');
kenlRatio = .01;                
maxAtomsLight = 200;        
dehaze_weight = 0.9;        
img=u;
sz=size(img);
w=sz(2);
h=sz(1);

dc = zeros(h,w);
for y=1:h
    for x=1:w
        dc(y,x) = min(img(y,x,:));
    end
end
%subplot(2,4,2);imshow(uint8(dc)), title('Min(R,G,B)');
krnlsz = floor(max([3, w*kenlRatio, h*kenlRatio]));
dc2 = minfilt2(dc, [krnlsz,krnlsz]);
dc2(h,w)=0;figure;
imshow(uint8(dc2));
title('Dark Channel+clahe');
end
