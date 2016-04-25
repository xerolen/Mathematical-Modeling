#写入结果
import codecs
import random

def load_dic(filename):
    f = open(filename, encoding = 'utf8')
    word_dic = set()
    max_length = 1
    for line in f:
        word = line.strip()
        word_dic.add(word)
        if len(word) > max_length:
            max_length = len(word)
    f.close()
    return max_length, word_dic


def fmm_word_seg(sentence, word_dic, max_length):
    begin = 0
    words = []
    #sentence = unicode(sentence, 'utf-8')
    while begin < len(sentence):
        for end in range(min(begin + max_length, len(sentence)), begin, -1):
            word = sentence[begin:end]
            if word in word_dic or end == begin + 1:
                words.append(word)
                break
        begin = end
    return words


#print("Begin!")
max_len, word_dic = load_dic('WordsTrain.txt')

def ConsultWords(sentence):
    mydic = {}
    words = fmm_word_seg(sentence, word_dic, max_len)
    for word in words:
        if word not in mydic:
            mydic[word] = 1
        else:
            mydic[word] += 1
    #print(mydic)
    return mydic

def UpdateDic(mydic, newdic):
	for word in newdic:
		if word in mydic:
			mydic[word] += newdic[word]
		else:
			mydic[word] = newdic[word]
	return mydic

def Myrandom(lst):
        rand = random.uniform(0,1)
        for i in [1,2,3]:
                if lst[i] > rand:
                        lst[i] = round(lst[i]/lst[0])
                else:
                        lst[i] = 0

        return lst

def MyNewdic(newdic, num1, num2, num3):
	mydic = {}
	for word in newdic:
		num = newdic[word]
		mydic[word] = [num1*num,num2*num,num3*num]
	return mydic

#训练
f = open('weibo_train_data.txt', encoding = 'utf8')

weibo = {}#字典（用户标记：（转发、评论、点赞数））
BigV = set()#集合（大V）
MyDic = {}
Total = 0
#Hotmail = set()#集合（火爆微博）

for line in f.readlines():
    lineArr = line.strip().split('\t')
    #print(lineArr[6])
    Total += 1
    name = lineArr[0]

   # if int(lineArr[3]) > 1000 or int(lineArr[4]) > 1000 or int(lineArr[5]) >1000:
    #    Hotmail.add(lineArr[6])
    
    if name not in weibo:
        weibo[name] = [1, int(lineArr[3]), int(lineArr[4]), int(lineArr[5])]#条数、转发、评论、点赞数
    else:
        weibo[name][0] += 1;
        weibo[name][1] += int(lineArr[3]);
        weibo[name][2] += int(lineArr[4]);
        weibo[name][3] += int(lineArr[5]);

    if int(lineArr[3]) + int(lineArr[4]) + int(lineArr[5]) >= 2500:#设置BigV的阈值
        BigV.add(name)
        
    newdic = ConsultWords(lineArr[6])
    newdic = MyNewdic(newdic, int(lineArr[3]),  int(lineArr[4]),  int(lineArr[5]))
    MyDic = UpdateDic(MyDic, newdic)
    
f.close()



def MyCount(words):
        nums = [0,0,0]
        for word in words:
                if word in MyDic:
                        nums[0] += double(MyDic[word][0])/Total
                        nums[1] += double(MyDic[word][1])/Total
                        nums[2] += double(MyDic[word][2])/Total
        return nums

#结果
readfile = open('weibo_predict_data.txt', encoding='utf-8')

Name = []
Label = []
Words = []
linenum = 0

for line in readfile.readlines():
        fileArr = line.strip().split('\t')
        Name.append(fileArr[0])
        Label.append(fileArr[1])
        Words.append(fileArr[3])
        linenum += 1


readfile.close()

writefile = codecs.open(r'NewResult.txt', 'w', 'utf-8')

weibo_key = weibo.keys()

for i in range(linenum):
        if Name[i] in BigV:
                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(round(weibo[Name[i]][1]/weibo[Name[i]][0])) + '\t'+  str(round(weibo[Name[i]][2]/weibo[Name[i]][0]))+'\t'+  str(round(weibo[Name[i]][3]/weibo[Name[i]][0]))+'\n')
        elif Name[i] in weibo_key:
                weibo[name] = Myrandom(weibo[name])
                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(weibo[Name[i]][1]) + '\t'+  str(weibo[Name[i]][2])+'\t'+  str(weibo[Name[i]][3])+'\n')
        else:
                nums = MyCount(Words[i])
                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(nums[0]) + '\t'+  str(nums[1])+'\t'+  str(nums[2])+'\n')


writefile.close()



