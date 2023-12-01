---
title: Time-Series Outlier Detection
subtitle: by Sai Revanth
date: 2022-02-14 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: Sai Revanth
categories: ml
---

### 1. Statistical Methods: Z-Score

_Application and Theory_

The Z-Score method works by identifying time points in a time series that deviate significantly from the estimated mean and standard deviation over a historical period. This method is a statistical technique used across various fields like finance, meteorology, and healthcare. 
The formula for the Z-Score is 

$$ Z = { X - \mu  \over \sigma} $$

where X is the data point, $\mu$ the mean, and $\sigma$ the standard deviation.


_Drawbacks and Mitigation_

While simple and widely applicable, the Z-Score method can be overly sensitive to extreme values, especially in datasets with non-Gaussian distributions. Since time series data often violates the assumption of normality, the estimates can be sensitive to anomalies themselves. Using robust statistical estimators like median, interquartile range especially in skewed distributions is advised, which provides more reliable measures of central tendency and dispersion for temporal data. A benefit of the simplified thresholding approach is that Z-Scores are computationally inexpensive to apply even on high frequency streaming data.


_Real-World Scenario:_

In stock market analysis, Z-Score can identify stocks with unusual price movements. For instance, a stock with a Z-Score beyond +3 or -3 could indicate significant deviation from typical market behavior, prompting further investigation into causes like market news or company-specific events.

_Code Implementation_

```python
import pandas as pd
data = pd.Series([...])
outliers = data[abs(data - data.mean()) > 2 * data.std()]
```

<!-- Image for Z-score -->
<img src="/images/Posts/Time_Series_Outlier_Detection/Z-score.webp">
<div align="center">Figure: Z-score</div>

### 2. Moving Average Analysis: Simple Moving Average (SMA)

_Application and Theory_

Simple moving averages provide a straightforward way to smooth short-term fluctuations in time series and uncover longer-term trends. By taking unweighted averages across rolling windows of data points over time, SMAs can indicate deviations from the recent local trend.

SMA is frequently used in time-series data analysis, especially in stock trading and meteorological data. It smoothens the time-series data by averaging data points over a specific window. The formula is  

$$ SMA = { {\sum_{i=1}^N X_i }\over N } $$

where N is the window size.

_Drawbacks and Mitigation_

A key limitation of the Simple Moving Average (SMA) is its lagging performance in volatile datasets, as it fails to swiftly detect abrupt anomalies. By equally weighting all data points in the window, SMAs display reduced sensitivity to current irregularities compared to Exponential Moving Averages (EMAs). While expanding SMA timeframes can dynamically track baseline shifts, accuracy deteriorates over extensive periods as outdated information persists. 

To counteract this lag, EMAs emphasize the most recent values via exponential weighting factors. This weighting scheme enables quicker responses to emerging development in the time series data.

Real-World Scenario: Meteorology
Meteorologists use SMA to track temperature trends. An unusually hot day in a temperate climate, significantly deviating from a 30-day SMA, could signal an extreme weather event, prompting alerts and further climatic analysis.

_Code Implementation_

```python
rolling_mean = data.rolling(window=7).mean()
deviation = abs(data - rolling_mean)
outliers = data[deviation > 2 * data.std()]
```

<!-- Image for SMA -->
<img src="/images/Posts/Time_Series_Outlier_Detection/Moving Average.webp">
<div align="center">Figure: Moving Average</div>

### 3. Machine Learning Methods: Isolation Forest

_Application and Theory_

Isolation Forest is an innovative machine learning method extensively used in anomaly detection, notably in fraud detection and network security. Unlike many other techniques, it isolates anomalies instead of modeling the normal points. This algorithm isolates anomalous time points by directly partitioning the data stream using an ensemble of random isolation trees. Since anomalies are few and distinct, they get segregated in just a few partitions compared to normal points.

_Drawbacks and Mitigation_

A significant limitation of Isolation Forest is its struggle with high-dimensional data, and parameter tuning can be complex. Dimensionality reduction techniques like PCA (Principal Component Analysis) can be employed to address high dimensionality. Careful cross-validation can help in fine-tuning the parameters.

_Real-World Scenario: Banking and Fraud Detection_

In banking, Isolation Forest is adept at identifying unusual transaction patterns. For example, a series of high-value transactions in a short period, which deviate from a customer's usual transaction behavior, can be flagged for further investigation as potential fraud.

_Code Implementation_

```python
from sklearn.ensemble import IsolationForest
model = IsolationForest(n_estimators=100)
model.fit(data.reshape(-1, 1))
scores = model.decision_function(data.reshape(-1, 1))
outliers = data[scores < -0.2]
```

<!-- Image for Isolation Forest -->
<img src="/images/Posts/Time_Series_Outlier_Detection/Anomaly-Detection-Isolation-Forest.webp">
<div align="center">Figure: Isolation Forest</div>

