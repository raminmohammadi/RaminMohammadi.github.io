---
featured_image: '/images/Projects/mlops/24_spring/group_3/thumbnail.webp'
---

# Table of Contents

1. [Introduction]({% link _projects/mlops/2024-01-02-s24-group-3.md %} )<br>
2. [Scoping]( {% link _projects_mlops/24_spring/group_3/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/24_spring/group_3/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/24_spring/group_3/modeling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/24_spring/group_3/deployment.md %} ){:target="_blank"}<br>
6. [Monitoring]( {% link _projects_mlops/24_spring/group_3/monitoring.md %} ){:target="_blank"}<br>

## Dataset Introduction

Our dataset comprises a diverse collection of audio samples sourced from renowned databases like the **Ryerson Audio-Visual Database of Emotional Speech and Song** (RAVDESS), **Toronto Emotional Speech Set** (TESS), **Surrey Audio-Visual Expressed Emotion** (SAVEE), and **Crowd Sourced Emotional Multimodal Actors Dataset** (CREMA-D), augmented with audio features to enhance the model's robustness across various demographics and contexts.

## Data Card

### RAVDESS Dataset

**Ryerson Audio-Visual Database of Emotional Speech and Song** (RAVDESS) Speech audio-only files (16bit, 48kHz .wav) from the RAVDESS. Full dataset of speech and song, audio and video (24.8 GB) available from Zenodo. Construction and perceptual validation of the RAVDESS is described in the author’s Open Access paper in PLoS ONE.

