#写入结果
import codecs
import random
import pickle

def Myrandom(lst):
        rand = random.uniform(0,1)
        for i in [1,2,3]:
                if lst[i] > rand:
                        lst[i] = round(lst[i]/lst[0])
                else:
                        lst[i] = 0

        return lst


f = open('weibo_train_data.txt', encoding = 'utf8')
Total = 0
weibo = {}#字典（用户标记：（转发、评论、点赞数））
BigV = set()#集合（大V）
for line in f.readlines():
    lineArr = line.strip().split('\t')
    #print(lineArr[6])
    Total += 1
    name = lineArr[0]

    if name not in weibo:
        weibo[name] = [1, int(lineArr[3]), int(lineArr[4]), int(lineArr[5])]#条数、转发、评论、点赞数
    else:
        weibo[name][0] += 1
        weibo[name][1] += int(lineArr[3])
        weibo[name][2] += int(lineArr[4])
        weibo[name][3] += int(lineArr[5])

    if int(lineArr[3]) + int(lineArr[4]) + int(lineArr[5]) >= 2500:#设置BigV的阈值
        BigV.add(name)

f.close()

MyDic = {}
pkl_file = open('MyDic.pkl', 'rb')
MyDic = pickle.load(pkl_file)
pkl_file.close()

def MyCount(words):
        nums = [0,0,0]
        for word in words:
                if word in MyDic:
                        nums[0] += round(MyDic[word][0]/Total*2000)
                        nums[1] += round(MyDic[word][1]/Total*2000)
                        nums[2] += round(MyDic[word][2]/Total*2000)
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

writefile = codecs.open(r'FinalResult23.txt', 'w', 'utf-8')

weibo_key = weibo.keys()

newpeople = 0

for i in range(linenum):
        if Name[i] in BigV:
                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(round(weibo[Name[i]][1]/weibo[Name[i]][0])) + ','+  str(round(weibo[Name[i]][2]/weibo[Name[i]][0]))+','+  str(round(weibo[Name[i]][3]/weibo[Name[i]][0]))+'\n')
#        elif Name[i] in weibo_key:
#                weibo[name] = Myrandom(weibo[name])
#                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(weibo[Name[i]][1]) + ','+  str(weibo[Name[i]][2])+','+  str(weibo[Name[i]][3])+'\n')
        else:
#                newpeople += 1
                nums = MyCount(Words[i])
                writefile.write(Name[i] + '\t' + Label[i] + '\t' + str(nums[0]) + ',' + str(nums[1]) + ',' + str(nums[2]) + '\n')


writefile.close()

#print(newpeople)

