clear all;
close all;
g = @(n) n; %Predicted g(n) for Insertion
h = @(n) n; %Predicted g(n) for Removing
i = @(n) n; %Predicted g(n) for Worst case lookup
j = @(n) n; %Predicted g(n) for Random lookup
k = @(n) n; %Predicted g(n) for Skewed lookup

orderpreds = {1,2,3,4,5; g, h, i, j, k};

scriptinput = importdata("input.txt");

tests = zeros(scriptinput(2)*scriptinput(3), 2, 5);
avgs = zeros(scriptinput(2), 2, 5);

for i = 1:5
   tests(:, :, i) = importdata(strcat("split/t", num2str(i), "split.txt"));
   avgs(:, :, i) = importdata(strcat("splitavg/t", num2str(i), "avg.txt"));
end

%Plot avg data from tests.
figure
hold on
for i= 1:5
    plot(avgs(:, 1, i), avgs(:, 2, i)); 
end
title("Complexity of test")
xlabel("Number of elements")
ylabel("Time in ms")
legend("Insert test", "Remove all test", "Non-existent lookup test", "Random lookup test", "Skewed lookup test", 'Location', 'northwest')
hold off

figure
hold on

%Plot avg data from tests divided by amount of elements tested to obtain
%the complexity of the tables operations.
for i = 1:5
    plot(avgs(:, 1, i), avgs(:, 2, i) ./ avgs(:, 1, i)); 
end
title("Complexity for operations")
xlabel("Number of elements")
ylabel("Time in ms")
legend("Insert test", "Remove all test", "Non-existent lookup test", "Random lookup test", "Skewed lookup test", 'Location', 'northwest')
hold off

figure
hold on
for i = 1:5
    t = orderpreds(i);
    plot(avgs(:, 1, i), avgs(:, 2, i) ./ avgs(:, 1, i) ./ avgs(:, 1, i)); 
end
title("Prediction of g(n)")
xlabel("Number of elements")
ylabel("Time in ms / g(n)")
legend("Insert test", "Remove all test", "Non-existent lookup test", "Random lookup test", "Skewed lookup test", 'Location', 'northwestoutside')
hold off

figure
hold on
for i = 1:5
    plot(tests(:, 1, i), tests(:, 2, i) ./ tests(:, 1, i), 'x'); 
end
title("Operation complexities for all runs")
xlabel("Number of elements")
ylabel("Time in ms")
legend("Insert test", "Remove all test", "Non-existent lookup test", "Random lookup test", "Skewed lookup test", 'Location', 'northwest')