### 4. STL Decomposition and LOESS

_Application and Theory_

STL (Seasonal and Trend decomposition using Loess) is a robust method used in analyzing time-series data with strong seasonal components, such as economic data or environmental measurements. STL decomposition relies on LOESS locally weighted smoothing to extract seasonal, trend and residual components from a time series while modeling residuals. Anomalies are often found in the residual component, which represents the part of the data that cannot be explained by seasonal and trend components.

_Drawbacks and Mitigation_

STL may not handle abrupt, non-seasonal changes effectively. To address this, combining STL with other anomaly detection methods, like statistical thresholding on the residuals, can improve its sensitivity to abrupt changes.

_Real-World Scenario: Environmental Data Analysis_

In environmental monitoring, STL can help in identifying unusual changes in air quality or temperature, which are not part of regular seasonal patterns. For example, a sudden spike in air pollutants in a city could be an indicator of an industrial accident or a significant change in environmental policy.

```python
import statsmodels.api as sm

# Perform seasonal decomposition
decomposition = sm.tsa.seasonal_decompose(data, model='additive')

# Plot the decomposition
decomposition.plot()
```

As for the threshold function you can use z-score method defined above.


<!-- Image for STL Decomposition and LOESS -->
<img src="/images/Posts/Time_Series_Outlier_Detection/STL.webp">
<div align="center">Figure: STL</div>

### 5. Seasonal ESD (S-ESD)

_Application and Theory_

The algorithm uses the Extreme Studentized Deviate test to calculate the anomalies. In fact, the novelty doesn't come in the fact that ESD is used, but rather on what it is tested.

The problem with the ESD test on its own is that it assumes a normal data distribution, while real world data can have a multimodal distribution. To circumvent this, STL decomposition is used. Any time series can be decomposed with STL decomposition into a seasonal, trend, and residual component. The key is that the residual has a unimodal distribution that ESD can test.

However, there is still the problem that extreme, spurious anomalies can corrupt the residual component. To fix it, the paper proposes to use the median to represent the "stable" trend, instead of the trend found by means of STL decomposition.

Finally, for data sets that have a high percentage of anomalies, the research papers proposes to use the median and Median Absolute Deviate (MAD) instead of the mean and standard deviation to compute the zscore. Using MAD enables a more consistent measure of central tendency of a time series with a high percentage of anomalies.

_Drawbacks and Mitigation_

The complexity of understanding and implementing S-ESD can be challenging. Familiarity with the data’s seasonal patterns is crucial. Pre-processing steps like detrending or deseasonalizing the data can help simplify the analysis and improve the method's effectiveness.

_Real-World Scenario: Retail Sales Analysis_

In retail, S-ESD can detect unusual sales patterns. For instance, an unexpected spike in sales on a non-holiday weekday might indicate a successful marketing campaign or a data entry error, warranting further investigation.

