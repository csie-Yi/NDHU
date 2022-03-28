#include <bits/stdc++.h>
using namespace std;
void Print(vector<int> A)
{
    for (auto x : A)
        cout << x << ' ';
    cout << endl;
}
int H(vector<int> A, int x, int l, int r)
{
    while (l <= r)
    {
        int m = (l + r) / 2;
        if (A[m] < x)
            l = m + 1;
        else
            r = m - 1;
    }
    return l;
}
pair<int, vector<int>> F(vector<int> A, int j)
{
    vector<int> dp;
    if (A.empty())
        return make_pair(0, dp);
    vector<int> g(j, 1);
    for (int i = 0; i < j; i++)
    {
        int idx = H(dp, A[i], 0, dp.size() - 1) + 1;
        if (idx - 1 == dp.size())
        {
            dp.push_back(A[i]);
            g[i] = dp.size();
        }
        else
        {
            dp[idx - 1] = A[i];
            g[i] = idx;
        }
    }
    cout << "g(i) : ";
    Print(g);
    return make_pair(dp.size(), g);
}

vector<int> reF_v1(vector<int> g, vector<int> A, int n)
{
    int max = 0, idx = 0;
    vector<int> ans;
    int i = 0;
    for (; i < n; i++) // find max lengh
        if (g[i] >= max)
        {
            max = g[i];
            idx = i;
        }
    ans.push_back(A[idx]);
    while (1)
    {
        max--;
        if (max == 0)
            break;
        int temp = 0, tempidx;
        for (int j = 0; j < idx; j++)
        {
            if (A[j] >= A[idx])
                continue;
            if (g[j] == max)
            {
                temp = A[j];
                tempidx = j;
            }
        }
        ans.push_back(temp);
        idx = tempidx;
    }
    return ans;
}
vector<int> reF_v2(vector<int> dp, vector<int> A, int x, int len)
{
    vector<int> ans;
    int l = 0;
    int i = 0;
    while (len > 0)
    {
        int idx = H(dp, len, l, x);
        if (!ans.empty())
            if (A[idx] >= ans[i - 1])
            {

                l++;
                continue;
            }
        ans.push_back(A[idx]);
        len--;
        i++;
        x = idx;
    }
    return ans;
}
int main()
{
    vector<int> A = {10, 9, 2, 5, 3, 7, 101, 18, 8};
    cout << "A[] : ";
    Print(A);
    pair<int, vector<int>> p = F(A, A.size());
    vector<int> v1 = reF_v1(p.second, A, A.size());
    vector<int> v2 = reF_v2(p.second, A, A.size(), p.first);
    sort(begin(v1), end(v1));
    sort(begin(v2), end(v2));
    cout << "Reconstruct F(i)_v1 : ";
    Print(v1);
    cout << "Reconstruct F(i)_v2 : ";
    Print(v2);
}
