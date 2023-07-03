I = g;
b = b;

I = rgb2lab(I);

r = I(:,:,3);
[w,h] = size(r);
for i = 1:w
    for j = 1:h
        if mod(r(i,j),2) ~= b(i,j)  %Ä©Î²²»Ò»Ñù
            r(i,j) = r(i,j) - mod(r(i,j),2) + g(i,j);
        end
    end
end
I(:,:,3) = r;
I =lab2rgb(I);
imwrite(I,'lena.jpg');


