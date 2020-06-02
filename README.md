# zebrafish-analysis
Dissertation - Is the characterisation of Parkinson’s Disease in humans and zebrafish possible by using evolutionary algorithms?

tailAngle.m plots the tail angles of zebrafish over a period of time, which can be used to identify key movement traits.
Example shown below:

![image of tailAngle results](https://imgur.com/OeR8rAT)



## speedregressionplots

speedregressionplots.m calculates the regression of movement speed of the zebrafish over a period of time, to try and identify
symptoms of the 'Sequence Effect'.

![image of speedregressionplots results](https://i.imgur.com/3HsJZkI.png)

## speedregressionpercentage

Calculates the gradient of the best-fit line from previous plots for all 42 zebrafish datasets, and determines which of Control 
or Parkinsonian zebrafish display more signs of fatigue

## amplituderegressionplots & amplituderegressionpercentage

The same processes as used in the speedregression files, however with the amplitudes of movements instead of speed.

##fishHesitations

fishHesitations performs an algorithm on the movement data of every zebrafish, and determines how many hesitations are present 
in the movements.

##fishFrequency

fishFrequency.m calculates the frequency of the tail beat 

## tailAngle