[Link to the Dataset](https://zenodo.org/records/1188976#.XsAXemgzaUk)

Our portion of the RAVDESS dataset contains 1440 files: 60 trials per actor x 24 actors = 1440. The RAVDESS contains 24 professional actors (12 female, 12 male), vocalizing two lexically-matched statements in a neutral North American accent. Speech emotions include calm, happy, sad, angry, fearful, surprise, and disgust expressions. Each expression is produced at two levels of emotional intensity (normal, strong), with an additional neutral expression.

**File naming convention**:

Each of the 1440 files has a unique filename. The filename consists of a 7-part numerical identifier (e.g., 03-01-06-01-02-01-12.wav). These identifiers define the stimulus characteristics:

**Filename identifiers**:

- **Modality** (01 = full-AV, 02 = video-only, 03 = audio-only).
- **Vocal channel** (01 = speech, 02 = song).
- **Emotion** (**01 = neutral, 02 = calm, 03 = happy, 04 = sad, 05 = angry, 06 = fearful, 07 = disgust, 08 = surprised**).
- **Emotional intensity** (01 = normal, 02 = strong). NOTE: There is no strong intensity for the 'neutral' emotion.
- **Statement** (01 = "Kids are talking by the door", 02 = "Dogs are sitting by the door").
- **Repetition** (01 = 1st repetition, 02 = 2nd repetition).
- **Actor** (01 to 24. Odd numbered actors are male, even numbered actors are female).

Filename example: 03-01-06-01-02-01-12.wav
  - Audio-only (03)
  - Speech (01)
  - Fearful (06)
  - Normal intensity (01)
  - Statement "dogs" (02)
  - 1st Repetition (01)
  - 12th Actor (12)
  - Female, as the actor ID number is even.


### TESS Dataset
A study was done to analyze the recognition of emotional speech for a young and an old speaker. The TESS (Toronto Emotional Speech Set) dataset is female only and is of very high-quality audio. For almost 20 hours, each actor individually recorded the stimuli in a sound-attenuating booth. Three female undergraduate students with normal hearing, listened to the recordings and categorized them into one of the seven emotions for each actor. Most of the other dataset is skewed towards male speakers and thus brings about a slightly imbalanced representation, but not this one. Because of that, this dataset would serve a very good training dataset for the emotion classifier in terms of generalization (not overfitting)

[Link to the Dataset](https://tspace.library.utoronto.ca/handle/1807/24487)

There are a set of 200 target words (“stimuli”) were spoken in the carrier phrase "Say the word _____" by two actresses (aged 26 and 64 years) and recordings were made of the set portraying each of seven emotions (**anger, disgust, fear, happiness, pleasant surprise, sadness, and neutral**). There are 2800 data points (audio files) in total.

The dataset is organized such that each of the two female actors and their emotions are contained within its own folder. And within that, all 200 target words audio files can be found. The format of the audio file is a WAV format.

### CREMA-D Dataset
The CREMA-D (Crowd Sourced Emotional Multimodal Actors) [3] dataset is an audio-visual dataset uniquely suited for the study of multi-modal emotion expression and perception, which consists of facial and vocal emotional expressions in sentences spoken in a range of basic emotional states, and can be used to probe other questions concerning the audio-visual perception of emotion. What's interesting is that this dataset is the sheer variety of data which helps train a model that can be generalized across new datasets. Many audio datasets use a limited number of speakers which leads to a lot of information leakage. CREMA-D has many speakers. For this fact, the CREMA-D is a very good dataset to use to ensure the model does not overfit.

[Link to the Dataset](https://github.com/CheyneyComputerScience/CREMA-D)

CREMA-D is a data set of 7,442 original clips from 91 actors. These clips were from 48 male and 43 female actors between the ages of 20 and 74 coming from a variety of races and ethnicities (African American, Asian, Caucasian, Hispanic, and Unspecified). Actors spoke from a selection of 12 sentences. The sentences were presented using one of six different emotions (**Anger, Disgust, Fear, Happy, Neutral, and Sad**) and four different emotion levels (Low, Medium, High, and Unspecified).

### SAVEE Dataset
The SAVEE (Surrey Audio-Visual Expressed Emotion) [4] database was recorded from four native English male speakers (identified as DC, JE, JK, KL), postgraduate students and researchers at the University of Surrey aged from 27 to 31 years. Emotion has been described psychologically in discrete categories: **anger, disgust, fear, happiness, sadness and surprise**. This is supported by the cross-cultural studies of Ekman [5] and studies of automatic emotion recognition tended to focus on recognizing these [6-8]. The authors added neutral to provide recordings of 7 emotion categories. The text material consisted of 15 TIMIT [9] sentences per emotion: 3 common, 2 emotion-specific and 10 generic sentences that were different for each emotion and phonetically-balanced. The 3 common and 2 × 6 = 12 emotion-specific sentences were recorded as neutral to give 30 neutral sentences.


This results in a total of 120 utterances per speaker, for example:
- **Common**: She had your dark suit in greasy wash water all year.
- **Anger**: Who authorized the unlimited expense account?
- **Disgust**: Please take this dirty table cloth to the cleaners for me.
- **Fear**: Call an ambulance for medical assistance.
- **Happiness**: Those musicians harmonize marvelously.
- **Sadness**: The prospect of cutting back spending is an unpleasant one for any governor.
- **Surprise**: The carpet cleaners shampooed our oriental rug.
- **Neutral**: The best way to learn is to solve extra problems.

[Link to the Dataset](http://kahlan.eps.surrey.ac.uk/savee/)

## Data Rights and Privacy
**Data Compliance**: The dataset aligns with General Data Protection Regulation (GDPR), exemplifying adherence to the highest standards of data protection and privacy.

**Privacy Considerations**: Prioritizing privacy, the dataset is anonymization, safeguarding Personally Identifiable Information (PII) information. By meticulously removing personally identifiable details, the dataset ensures the utmost privacy for consumers.

## Data Pipeline Components
The data pipeline for our project comprises several key stages, each crucial for preparing and utilizing the audio data efficiently.

### Data Generation
This initial stage involves the extraction of 1000 new audio files using a metadata file, simulating the availability of new data every unit time period (day/week/month/year). Given our total of 12000 audio files, a pipeline task is created to randomly sample 1000 new files for each new time period in our MLOps pipeline. This ensures a consistent flow of new data for model training and evaluation.

### Data Splitting and Transformation
For each new dataset obtained from the data generation stage, we perform a split to separate the data into training, testing, and validation sets. This step is essential for evaluating the performance of our models. Additionally, we transform the data using the previously discussed techniques, such as extracting **Mel-frequency cepstral coefficients** (MFCC), **Spectrogram**, **Zero Crossing Rate**, **Chromagram**, **Root Mean Square Energy** (RMSE) features. These transformed datasets are then stored as Parquet files in Google Cloud Buckets. This storage approach ensures easy access and scalability, enabling efficient training and evaluation of our SER models.

Overall, this data pipeline is designed to streamline the process of data generation, splitting, and transformation, laying a solid foundation for the machine learning operations of our SER project.
