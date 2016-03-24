# MIT-RedX---Plotting-Area-of-Pupil
Given a video file of the reaction/movement of the the right and left pupil to external  stimulus(light) along with the timestamps of both the videos , plot the area of the right pupil w.r.t  the left one at each instant of the given timestamps.

1. Keep all the Right,Left Videos and Timestamp text files in a single folder named 'Videos'. </br>
2. Create empty folders 'CSV' and 'Plots'. Go to Properties of the folder 'Plots' and disable the 'Read-Only' option->Apply->Ok. </br>
3. Run the main_file_allvideos.m . </br> 
4. It computes Area, State of Light (On or Off) and the Time and saves them as a 3 column vector(in the order as specified 'Area' 'On/Off' 'Time') with the rows corresponding to each frame in the video, in a CSV file for each of the Right and Left Videos. The name of the CSV file is same as that of the video with a .csv extension. All these files get saved in the CSV folder. </br>
5. It also saves the plots with the name same as that of the video with a .jpg extension in the Plots folder. In the Plot </br> X -axis : Time and Y-axis : Area of the pupil </br> Red Color : Area of Right Pupil wrt time </br> Blue Color : Area of Left Pupil wrt time </br> Green Color : Light On/Off for Right Pupil </br> Black Color : Light On/Off for Left Pupil. </br> 
