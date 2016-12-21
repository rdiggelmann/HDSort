%%
data = [100 206 823 500;
        100 209 735 600;
        102 201 730 530;
        109 201 704 542;
        103 206 720 502;
        100 209 700 603;
        112 204 705 530;
        109 207 700 540;
        112 204 704 530;
        109 205 700 540;
        109 207 700 540;
        112 204 704 530;
        109 205 700 540;
        ]
%%
P = plot.Boxplot(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'groupnames', {'a', 'b', 'c'}, 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.Boxplot(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'groupnames', {'a', 'b', 'c'})
P = plot.Boxplot(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.Boxplot(data, [3 3 1 1 1 1 1 1 2 3 1 2 3])
%%
data = randn(100, 5);
P = plot.Boxplot(data, [1 2 3 3 2 1 1 1 2 1], 'groupnames', {'a', 'b', 'c'}, 'subgroupnames', {'one', 'two', 'three', 'four', 'five'})
%%
data = randn(100, 4);
groupIdx = randi(3, [1 100]);
P = plot.Boxplot(data, groupIdx, 'groupnames', {'a', 'b', 'c'}, 'subgroupnames', {'one', 'two', 'three', 'four'}, 'displayN', true)
P = plot.Boxplot(data, groupIdx, 'groupnames', {'a', 'b', 'c'}, 'subgroupnames', {'one', 'two', 'three', 'four', 'five'})
P = plot.Boxplot(data, groupIdx, 'groupnames', {'a', 'b'}, 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.Boxplot(data, groupIdx, 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.Boxplot(data, groupIdx, 'displayN', true)
%%
data = randn(100, 1);
groupIdx = randi(4, [1 100]);
P = plot.Boxplot(data, groupIdx, 'displayN', true)
%%
P = plot.Boxplot(data)

%%
P = plot.boxplot_old(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'groupnames', {'a', 'b', 'c'}, 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.boxplot_old(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'groupnames', {'a', 'b', 'c'})
P = plot.boxplot_old(data, [3 3 1 1 1 1 1 1 2 3 1 2 3], 'subgroupnames', {'one', 'two', 'three', 'four'})
P = plot.boxplot_old(data, [3 3 1 1 1 1 1 1 2 3 1 2 3])