Resourses:
[Python module](https://pypi.org/project/sesd/)
[Research paper](https://arxiv.org/pdf/1704.07706.pdf)

_Code Implementation_

```python
import numpy as np
# Install the below package
import sesd 
ts = np.random.random(100)
# Introduce artificial anomalies
ts[14] = 9
ts[83] = 10
outliers_indices = sesd.seasonal_esd(ts, hybrid=True, max_anomalies=2)
for idx in outliers_indices:
    print(f'Anomaly index: {idx}, anomaly value: {ts[idx]}')
```

<!-- Image for Isolation Forest -->
<img src="/images/Posts/Time_Series_Outlier_Detection/S-ESD.webp">
<div align="center">Figure: S-ESD</div>

### 6. LSTM-based Autoencoder

_Application and Theory_

LSTM-based Autoencoders are a deep learning approach, widely used in complex time-series data like IoT sensor data and patient monitoring systems. They employ Long Short-Term Memory (LSTM) networks, a type of recurrent neural network, to learn the normal pattern of the time-series data. Anomalies are detected based on the reconstruction error — the difference between the input and the output of the autoencoder which is often large.

_Drawbacks and Mitigation_

These models require substantial data for training and significant computational resources. To address these challenges, one can use transfer learning, where a model is pre-trained on a large dataset and fine-tuned with specific data. Additionally, cloud-based computing resources can be leveraged to manage computational demands.

_Real-World Scenario: Health Monitoring_

In healthcare, LSTM Autoencoders can monitor patients' vital signs. Anomalies in heart rate or blood pressure readings, differing significantly from the patient's usual patterns, could indicate urgent medical conditions requiring immediate attention.

_Code Implementation_
```python
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, RepeatVector, TimeDistributed, Dense

def create_autoencoder_model(input_shape, encoder_units, decoder_units):
    """Build LSTM Autoencoder model."""
    model = Sequential([
        LSTM(encoder_units, activation='relu', return_sequences=True, input_shape=input_shape),
        LSTM(decoder_units, activation='relu'),
        RepeatVector(input_shape[0]),
        LSTM(decoder_units, activation='relu', return_sequences=True),
        LSTM(encoder_units, activation='relu', return_sequences=True),
        TimeDistributed(Dense(input_shape[1]))
    ])

    model.compile(optimizer='adam', loss='mse')
    return model
```

After that train the model and make predictions on test data then define your own error and threshold function to flag any anamolies, for example i have created a function to use MSE.

```python
def calculate_error(test_data, predictions):
    """Calculate mean squared error between test data and predictions."""
    print("test_data shape", test_data.shape)
    print("predictions shape", predictions.shape)
    mse = np.mean(np.power(test_data - predictions, 2), axis=1)
    return mse
```

As for the threshold function you can use z-score method defined above.


<!-- Image for LSTM-based Autoencoder -->
<img src="/images/Posts/Time_Series_Outlier_Detection/LSTM-Autoencoder.webp">
<div align="center">Figure: Auto-Encoder</div>

### 7. Wavelet-based Anomaly Detection

_Application and Theory_

Wavelet-based methods are particularly useful in signal processing and financial time-series analysis. They involve decomposing the time-series data into wavelets which are small waves that can capture both frequency and location in time. This method is adept at identifying anomalies at various frequency levels, which is crucial in signal processing and financial data.

_Drawbacks and Mitigation_

The primary challenge with wavelet-based methods is their complexity and the expertise required in signal processing. A possible mitigation strategy is to use automated wavelet selection tools and libraries that simplify the process of wavelet transformation.

_Real-World Scenario: Stock Market Analysis_

In finance, wavelet-based anomaly detection can be used to spot unusual stock market activity. For instance, irregularities in the high-frequency components of stock price movements might indicate algorithmic trading anomalies or market manipulation.


_Code Implementation_

```python
import pywt
wavelet_coefficients = pywt.wavedec(data, 'haar')
```

As for the threshold function you can use z-score method defined above.

<!-- Image for Wavelet-based Anomaly Detection 
![alt text](.\Pics/STL.png)
-->

### 8. ARIMA-based Outlier Detection

_Application and Theory_

ARIMA (AutoRegressive Integrated Moving Average) models are a staple in the field of time-series analysis, especially in economic and financial forecasting. They are designed to describe autocorrelations in time-series data. ARIMA models the data as a linear function of its past values (autoregressive part), the past error terms (moving average part), and integrates the need to difference data in case of non-stationarity.

_Drawbacks and Mitigation_

The primary challenge with ARIMA is its reliance on data being stationary and the complexity in selecting the right model parameters (p, d, q). Augmented Dickey-Fuller tests can be used to check for stationarity, and tools like auto_arima in Python can automate the process of parameter selection.

_Real-World Scenario: Economic Forecasting_

In economics, ARIMA can be used to forecast key indicators like GDP growth or unemployment rates. Anomalies in these forecasts, such as unexpected drops or spikes, could indicate significant economic events, prompting policymakers and analysts to investigate further.

_Code Implementation_

```python
from statsmodels.tsa.arima_model import ARIMA

arima_model = ARIMA(data, order=(p, d, q))
model_fit = arima_model.fit(disp=0)
residuals = model_fit.resid
```


<!-- Image for ARIMA-based Outlier Detection -->
<img src="/images/Posts/Time_Series_Outlier_Detection/LSTM-Autoencoder.webp">
<div align="center">Figure: ARIMA</div>

### 9. Deep Learning: Convolutional Neural Networks (CNN)

_Application and Theory_

Convolutional Neural Networks (CNNs), commonly associated with image processing, are increasingly being applied to time-series data for complex pattern recognition tasks. CNNs can process time-series data by treating it similarly to an image, extracting features through convolutional layers, and identifying unusual patterns. This data driven feature extraction combined with classification contrasts reconstruction error based approaches till now we have discussed.

_Drawbacks and Mitigation_

CNNs require large datasets for training and significant computational resources. Using pre-trained models and employing techniques like data augmentation can help in scenarios with limited data. Cloud computing platforms can provide the necessary computational power. And also we should monitor for concept drift to keep model performance from deteriorating.

_Real-World Scenario: Biometric Security Systems_

In security systems, CNNs can analyze biometric data patterns, such as fingerprints or facial recognition data. Anomalies detected by CNNs might indicate fraudulent attempts at access, prompting security alerts.


_Code Implementation_

```python
from keras.models import Sequential
from keras.layers import Conv1D, MaxPooling1D, Flatten, Dense

model = Sequential()
model.add(Conv1D(filters=64, kernel_size=2, activation='relu', input_shape=(n_steps, n_features)))
model.add(MaxPooling1D(pool_size=2))
model.add(Flatten())
model.add(Dense(50, activation='relu'))
model.add(Dense(1))

model.compile(optimizer='adam', loss='mse')
```

Resourses:
[Research paper](https://arxiv.org/pdf/1905.13628.pdf)

<!-- Image for Deep Learning: Convolutional Neural Networks (CNN) 
![alt text](.\Pics/ARIMA.png)
-->

### 10. Change Point Detection

_Application and Theory_

Change point detection is used to identify points in time where the statistical properties of a time-series change significantly. This method is crucial in domains like climate monitoring, where it's important to detect shifts in environmental conditions, and in quality control, to identify shifts in manufacturing processes.

_Drawbacks and Mitigation_

One challenge with change point detection is distinguishing between actual change points and random fluctuations. Combining this method with other statistical tests or using Bayesian approaches can improve accuracy in distinguishing true change points from noise.

Real-World Scenario: Climate Monitoring
In climate data analysis, change point detection can identify shifts in temperature trends, signaling potential climate change events. Detecting these change points can be crucial for initiating environmental policy changes.

There are numeerous algorithms using which we can perform this analysis, below shown is using Bayesian changepoint algorithm.

_Resourses:_
[Python Module](https://pypi.org/project/bayesian-changepoint-detection/)
[Python Module](https://pypi.org/project/Rbeast/)

### 11.  Robust Random Cut Forest (RRCF)

_Application and Theory_

The Robust Random Cut Forest (RRCF) algorithm is a relatively new method, particularly effective for real-time anomaly detection in streaming data, such as financial transactions or IoT sensor data. It constructs a collection of decision trees, called a 'forest', to isolate outliers. The isolation is based on the principle that random partitions in the data will isolate anomalies more quickly than normal points.

_Drawbacks and Mitigation_

RRCF can be computationally intensive for very large datasets. To mitigate this, one can use a subset of the data for training or employ distributed computing frameworks for large-scale data processing. Moreover this Works better than isolation forests with drifted data.

_Real-World Scenario: IoT Monitoring_

In IoT, RRCF can be used to monitor sensor data for anomalies, such as detecting unusual patterns in temperature or pressure readings in an industrial setting, which might indicate equipment malfunctions or environmental hazards.

Resourses:
[Python Module](https://klabum.github.io/rrcf/)

```python
import numpy as np
import rrcf

# Generate data
n = 730
A = 50
center = 100
phi = 30
T = 2*np.pi/100
t = np.arange(n)
sin = A*np.sin(T*t-phi*T) + center
sin[235:255] = 80

# Set tree parameters
num_trees = 40
shingle_size = 4
tree_size = 256

# Create a forest of empty trees
forest = []
for _ in range(num_trees):
    tree = rrcf.RCTree()
    forest.append(tree)
    
# Use the "shingle" generator to create rolling window
points = rrcf.shingle(sin, size=shingle_size)

# Create a dict to store anomaly score of each point
avg_codisp = {}

# For each shingle...
for index, point in enumerate(points):
    # For each tree in the forest...
    for tree in forest:
        # If tree is above permitted size...
        if len(tree.leaves) > tree_size:
            # Drop the oldest point (FIFO)
            tree.forget_point(index - tree_size)
        # Insert the new point into the tree
        tree.insert_point(point, index=index)
        # Compute codisp on the new point...
        new_codisp = tree.codisp(index)
        # And take the average over all trees
        if not index in avg_codisp:
            avg_codisp[index] = 0
        avg_codisp[index] += new_codisp / num_trees
```

<!-- Image for Robust Random Cut Forest (RRCF) -->
<img src="/images/Posts/Time_Series_Outlier_Detection/Robust Random Cut Forest.webp">
<div align="center">Figure: Robust Random Cut Forest</div>

### 12.  Bayesian Structural Time Series (BSTS)

_Application and Theory_

Bayesian Structural Time Series (BSTS) is a probabilistic approach, used extensively in econometrics and marketing analytics. It models time-series data as a combination of components like trend, seasonality, and holidays, using Bayesian methods to estimate these components' contribution and detect anomalies. Anomalies reflected as noise in seasonally adjusted series.

_Drawbacks and Mitigation_

BSTS can be complex to understand and implement, particularly in choosing priors. Using software packages that provide default settings for priors can simplify its application.

_Real-World Scenario: Marketing Analytics_
In marketing, BSTS can analyze sales data to understand the impact of marketing campaigns. An unexpected dip or rise in sales, when controlled for seasonal and holiday effects, might indicate the success or failure of a campaign.

_Resourses:_
[Python Module](https://pypi.org/project/bsts/)
[Python Module](https://pypi.org/project/pybsts/)