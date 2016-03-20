
#LSB算法——隐藏文字信息

-------------
LSB（Least Significant Bit）最低有效位，指二进制中最低位数值。
详见WiKi：https://en.wikipedia.org/wiki/Least_significant_bit

-----------------------

## 隐写术 ##
隐写术是一种关于信息隐藏的技术，通常利用位图的RGB三种颜色值（0~255）在微小改变的情况下难以被人眼察觉的特点。每种颜色值都可以用8位二进制来表示，而最低有效位LSB技术就是通过修改最低几位的数值来将信息嵌入到图片中去。
详见WiKi：https://en.wikipedia.org/wiki/Steganography

-------------

## 相关方法 ##
LSB方面的论文有很多，在此利用以下这篇
> Chan C K, Cheng L M. Hiding data in images by simple LSB substitution[J]. Pattern recognition, 2004, 37(3): 469-474.
http://www.sciencedirect.com/science/article/pii/S003132030300284X

其具体的思路如下：
1. 设图像像素为$M_C \times N_C$， $C$表示原8-bit图像 $$C = \{x_{ij}|0 \leq i < M_C, 0 \leq j < N_C,x_{ij} \in \{0, 1, ..., 255\}\}$$ $M$为n-bit待隐藏的消息 $$M=\{m_i|0 \leq i < n, m_i \in \{0, 1\}\}$$
2. 将$M$重排为$M'$：$$M'=\{m'_i|0 \leq i < n', m'_i \in \{0, 1, ..., 2^k-1\}\}$$ 其中$n'<M_C \times N_C$ ，则$m'$ 可以表示为：$$m'_i=\Sigma^{k-1}_{j=0}m_{i \times k+j} \times 2^{k-1-j}$$
3. 从原图中按照既定规则挑选出$n'$ 个像素：$$\{x_{l1}, x_{l2}, ..., x_{ln'}\}$$ ，嵌入过程是通过用$m'$ 替换$x_{li}$ 的$k$ 位LSBs，则$x_{li}$ 会被替换成$$x'_{li}=x_{li}-(x_{li} ~mod~ 2^k)+m'_i$$
4. 提取消息的方法为：$$m'_i=x'_{li}~mod~2^k$$

------------------

## MATLAB相关函数解释 ##
1. imread( ) 用于读取需要嵌入隐藏信息的图片，并存储为 uint8 类型的三维RGB矩阵，每个数值都位于0~255间
2. strcat( ) 用于字符串连接
3. unicode2native( ) 将 unicode 编码转化为相应的数字字节，相对应的 native2unicode( ) 是将数字字节转化为对应的 unicode 编码
4. dec2bin( ) 将十进制数转化为二进制，可选参数为最少几位二进制，相应的 bin2dec( ) 是将二进制转化为十进制
5. strjoin( ) 将元胞中的字符串数组组合成一个单字符串
6. double( ) 将字符转化成相应的 ASCII 码，相应的 char( ) 将 ASCII 码转化成字符
7. imwrite( ) 将矩阵存成图片

----------------

##注意事项##
1. MATLAB的 imwrite() 函数存成图片时，若选用 .jpg 格式则会出现一定程度的失真，导致无法提取出正确信息，因此最好存为 .png 或其他格式
2. 以下给出的代码以EOF作为嵌入结束的标志
3. 以下代码适用于2-LSB
4. 以下代码有选择地将信息嵌入红、绿、蓝中的一层

----------------

##效果##
<img src="./flag.jpg" width = "300" />                                           <img src="./result.png" width = "300" />

结果对比（左图为原图，右图为加密后的图）

----------------

##源码##

###嵌入函数###

```matlab
function [] = LSB_embed(name, message, lsb, color)
% LSBembed(name, message, lsb)  LSB in steganography (embed)
% name: the picture's path and name
% message: the data you want to hide in the picture
% lsb: lsb-rightmost LSBs
% color: 1-red, 2-green, 3-blue
%
% Author: Moming
% 2016-03-16

image = imread(name);
msg_origin = unicode2native(strcat(message, char(4)), 'UTF-8');  % UTF-8 encode, 'EOT' is the end tag
msg_bin = dec2bin(msg_origin, 8);  % convert to binary
msg = strjoin(cellstr(msg_bin)','');

len = length(msg) / lsb;
while len ~= fix(len)
    strcat(msg, char(4));
    len = length(msg) / lsb;
end
tmp = blanks(len);
for i = 1 : len
    tmp(i) = char(bin2dec(msg((i - 1) * lsb + 1 : i * lsb)) + '0');  % '0' is a kind of placeholder
end

% use Red, Green or Blue
layer = image(:, :, color);
for i = 1 : len
    layer(i) = layer(i) - mod(layer(i), 2^lsb) + double(tmp(i) - '0');  % only to be consistent with front
end

% save the picture
image_result = image;
image_result(:, :, color) = layer;
imshow(image_result);
imwrite(image_result, 'result.png');  % jpg would lose some information

end
```
###提取函数###

