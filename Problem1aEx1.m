%% Problem 1
%% Task a 
% Find the probability pn for each state of the source X Xn (n =1, 2).
% 
% p(x1|x0) = 1/4
% p(x1|x1) = 2/3
% p(x0|x0) = 3/4
% p(x0|x1) = 1/3
%
% p(x1)/p(x0) = p(x1|x0)/p(x0/x1)  (1)
% = (1/4)/(1/3)
% 
% p(x1)/p(x0) = 3/4
%
% p(x0)+p(x1) = 1                   (2)
%
% p(x0)+(3/4)p(x0) = 1
%
% (7/4)p(x0) = 1
%
% p(x0) = 4/7 = 0.571
%
% p(x1) = 1-4/7 = 3/7 = 0.429

%% Task b
% Find entropy H(X)
% H(X) = (4/7)*log2(7/4)+(3/7)*log2(7/3) = 0.985
%% Task c 
% Probability of extended states
% 
% P(x1 x1) = P(x1)*P(x1|x1) = 2/7
% P(x1 x0) = P(x1)*P(x0|x1) = 1/7
% P(x0 x1) = P(x0)*P(x1|x0) = 1/7
% P(x0 x0) = P(x0)*P(x0|x0) = 3/7
%
% Find Huffman code and entropy rate B:
%                /
%              /  \
%        2/7 /  \  3/7
%          /  \  2/7
%       1/7    1/7
%
% Bit encoding
% P(x0 x0) | 1
% P(x1 x1) | 01
% P(x1 x0) | 001
% P(x0 x1) | 000
%
% Entropy: B = (2/7)*log2(3.5)+2*(1/7)*log2(7)+(3/7)*log2(7/3) = 1.842
% Average bit: 0.25*(2+3+3+1) = 2.25
%
% Using extended source compared to two states does not given any gain