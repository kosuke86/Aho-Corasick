/*
   goto_function
   failure_function
   output_function
   を生成する用のプログラム
*/

using namespace std;
#include <algorithm>
#include <iostream>
#include <iterator>
#include <numeric>
#include <sstream>
#include <fstream>
#include <cassert>
#include <climits>
#include <cstdlib>
#include <cstring>
#include <string>
#include <cstdio>
#include <vector>
#include <cmath>
#include <queue>
#include <deque>
#include <stack>
#include <list>
#include <map>
#include <set>
#include <sys/time.h>//実行時間
#include <sys/resource.h>//実行時間

int gettimeofday(struct timeval *tv, struct timezone *tz);
int settimeofday(const struct timeval *tv, const struct timezone *tz);
struct timeval tv,tv1,tz,tz1;
int getrusage(int who, struct rusage *usage);
int state_cnt=0;
int trans_cnt=0;

#define foreach(x, v) for (typeof (v).begin() x=(v).begin(); x !=(v).end(); ++x)
#define For(i, a, b) for (int i=(a); i<(b); ++i)
#define D(x) cout << #x " is " << x << endl
 
const int MAXS = 6 * 50 + 10; // Max number of states in the matching machine.
// Should be equal to the sum of the length of all keywords.
 
const int MAXC = 26; // Number of characters in the alphabet.

int out[MAXS]; // Output for each state, as a bitwise mask.
int f[MAXS]; // Failure function
int g[MAXS][MAXC]; // Goto function, or -1 if fail.
vector<unsigned int> state_gotoFunction;//gotoFunctionを表示するための箱
vector<unsigned int> nextstate_gotoFunction;//gotoFunctionを表示するための箱
vector<unsigned char> trans_gotoFunction;//gotoFunctionを表示するための箱

int buildMatchingMachine(const vector<string> &words, char lowestChar = 'a',
        char highestChar = 'z')

{   

    memset(out, 0, sizeof out);//memset(void *str, int chr, size_t len) 戻り値:strの先頭アドレスを返す。
    memset(f, -1, sizeof f);//memset(void *str, int chr, size_t len) 戻り値:strの先頭アドレスを返す。
    memset(g, -1, sizeof g);//memset(void *str, int chr, size_t len) 戻り値:strの先頭アドレスを返す。
    
    int states = 1; // Initially, we just have the 0 state
    for (int i = 0; i < words.size(); ++i)
    {
        const string &keyword = words[i];//word[0]=ab word[1]=bc
        int currentState = 0;
        for (int j = 0; j < keyword.size(); ++j)
        {
            //keyword[0]=各wordの先頭,c=textの文字を任意に振り分けてる→a=0,b=1,c=2,d=3,e=4
            int c = keyword[j] - lowestChar;
            if (g[currentState][c] == -1)
            { // Allocate a new node
                g[currentState][c] = states++;
            }
           
            //character to state number (goto function)のデータを入れる
            trans_gotoFunction.push_back(keyword[j]);
           // goto_Function.push_back(make_pair(g[currentState][c], keyword[j]));//test
            state_gotoFunction.push_back(currentState);
            currentState = g[currentState][c];
            nextstate_gotoFunction.push_back(currentState);
        }
        out[currentState] |= (1 << i); // There's a match of keywords[i] at node currentState.


    }
    // State 0 should have an outgoing edge for all characters.
    for (int c = 0; c < MAXC; ++c)
    {
        if (g[0][c] == -1)
        {
            g[0][c] = 0;
        }
    }
 
    // Now, let's build the failure function
    queue<int> q;
    for (int c = 0; c <= highestChar - lowestChar; ++c)
    { // Iterate over every possible input
    // All nodes s of depth 1 have f[s] = 0
        if (g[0][c] != -1 and g[0][c] != 0)
        {
            f[g[0][c]] = 0;
            q.push(g[0][c]);
        }
    }
    while (q.size())
    {
        int state = q.front();
        q.pop();
        for (int c = 0; c <= highestChar - lowestChar; ++c)
        {
            if (g[state][c] != -1)
            {
                int failure = f[state];
                while (g[failure][c] == -1)
                {
                    failure = f[failure];
                }
                failure = g[failure][c];
                f[g[state][c]] = failure;
                out[g[state][c]] |= out[failure]; // Merge out values
                q.push(g[state][c]);
            }
        }
    }
 
    
    return states;//states=textの文字数と同じ
}
int findNextState(int currentState, char nextInput, char lowestChar = 'a')
{
    int answer = currentState;
    int c = nextInput - lowestChar;
    while (g[answer][c] == -1)
        answer = f[answer];
    return g[answer][c];
}

int main()
{
    struct rusage t;
    gettimeofday(&tv,NULL);
    vector<string> keywords;
    keywords.push_back("ab");
    keywords.push_back("bc");
    keywords.push_back("bab");
    keywords.push_back("d");
    keywords.push_back("abcde");
    string text = "xbabcdex";
    buildMatchingMachine(keywords, 'a', 'z');
    int max_state = *max_element(nextstate_gotoFunction.begin(), nextstate_gotoFunction.end());
    int currentState = 0;
/*
    for (int i = 0; i < text.size(); ++i)
    {
        currentState = findNextState(currentState, text[i], 'a');
        if (out[currentState] == 0)
            continue; // Nothing new, let's move on to the next character.
        for (int j = 0; j < keywords.size(); ++j)
        {
            if (out[currentState] & (1 << j))
            { // Matched keywords[j]
                cout << "Keyword " << keywords[j] << " appears from " << i
                        - keywords[j].size() + 1 << " to " << i << endl;
            }
        }
       
    }
   */

    cout << "-----------goto function-----------" << endl;
    vector<unsigned int>::iterator state_show = state_gotoFunction.begin();
    vector<unsigned int>::iterator nextstate_show = nextstate_gotoFunction.begin();
    vector<unsigned char>::iterator trans_show = trans_gotoFunction.begin();
    for(; trans_show < trans_gotoFunction.end(); trans_show++){
      cout << *state_show << endl;
      cout << *trans_show << endl;
      cout << *nextstate_show << endl;
      state_show++;
      nextstate_show++;
    }   
/*    
    cout << "-----------failure function-----------" << endl;
    for (int b = 1; b < max_state + 1; b++)
      cout << "f(" << b << ")=" << f[b] << endl;   
*/
    cout << "-----------failure function-----------" << endl;
    for (int b = 1; b < max_state + 1; b++){
      cout <<  b << endl;
    }
    for (int b = 1; b < max_state + 1; b++){
      cout << f[b] << endl;
    }
    
   
    cout << "-----------output function-----------" << endl;
    for (int a = 1; a < max_state + 1; a++)
    {
      if ( out[a] != 0)
      cout << a << endl;
    }
 
    gettimeofday(&tz,NULL);
    printf("time = %f秒\n",(tz.tv_sec - tv.tv_sec)+(tz.tv_usec - tv.tv_usec)*1.0E-6);
    getrusage(RUSAGE_SELF ,&t);
    printf("memory = %ld\n", t.ru_maxrss); 
    return 0;
}
