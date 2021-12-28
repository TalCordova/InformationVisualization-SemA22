%% Data
Data = readtable("G:\Shared drives\Information Visualization\Files_Netunei_hashmal_doch_reshut_hasmal_2020_data_n.xlsx",'Sheet', 'ייצור מתחדשות וקרינה סולרית', 'Range','A1:F26304', 'ReadVariableNames', true);

%% Visualization 3

DataViz3 = Data;
Time = DataViz3{:,3};
Time.Format = 'HH:mm:ss';
DataViz3 = removevars(DataViz3, 'Time');
DataViz3 = addvars(DataViz3,Time, 'Before', 'GHI');
TimeStrings = DataViz3.Time;
TimeStrings.Format = 'HH:mm:ss';
TimeStrings = string(TimeStrings);
DataViz3 = addvars(DataViz3,TimeStrings, 'Before', 'GHI');
DataViz3(ismember(DataViz3.Month,[2 3 5 6 8 9 11 12]),:) = [];
DataViz3(ismember(DataViz3.TimeStrings, ["00:00:00" "01:00:00" "02:00:00" "03:00:00" "04:00:00" "05:00:00" "06:00:00" "19:00:00" "20:00:00" "21:00:00" "22:00:00" "23:00:00"]),:) = [];
%% 
MonthNames = ["January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"];
t = tiledlayout(2,2);
title(t,'Solar Irradiance and Electricty From Renewable Energies - 7:00 - 18:00','FontWeight','bold', 'FontSize', 24)
for i=1:3:12
    nexttile
    idx = (DataViz3.('Month') == i);
    temp = DataViz3(idx,:);
    x = temp{:,5};
    y = temp{:,6};
    g = temp{:,1};
    trend1 = temp;
    trend1(ismember(trend1.Year, [2019 2020]),:) = [];
    a1 = polyfit(trend1{:,5},trend1{:,6},1);
    A1 = polyval(a1,trend1{:,5});
    trend2 = temp;
    trend2(ismember(trend2.Year, [2018 2020]),:) = [];
    a2 = polyfit(trend2{:,5},trend2{:,6},1);
    A2 = polyval(a2,trend2{:,5});
    trend3 = temp;
    trend3(ismember(trend3.Year, [2018 2019]),:) = [];
    a3 = polyfit(trend3{:,5},trend3{:,6},1);
    A3 = polyval(a3,trend3{:,5});
    gscatter(x,y,g, 'rgb');
    hold on
    plot(mean(trend1{:,5}), mean(trend1{:,6}), 'p', 'MarkerSize', 20, 'MarkerFaceColor', 'r', 'MarkeredgeColor', 'k')
    plot(mean(trend2{:,5}), mean(trend2{:,6}), 'p', 'MarkerSize', 20, 'MarkerFaceColor', 'g', 'MarkeredgeColor', 'k')
    plot(mean(trend3{:,5}), mean(trend3{:,6}), 'p', 'MarkerSize', 20, 'MarkerFaceColor', 'b', 'MarkeredgeColor', 'k')
    title(MonthNames(i), 'FontSize', 16);
    xlabel('Global Horizontal Irradiance (WH\m^2)', 'FontSize', 14);
    ylabel('Electricity From Renewable Energies', 'FontSize', 14);
    legend('2018', '2019', '2020', 'FontSize', 12);
    ylim([0 2000]);
end    
    


%% Parallel Graph

ParallelData = readtable("G:\Shared drives\Information Visualization\Files_Netunei_hashmal_doch_reshut_hasmal_2020_data_n.xlsx",'Sheet', '3.5 שעות יצור מצטברות לפי דלק', 'Range','A6:M8788', 'ReadVariableNames', false);
ParallelData.Properties.VariableNames = {'Day', 'Month', 'Time', 'Hour Of Year', 'Total Manufacturing (MwH)', 'Coal (MwH)', 'Gas (MwH)', 'Renewable (MwH)', 'Other (MwH)', 'Percentage Of Natural Gas', 'GHI (Wh/m^2)', 'Air Temperature (C)', 'Wind Speed (m\sec)'};
Time = ParallelData{:,3};
Time.Format = 'HH:mm:ss';
ParallelData = removevars(ParallelData, 'Time');
ParallelData = addvars(ParallelData,Time, 'Before', 'Hour Of Year');
TimeStrings = ParallelData.Time;
TimeStrings.Format = 'HH:mm:ss';
TimeStrings = string(TimeStrings);
ParallelData = addvars(ParallelData,TimeStrings, 'Before', 'Hour Of Year');
Day = ParallelData{:,1};
Day.Format = 'yyyy-MM-dd';
DayStrings = ParallelData.Day;
DayStrings.Format = 'yyyy-MM-dd';
DayStrings = string(DayStrings);
ParallelData = removevars(ParallelData, 'Day');
ParallelData = addvars(ParallelData,Day, 'Before', 'Month');
ParallelData = addvars(ParallelData,DayStrings, 'Before', 'Month');
g = findgroups(ParallelData.DayStrings);
DailyDataRenewableManufacturing = splitapply(@mean, ParallelData.('Renewable (MwH)'),g);
DailyGHI = splitapply(@mean, ParallelData.('GHI (Wh/m^2)'),g);
DailyAirTemperatue = splitapply(@mean, ParallelData.('Air Temperature (C)'),g);
DailyWindSpeed = splitapply(@mean, ParallelData.('Wind Speed (m\sec)'),g);