```matlab
function [msg_origin] = LSB_extract(name, lsb, color)
% LSB_extract(name, lsb)  LSB in steganography (extract)
% name: the picture's path and name
% lsb: lsb-rightmost LSBs
% color: 1-red, 2-green, 3-blue
%
% Author: Moming
% 2016-03-17

image = imread(name);

layer = image(:, :, color);
tmp = blanks(0);
n = prod(size(layer));

% if lsb ~= 2, then you need to change something below
for i = 1 : n * lsb / 8
    tmp((i - 1) * 4 + 1 : i * 4) = mod(layer((i - 1) * 4 + 1 : i * 4), 2^lsb);
    msg((i - 1) * 8 + 1 : i * 8) = dec2bin(tmp((i - 1) * 4 + 1 : i * 4), lsb)';
    msg_origin(i) = bin2dec(msg((i - 1) * 8 + 1 : i * 8));
    if msg_origin(i) == 4  % EOT is the end tag
        break;
    end
end

msg_origin = native2unicode(msg_origin,'UTF-8');
msg_origin = msg_origin(1:end-1);

end
```

-----------------------

##改进：嵌入到RGB三层中##
**由于单个像素点的值表示成二进制为8位，为了方便进行嵌入，补上一位，凑成9位，分别嵌入到RGB三层中，且补上的一位以‘0’、‘1’、‘0’、‘1’的顺序出现，以达到‘0’、‘1’平衡，最后一个字符嵌入时对其补上的一位取反，作为结束标记**
###嵌入算法##

```matlab
function [] = LSB_embed(name, message)
% LSBembed(name, message, lsb)
% name: the picture's path and name
% message: the data you want to hide in the picture
% LSB in steganography (embed)
%
% Author: Moming
% 2016-03-20

lsb = 3;
image = imread(name);
msg_origin = unicode2native(message, 'UTF-8');  % UTF-8 encode
msg_bin = dec2bin(msg_origin, 8);  % convert to binary
msg = blanks(9);
for i = 1 : size(msg_bin, 1)
    msg(i, :) = strcat(msg_bin(i, :), char(mod(i, 2) + '0'));
end
msg = strjoin(cellstr(msg)','');
msg(end) = char(mod(size(msg_bin, 1) + 1, 2) + '0');  % change the last bit as the end tag

len = length(msg) / lsb;
tmp = blanks(len);
for i = 1 : len
    tmp(i) = char(bin2dec(msg((i - 1) * lsb + 1 : i * lsb)) + '0');  % convert to decimal
end

% use RGB
result = image;
rgb = 1;
[len_R, len_G, len_B] = size(result);

for R = 1 : len_R
    for G = 1 : len_G
        for B = 1 : len_B
            if rgb <= len
                % only to be consistent with front: '0'
                result(R, G, B) = result(R, G, B) - mod(result(R, G, B), 2^lsb) + double(tmp(rgb) - '0');
                rgb = rgb + 1;
            end
        end
    end
end

imshow(result);
imwrite(result, 'result.png');  % jpg would lose some information

end
```

###提取算法###

```matlab
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
flag = char('0');  % use to detect the end tag

for R = 1 : len_R
    for G = 1 : len_G
        tmp = blanks(0);
        for B = 1 : len_B
            tmp = strcat(tmp, mod(image(R, G, B), 2^lsb) + '0');  % '0' is useful!!! Placeholder...
        end
        tmp_bin = dec2bin(tmp - '0', 3)';
        rgb(index) = bin2dec(tmp_bin(1 : 8));
        if flag + tmp_bin(9) ~= 97  % '0'/'1' is the end tag
            msg_origin = native2unicode(rgb, 'UTF-8');
            return;
        end
        index = index + 1;
        flag = tmp_bin(9);
    end
end

end
```
