---
title: Loss Functions - part 1 
subtitle: by Jinchuan He 
date: 2022-07-21 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
---


# Model Evaluation
<br>
Model Evaluation is a process of evaluating model preference. It uses different evaluation matrics to understand the machine learning model's performance. We can use model evaluation to find the best model that represents our data. There are two methods of evaluating models in data science, Hold-Out and Cross-Validation. What's more, there are two important problems in machine learning, classification problem, and regression problem. There is an important difference between classification and regression problems. Therefore, we will separate them to discuss.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/Evaluation Model.png" width="400" height="250">
<br>
<p>
<h2 id="table-of-contents">Table of contents</h2>
<ol>
  <li><a href="#dataset_separate">Dataset Separate</a><br />
 1.1 <a href="#hold-out">Hold-out</a><br />
 1.2 <a href="#cross-validation">Cross-Validation</a><br /></li>
  <li><a href="#regression_evaluation">Regression Evaluation</a><br/>
 2.1 <a href="#r_square">R Square</a><br />
 2.2 <a href="#mse/rmse"> Mean Square Error(MSE)/Root Mean Square Error(RMSE)</a><br />
 2.3 <a href="#mae">Mean Absolute Error(MAE)</a><br /></li>
   <li><a href="#classification_evaluation">Classificaiton Evaluation</a><br/>
 3.1 <a href="#confusion_matrix">Confusion Matrix</a><br />
 3.2 <a href="#precision_and_recall">Precision and Recall</a><br />
 3.3 <a href="#accuracy_and_errorate">Accuracy and Errorate</a><br />
 3.4 <a href="#ROC_chart">ROC Chart</a><br /></li>   
</ol>

<h2 id="1-dataset-separate-">1. Dataset Separatey <a name="dataset_separate"></a></h2>
<h3 id="11-Hold-out-">1. Hold-out <a name="hold-out"></a>
</h3>
In this method, the dataset is separated into third sets, called the Training set, Test set, and Validation set.
<br>
1. Training set is a part of the dataset. The data in the training set is used to build machine learning models.
<br>
2. Validation set is used to evaluate the performance of the model built in the training phase. It uses to fine-tuning model's parameters and selecting the best model.
<br>
3. Test set is used to assess the future performance of a model. If the preference of a model in the training set is much better than it in the test set, overfitting is probably the cause.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/data separate.png" width="300" height="200">
<br>
<h3 id="12-Cross-Validation-">2. Cross-Validation <a name="cross-validation"></a>
</h3>
When the size of the data is not large or there is a limited amount of data, the separation of data will lose some important information. When only a limited amount of data is available, to achieve an unbiased estimate of the model performance we use k-fold cross-validation. In k-fold cross-validation, the data is divided into k subsets of equal size. This method will build models k times and each time leave out one of the subsets from training and use it as the test set.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/k-fold.png" width="300" height="200">
<br>
<h2 id="2-regression-evaluation-">2. Regression Evaluation <a name="regression_evaluation"></a></h2>
There are many different evaluation metrics in machine learning. However, only some metrics are suitable to be used for regression. Next, I will introduce three important evaluation matrics and their differences of them.
<br>
Commonly, when I build a machine learning model, the first reaction of my friends or teammates would be: "what is the accuracy of your model?" In the regression model, we have some matrix to evaluate the accuracy.<p>There are 3 main metrics for model evaluation in regression:
<h3 id="21-r-square-">2. R Square <a name="r_square"></a>
</h3>
The R-squared is a scale-invariant statistic that shows the change ratio of the target variable in the linear regression model.
<br>
This concept is hard to understand and I will divide this concept.
<p>
(1) TSS: Total sum of squares
<p>
In statistical data analysis the total sum of squares (TSS or SST) is a quantity that appears as part of a standard way of presenting results of such analyses.
<center>
TSS = $\sum_{i=1}^{n}$($y_i$ - $y^h$)$^2$
<p>
In the equations, TSS or total sum of squares shows the total change in Y. It is very similar to the variance of Y. However, there is a difference between them. Variance is the mean of the sum of squares of the differences between the actual value and the data points and TSS is the sum of the sums of squares.
<br>
Now that we know the total amount of change in the target variable. How do we determine the proportion of this change explained by the model? 