DailyData = [DailyDataRenewableManufacturing DailyGHI DailyAirTemperatue DailyWindSpeed];

for i=1:size(DailyData,1)
    if(i >=1 && i<=31)
        DailyData(i,5) = 1;
    elseif(i>=32 && i<=61)
        DailyData(i,5) = 2;
    elseif(i>=62 && i<=93)
        DailyData(i,5) = 3;
    elseif(i>=94 && i<=124)
        DailyData(i,5) = 4;
    elseif(i>=125 && i<=146)
        DailyData(i,5) = 5;
    elseif(i>=147 && i<=177)
        DailyData(i,5) = 6;
    elseif(i>=178 && i<=209)
        DailyData(i,5) = 7;
    elseif(i>=209 && i<=240)
        DailyData(i,5) = 8;
    elseif(i>=241 && i<=271)
        DailyData(i,5) = 9;
    elseif(i>=272 && i<=303)
        DailyData(i,5) = 10; 
    elseif(i>=303 && i<=333)
        DailyData(i,5) = 11;
    else
       DailyData(i,5) = 12; 
    end
end
DailyData(DailyData(:, 5)~= 1 & DailyData(:, 5)~= 4 & DailyData(:, 5)~= 7 & DailyData(:, 5)~= 10, :) = [];
Months = DailyData(:,5);
DailyData = normalize(DailyData, 'range');
DailyData(:,5) = [];
Lables = {'Electricity Manufacturing \newline From Renewable Sources', 'GHI', 'Air Temperature', 'Wind Speed'};
parallelcoords(DailyData, 'Group', Months, 'Labels', Lables, 'quantile', 0.25, 'LineWidth', 2);
title('Meteoroligical Data and Electriciy Manufacturing', 'FontSize', 24);


%% Box - Plot

DataViz4 = Data;
DataViz4(ismember(DataViz4.Year, [2018 2020]), :) = [];
ranges = zeros(1, 12);
for i = 1:12
    temp = DataViz4;
    temp = temp(temp.Month == i,:);
    ranges(i) = range(temp{:,6});
end 
averages = zeros(1,12);
for i = 1:12
    temp = DataViz4;
    temp = temp(temp.Month == i,:);
    averages(i) = mean(temp{:,6});
end 
b = boxchart(DataViz4{:,2},DataViz4{:,6}, 'BoxFaceColor', '#2c7fb8');
title('Electricity Manufacturing Monthly Distribution - 2019', 'FontSize', 24);
xticks([1 2 3 4 5 6 7 8 9 10 11 12])
xticklabels({'January','February','March','April','May','June','July', 'August', 'September', 'October', 'November', 'December'})
xlabel('Months', 'FontSize', 16);
ylabel('Electricity Manufacturing - MWH', 'FontSize', 16);
for i = 1:12
    label = string(round(ranges(i), 0));
    text(i, 13500, label, 'HorizontalAlignment','center','VerticalAlignment','bottom', 'FontSize', 12, 'fontweight', 'bold');
end
hold on
plot(averages, 'LineWidth', 2);
hold off
legend('','Monthly Manufacturing Averages', 'FontSize', 12);

%% 
DataViz5 = readtable("G:\Shared drives\Information Visualization\Files_Netunei_hashmal_doch_reshut_hasmal_2020_data_n.xlsx",'Sheet', '3.5 שעות יצור מצטברות לפי דלק', 'Range','A5:I8788', 'ReadVariableNames', false);
DataViz5.Properties.VariableNames = {'Day', 'Month', 'Time', 'Hour Of Year', 'Total Manufacturing (MwH)', 'Coal (MwH)', 'Gas (MwH)', 'Renewable (MwH)', 'Other (MwH)'};
g = findgroups(DataViz5.Month);
y1 = splitapply(@mean, DataViz5.('Coal (MwH)'),g);
y2 = splitapply(@mean, DataViz5.('Gas (MwH)'),g);
y3 = splitapply(@mean, DataViz5.('Renewable (MwH)'),g);
y4 = splitapply(@mean, DataViz5.('Other (MwH)'),g);
MonthNames = {'January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December' 'Average'};

Sources = [y1 y2 y3 y4];
avg = mean(Sources, 1);
Sources = [Sources; avg];
Sources = array2table(Sources);
Sources.Properties.RowNames = MonthNames';
diff = Sources{:, 1} - Sources{'Average', 1};
Sources


for i = 1:4
    nexttile
    avg = mean(Sources(:,i));
    diff = Sources(:,i)-avg;
    
end    
    

%% Old Graphs

x = Data{:,2};
y = Data{:,3};
g = Data{:,1};

gscatter(x,y,g);
title('Solar Irradiance Compared with Renewable Electricity Mnaufacturing', 'FontSize', 24);
ylabel('Electricity Manufacturing (MwH)', 'FontSize', 20);
xlabel('Global Horizontal Irradiance (Wh\M^2)', 'FontSize', 20);
legend('2018', '2019','2020','FontSize',12);


