function img = load_image(num)
num=57
% num is the num of image with 
prefix = 'C:\Users\vasu\Desktop\matcodes\';
suffix = '.jpg';
path = [prefix,num2str(num),suffix];

img = imread(path);
end