df = readtable('df_4.csv','ReadRowNames',true,'ReadVariableNames',true);
x = [2012 2013 2014 2015 2016 2017 2018 2019 2020 2025]
%x = cell2mat(df.Properties.RowNames)  
arr = table2array(df)
f = figure;
ax = axes(f);
hold(ax,"on")
yyaxis left
c = ['r','m','b']
for i = 1:length(arr(1,:))-1
    plot(ax,x,arr(:,i),'Color',c(i),'LineStyle','-')
end
ylabel(ax,'Emissions-[KTon]')
yyaxis right
plot(ax,x,arr(:,3),'Color',c(3))
ylabel(ax,'Production-[TWh]')
legend(ax,'NO_2','SO_2','Production')
title(ax,'Production VS Emitions')

