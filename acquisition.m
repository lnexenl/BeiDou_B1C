load("PRNList.mat");
B1C = [];
for i = 1:60
    B1C = [B1C; weil_code_generator(10243, 10230, PRNList(i, 2), PRNList(i, 3))];
end
B1C = kron(B1C, ones(1, 10));
