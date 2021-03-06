%% ECE310 - Prob & Stoch Project 1
%% Mark Koszykowski, Henry Son, Tamar Bacalu
clear; close all; clc;

%% Epic Question 1
N = 100000;                 % num of tries

% a)
y = sum(randi(6, 3, N));    % 3 rolls of 6 sided dice + sums after N times
p_y18 = p_estimation(y, 18);

% b)
y_f = fun_roll(3, 6, 3, N);
p_f_y18 = p_estimation(y_f, 18);

% c)
p_perfect = char_type_check(18, N);

% d)
p_average = char_type_check(9, N);

%% Epic Question 2
% a) 
troll_hp_avg = mean(get_roll(1, 4, N));
fb_avg = mean(get_roll(2, 2, N));
p_fb3 = sum(get_roll(2, 2, N) > 3) / N;

% b)
SHP = 1:4;
P_HP = find_prob(get_roll(1, 4, N), SHP);
SFd = 2:4;
PFd = find_prob(get_roll(2, 2, N), SFd);

figure;
subplot(2, 1, 1);
stem(SFd, PFd);
title('pmf of the damage of the fireball')
xlabel('Damage (hit points)')
ylabel('Probability')
xticks(2:4)
xlim([1,5])
ylim([0,1])

subplot(2,1,2)
stem(SHP, P_HP)
title('pmf of troll HP')
xlabel('Health Points')
ylabel('Probability')
xticks(1:4)
xlim([0,5])
ylim([0,1])


%% Functions

% takes a vector of simulated data input and finds the probability that
% the input equals x_req
function prob_est = p_estimation(input, x_req)
[N,M] = size(input);
prob_est = sum(input == (ones(N, M) * x_req)) / max(N, M);
end

% rolls a [side_num] die [roll_count] times and take the maximum out of
% [iter] times, repeating for [N] times
function y_f = fun_roll(roll_count, side_num, iter, N)
x = randi(side_num, roll_count, iter, N);
y_f = zeros(N, 1);
y_f(:) = max(sum(x, 2));
end

% counts the num of chars generated by fun_roll() that have ability scores
% equal to ability_score, in N trials, and calculates probability of char
% appearing
function char_prob = char_type_check(ability_score, N)
for i = 1:N
    y_f = fun_roll(3, 6, 3, 6);
    char_count(i) = sum((y_f == ones(6, 1) * ability_score)) == 6;
end
char_prob = sum(char_count) / N;
end

function roll = get_roll(roll_count, side_num, N) 
roll = randi([1, side_num], roll_count, N);
roll = sum(roll, 1);
end
