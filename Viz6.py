import numpy
import pandas as pd
import pygal
import lxml
import cairosvg
import tinycss
import cssselect

df= pd.read_csv('C:/Users/jvjos/Desktop/Tal/לימודים/ויזואליזציה/VisuzliztionProject/df_6.csv', sep = ',', header = None)

radar_chart = pygal.Radar()
radar_chart.title = 'No Supply Minutes Through the Years'
radar_chart.x_labels = ['2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020']
radar_chart.add('Dan', df.iloc[1, :])
radar_chart.add('Hadera',  df.iloc[2, :])
radar_chart.add('Haifa',  df.iloc[3, :])
radar_chart.add('Negev',  df.iloc[4, :])
radar_chart.add('Sharon',  df.iloc[5, :])
radar_chart.add('State Average',  df.iloc[6, :])

radar_chart.render_to_file('C:/Users/jvjos/Desktop/Tal/לימודים/ויזואליזציה/VisuzliztionProject/radar.svg')
