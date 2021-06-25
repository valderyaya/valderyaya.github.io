---
title: Codeforces_1430E
katex: true
date: 2021-06-18 13:34:05
categories:
- 题解
tags:
- Codeforces
---

# [CF 1430E String Reversal](https://codeforces.com/contest/1430/problem/E)

### **题意**
给你一个字串A，B是翻转A所得到的字串，问最少需要进行几次交换相邻字元的操作才能使得A变成B

### **输入输出样例**
输入 #1
```
5
aaaza
```
输出 #1
```
2
```
---
输入 #2
```
9
icpcsguru
```
输出 #2
```
30
```

## 解题思路
题目虽然只是求从当前字串到反转之后的最少次数，但是其实只要是同一字串的任意一种排列，都可以求得出来，具体想法如下:

我们先假设原来的字串叫 $a$ ,反转后的字串叫做 $b$ , 我们要构造出一个序列 $c$，$c_i$代表 $a_i$ 移动到 $b$ 时的位置

以**样例一**为例:

字串 $a$ = `"aaaza"`

字串 $b$ = `"azaaa"`

序列 $c$ = $[1,3,4,2,5]$

接下来，因为 $a$ 转到 $b$ 和 $b$ 转到 $a$的次数是一样的，所以我们现在把题目改成要怎么把 $c$ 变回原来的序列(即变回排序好的样子)。

因为我们每次操作只能交换相邻的数字，这不就是把序列用 $Bubble  Sort$ 排好所需要的交换次数吗。 这里有个性质，$Bubble  Sort$ 的交换次数即是**序列的逆序数对个数**，所以我们就只要求出序列 $c$ 的逆序数对就好了。

构造阵列 $c$ 的时候我用一个阵列去记录他的下一个位置，事后看到也有人用`vector`，好像更简单好写，至于求逆序数对的话用BIT，线段树，<del>平衡树</del>都可以，我的code是用BIT

## 程式码
```cpp
#include<bits/stdc++.h>
using namespace std;
typedef long long ll;
#define Rosario ios::sync_with_stdio(0),cin.tie(0),cout.tie(0);
#define lb(x) (x&-x)
 
int nxt[200005],n,a[200005],pos[26],bit[200005];
ll ans;
void add(int x,int v){
    for(;x<=n;x+=lb(x)) bit[x]+=v;
}
int qry(int x){
    int res=0;
    for(;x;x-=lb(x)) res+=bit[x];
    return res;
}
string s,rev;
int main(){
    Rosario
    cin>>n>>s;
    rev=s;
    reverse(rev.begin(),rev.end());
    for(int i=rev.size()-1;~i;--i){
        nxt[i]=pos[rev[i]-'a'];
        pos[rev[i]-'a']=i;
    }
    for(int i=0;i<n;++i){
        a[i]=pos[s[i]-'a']+1;
        pos[s[i]-'a']=nxt[pos[s[i]-'a']];
        ans+=qry(n)-qry(a[i]-1);
        add(a[i],1);
    }
    cout<<ans<<"\n";
    return 0;
}
```