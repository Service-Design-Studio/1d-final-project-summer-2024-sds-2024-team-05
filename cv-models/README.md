# READ ME

# Local Testing for Patient Sit-Stand Test

## Overview

This guide explains how to test the sit-stand motion of a patient using pose estimation. The process involves analyzing video data to detect body positions and movements that indicate standing from a sitting position.

## Features

1. **Pose Estimation**: Utilizes MediaPipe for identifying key points of the human body necessary for posture analysis.
2. **Video Resizing**: Adjusts MP4 video dimensions to fit on-screen for easier viewing during analysis.
3. **Validation Criteria**: Considers the sit-stand test passed if the patient is recorded standing up in more than 20 frames, which helps ensure the movement isn’t a fluke.
4. **Movement Detection**: Detects a standing motion when the angle between the hip, knee, and foot exceeds 160 degrees.

##Setup Instructions

1. **Video Input**: Under the line cap = cv2.VideoCapture('sit_stand.mp4'), replace 'sit_stand.mp4' with the path to the MP4 file you want to analyze.
2. **Output Configuration**: Under the line output_video = cv2.VideoWriter('sit_stand_final.mp4', cv2.VideoWriter_fourcc(\*'mp4v'), 30, (1280,720)), replace 'sit_stand_final.mp4' with the desired name for the analyzed video output.
3. **Execution**: Run all cells in the Jupyter notebook to perform the analysis.
4. **Results**: The analyzed video will be saved in your specified folder.
