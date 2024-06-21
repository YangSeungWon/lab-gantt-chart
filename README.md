# lab-gantt-chart

This is a fork of the HillLab_gantt_chart repository. The original repository can be found at https://github.com/HillLabSask/HillLab_gantt_chart .

## Changes
- Now build `gantt.info` from a CSV file named `data.csv` instead of hardcoding it in the script.
- Removed day information to simplify the data.
- Changed strings to use variables for easier customization.



## (original) HillLab_gantt_chart
This is some basic R code for making the Hill Lab personnel gantt chart.
We were inspired by https://rpubs.com/mramos/ganttchart

The chart is updated and posted in our lab every year to track the comings and goings of people. 

The R package is plotrix. The plot generated is pretty basic and so we do a little polishing of the PDF result that we print and post on the lab webpage https://research-groups.usask.ca/hilllab/people.php
