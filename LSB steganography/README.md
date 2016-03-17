# LSB steganography
---------

本程序所用的嵌入和提取方法参考以下文献：

> Chan C K, Cheng L M. Hiding data in images by simple LSB substitution[J]. Pattern recognition, 2004, 37(3): 469-474.
http://www.sciencedirect.com/science/article/pii/S003132030300284X

----------
Note:
1. 程序的隐藏信息依靠EOF作为结尾标志
2. 嵌入算法的lsb可根据需要进行更改
3. 提取信息时为了方便检测结尾标志，会一个一个读UTF-8码，提供的程序适用于2位lsb，如需修改，则需要更改程序中循环体中的下标（3位的时候会比较麻烦，1位4位比较容易）（确实是代码写得有点丑。。。）
