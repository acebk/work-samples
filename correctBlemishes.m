function correctBlemishes(imfile)
% Shows an image and corrects the blemishes selected by the user.
% imfile is a char vector naming a jpeg color image.
% 1. Display the image named by imfile.  
% 2. Allow the user to select a blemish by mouse clicking around it.
% 3. Approximate the blemish as a circular area. 
% 4. Correct the blemish by assigning to the pixels in the circular blemish
%    area the median color calculated from some pixels outside the blemish.
% 5. User can select another blemish to correct by clicking in the image 
%    again or quit the program by clicking outside the image.  
% 6. The image with all the selected blemishes fixed is saved in the file 
%    `blemishfixed.jpg` in the current directory.

im= imread(imfile);
imshow(im)
message= 'Click around a blemish for correction or click outside to exit';
title(message)
hold on

[maxY, maxX, ~]= size(im);  % Note that rows correspond to y-coordinates
                            %   while columns correspond to x-coordinates
[x,y]= ginput(1);           % Get 1st user click

while x>=1 && x<=maxX && y>=1 && y<=maxY
    [xClicks, yClicks]= selectBlemish(im, x, y);
    [x, y, r]= approxCircle(xClicks, yClicks);
    im= assignColor(im, x, y, r);
    imshow(im)
    title(message)
    [x,y]= ginput(1);
end
imwrite(im, 'blemishfixed.jpg');
imshow(im)  % Or title('') to clear the title message

hold off


