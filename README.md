## Credit_Card_Fraud_Detection_Using_R

In this case, a new credit card company has entered the Western market of the United States. As one of the most secure company’s products, its credit card, the transactions must be safe and transparent internally and externally. Assume that we are a junior data scientist who was hired to identify instances of fraud during the transaction. This is our first task to help the company develop a feasible solution to better detect the pattern of fraud in credit card transactions and increase the overall safety consciousness.

Our goal for this project is to predict fraud detection with different variables by using the dataset. To find out the accuracy of the model and fulfilled the questions we want to explore in our cases, we can have a clear picture of this event. 

To sum up, according to the problem of credit card fraud transactions, we will dive into this dataset and see if we can dig out more useful information during the project.

The link of the dataset = ‘https://www.kaggle.com/datasets/kartik2112/fraud-detection?select=fraudTrain.csv’


###Introduction

There are two datasets already split as training and testing dataset. In our case, we chose train dataset as our main dataset. Due to the similarity and consistency of data, there are slightly differences between two of them. To briefly introduce this dataset, we will start with its dictionary before data scaling and cleaning. First, we selected the necessary columns for the analysis and drop personal information, such as first name and last name. 


###Data Dictionary (columns descriptions, after preprocessing)

trans_date_trans_time      	Transaction Date Time
merchant	Category of Merchant
amt	Amount of Transaction
gender	Gender (F = Female, M = Male)
city	Credit Card Holder’s City
state	Credit Card Holder’s State
lat	Latitude Location of Purchase
long	Longitude Location of Purchase
city_pop      	Credit Card Holder’s City Population
job	Job of Credit Card Holder
dob	Date of Birth
trans_num	Transaction Number
is_fraud	Fraud Transaction (0 = N, 1 = Y)


###Research Questions
1.	Are elder customers more likely to be victims of credit card fraud?
   

2.	Which type of purchase has the highest fraud amount of transaction?


3.	Is there a linear relationship between credit card holders’ city population and their amount of transactions?

