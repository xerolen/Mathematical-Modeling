function [msg_origin] = LSB_extract(name)
% LSB_extract(name, lsb)
% name: the picture's path and name
% LSB in steganography (extract)
% 
% Author: Moming
% 2016-03-20

image = imread(name);

lsb = 3;
index = 1;
rgb = zeros(0);
[len_R, len_G, len_B] = size(image);

for R = 1 : len_R
    for G = 1 : len_G
        tmp = blanks(0);
        for B = 1 : len_B
            tmp = strcat(tmp, mod(image(R, G, B), 2^lsb) + '0');  % '0' is useful!!! Placeholder...
        end
        tmp_bin = dec2bin(tmp - '0', 3)';
        rgb(index) = bin2dec(tmp_bin(1 : 8));
        if rgb(index) == 4  % EOT is the end tag
            msg_origin = native2unicode(rgb, 'UTF-8');
            msg_origin = msg_origin(1 : end-1);
            return;
        end
        index = index + 1;
    end
end

end