(2)RSS: Residual sum of squares
<br>
It is the sum of the squares of residuals (deviations predicted from actual empirical values of data).
<center>
RSS = $\sum_{i=1}^{n}$($y_i$ - $f(x_i)$)$^2$
<p>
Thus, RSS show the changes in the target variable that are not explained by the model.
<br>
Now, TSS show the total amount of change and RSS show the change of X which are not explained by Y. Thus, TSS - RSS show the change which need to be explained by the model. Using TSS - RSS divided by TSS show the change ratio. This is the meaning of the R Square!
<center>
$R^2$ =（TSS-RSS）/ TSS<br>
= explanatory change / total change<br>
= 1 – unexplanatory change / total change    
</center>
<p>
Therefore, the R-square shows the degree of variability of the target variable, explained by the model or independent variables. If the value is 0.7, it means that the independent variable explains 70% of the variation in the target variable.
<br>
R-square is always between 0 and 1. The higher the R-squared, the more variation the model explains!<br>
<h3 align = "left" id="22-mse/rmse-">2. Mean Square Error(MSE)/Root Mean Square Error(RMSE) <a name="mse/rmse"></a>
</h3>
<p style="text-align: left;">
MSE measures the average of the squares of the errors—that is, the average squared difference between the estimated values and the actual value.
<center>
MSE = $1/n$$\sum_{i=1}^{n}$($y_i$ - $y_i^h$)$^2$
<p style="text-align: left;">
In order to remeber this concept, I marked each apart.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/MSE.png" width="200" height="100">
<p style="text-align: left;">
RMSE is the root of MSE. When MSE is too large to hard to read, we used to use RMSE to evaluate the model.
<center>
RMSE = $\sqrt{1/n\sum_{i=1}^{n}(y_i - y_i^h)^2}$
<h3 align = "left" id="23-mae-">2. Mean Absolute Error(MAE) <a name="mae"></a>
</h3>
<p style="text-align: left;">
MAE is taking the sum of the absolute value of error.
<center>
RMSE = $1/n\sum_{i=1}^{n}|y_i - y_i^h|$
</center>
<p style="text-align: left;">
Differnce: MSE gives larger penalization to big prediction error by square it while MAE treats all errors the same.
<h2 align = "left" id="3-classification-evaluation-">3. Classification Evaluation <a name="classification-evaluation"></a></h2>
<h3 align = "left" id="31-confusion-matrix-">1. Confusion Matrix <a name="confusion_matrix"></a>
    </h3>
<p style="text-align: left;">
The confusion matrix (or confusion table) shows a more detailed breakdown of correct and incorrect classifications for each class. Using a confusion matrix is useful when you want to understand the distinction between classes, particularly when the cost of misclassification might differ for the two classes, or you have a lot more test data on one class than the other. 

Here is Confusion Matrix:
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/confuse matrix.png" width="300" height="170">
<br>
<p style="text-align: left;">
True Positive(TP) signifies how many positive class samples your model predicted correctly.
<p>
True Negative(TN) signifies how many negative class samples your model predicted correctly.
<p>
False Positive(FP) signifies how many negative class samples your model predicted incorrectly. 
This factor represents Type-I error in statistical nomenclature. 
This error positioning in the confusion matrix depends on the choice of the null hypothesis.
<p>
False Negative(FN) signifies how many positive class samples your model predicted incorrectly. 
This factor represents Type-II error in statistical nomenclature. 
This error positioning in the confusion matrix also depends on the choice of the null hypothesis.
<h3 align = "left" id="32-precision-and-recall-">2. Precision and Recall<a name="precision_and_recall"></a>
    </h3>
<p style="text-align: left;">
Precision and recall are mainly used for binary classification problems.
<center>
Percision = $ \dfrac{True Positive}{True Positive + False Positive} $
<p>
    <center>
Recall = $ \dfrac{True Positive}{True Positive + False Negative} $ 
</center>
<p style="text-align: left;">
Ideally, precision and recall are as high as possible. In fact, they are contradictory in some cases. When the precision rate is high, the recall rate is low; when the precision rate is low, the recall rate is high. It is not difficult to observe this property by observing the PR curve. For example, when searching web pages, if only the most relevant web page is returned, the precision rate is 100%, and the recall rate is very low; if all web pages are returned, the recall rate is 100%, and the precision rate is very low. Therefore, in different cases, it is necessary to judge which indicator is more important according to the actual needs.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/Precision recall.png" width="300" height="170">
<br>
<h3 align = "left" id="33-accuracy_and_errorate-">3. Accuracy and Errorate<a name="accuracy_and_errorate"></a>
    </h3>
<p style="text-align: left;">
Accuracy and errorates can be used for both binary and multi-class classification.
<center>
Accuracy = $ \dfrac{TP + TN }{TP + FP + TN + FN} $ 
<p>
<center>
Errorate = $ \dfrac{FP + FN }{TP + FP + TN + FN} $ 
<p>
<p style="text-align: left;">
In the multi-class classification:
<center>
Accuracy = $ 1/n\sum_{i=1}^{n}I(f(x_i)= y_i)$
<p>
I(indicator function):<br>
If input True return 1, else return 0
<h3 align = "left" id="34-ROC_chart-">4. ROC Chart<a name="ROC_chart"></a>
    </h3>
<p style="text-align: left;">
ROC(Receiver Operating Characteristic) chart shows false positive rate (1-specificity) on X-axis, against true positive rate (sensitivity) on Y-axis.
<center>
True Postive Rate(TPR): $ \dfrac{TP}{TP + FN} $ 
<p>
<center>
False Postive Rate(FPR): $ \dfrac{FP}{FP + TN} $
</center>
<p style="text-align: left;">
TPR and FPR have other names:
<center>
sensitivity = recall = true positive rate
<br>
specificity = 1- false positive rate
<br>
Precision = $P(Y = 1 | Y_h = 1)$
<br>
Recall = Sensitivity = $P(Y_h = 1 | Y = 1)$
<br>
Specificity = $P(Y_h = 0 | Y = 0)$
<br>
</center>
<p style="text-align: left;">
The formulation shows that sensitivity and specificity are conditional on the probability of the real label Y. We know that in the conditional probability no matter what the true probability of Y is, it will not affect sensitivity and specificity. This is the advantage of the ROC chart. The two evaluation matrix in the ROC chart is not affected by the imbalanced data. However, for the precision, it will be affected by the true and false ratio in the test data.
<br>
    <p style="text-align: center;">
    <img src="/images/Posts/Model_Evaluation/ROC Chart.png" width="300" height="170">
<br>
<p style="text-align: left;">
If the ROC curve is close to the upper left corner, the performance of the model is better. The coordinates of the upper left corner are (0, 1). At this point, FPR=0, TPR=1. The formulation of FPR and TPR shows that FN=0, FP=0. Therefore, the model classifies all samples correctly.
You can find this ROC chart is not smooth. What determines how smooth the ROC chart is?
When the amount of data is small, the drawn ROC curve is not smooth; when the amount of data is large, the drawn ROC curve tends to be smooth.

<h2 style="text-align: left;">
References
    </h2>
<p style="text-align: left;">
<p>
<a href="https://towardsdatascience.com/what-are-the-best-metrics-to-evaluate-your-regression-model-418ca481755b"
   >Regression Matrics</a>
</p>
<p>
<a href="https://medium.com/@skyl/evaluating-a-machine-learning-model-7cab1f597046"
   >Model Evaluation</a>
</p>