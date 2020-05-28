
# coding: utf-8

# In[ ]:


# BUAN 5310 - statistical learning
# Group project
# Group 11: Han Li - Wei Li - Shuai Ma - Huy Le
# Decision tree model

# Readme: This file include all the code and result for building decision tree model. The dataset was used is Cleaned_Data.csv
# which is full data after cleanning. In each Airline and Airport we will conduct full and pruned tree. 
# Then use the trained model for trainning accuracy, testing accuracy and k-fold validation
#


# In[ ]:


import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn import tree
from sklearn import preprocessing
from sklearn.preprocessing import label_binarize
import matplotlib as mpl
import matplotlib.pyplot as plt
from sklearn.metrics import classification_report
from sklearn.model_selection import KFold
import datetime


# In[2]:


# getting data from full dataset
dat = pd.read_csv("../Cleaned_Data.csv")


# In[3]:


#drop unused columns
dat = dat.drop(columns =["ID","FrequentDestination1",
                             "FrequentDestination2",
                             "FrequentDestination3",
                             "FrequentDestination4",
                             "FrequentDestination5",
                             "FrequentDestination6",
                             "FrequentDestination7",
                        "TotalDepartureHr","MileageAirline"], axis =1)


# In[4]:


dat.describe()


# In[5]:


# create data for airport model (Xap)
Xap = dat.loc[:, ~dat.columns.isin(['Airport'])]
yap = dat['Airport'].astype('category').cat.codes
yap.name= 'Airport' # this one is for name the tree graph

# prepare data for airline model (Xal)
Xal = dat.drop(columns =["Airline"], axis =1)
yal = dat['Airline'].astype('category').cat.codes
yal.name = "Airline" # this one is for name the tree graph


# In[6]:


# decision tree function, return trained model
def decision_tree(X_train, y_train, maxdepth = None, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2 ):
    now =str(datetime.datetime.now())
    clf =tree.DecisionTreeClassifier(class_weight=None, 
                                     criterion ='gini', 
                                     max_depth =maxdepth, 
                                     max_features = max_feature, 
                                     max_leaf_nodes= maxleaf,
                                    min_samples_leaf = minsamleaf, min_samples_split =minsamsplit,
                                    min_weight_fraction_leaf =0.0, presort =False, random_state =100, splitter = 'best')
    clf = clf.fit(X_train, y_train)
    # tree graph will be generate with name: Airport/Airline datetime .dot
    tree.export_graphviz(clf,out_file=str(y_train.name)+now +".dot",feature_names=X_train.columns) 
    return(clf)

# testing decision tree model, return the accuracy
# multi = false => Y only have 0 or 1
def test_decisiont_tree(X_test, y_test, model, multi = False):
    y_pred =model.predict(X_test)
    if multi==True:        
        print(metrics.confusion_matrix(y_test,y_pred))
        print("Accuracy:",metrics.accuracy_score(y_test, y_pred))
        print(classification_report(y_test, y_pred, target_names=['Korean Air(KE)','Asiana Airlines','Korean LCC','Foreign Airlines']))
    else:
        print(metrics.confusion_matrix(y_test,y_pred))
        print("Accuracy:",metrics.accuracy_score(y_test, y_pred))
        print("Recall:", metrics.recall_score(y_test, y_pred))
        print("Precision:",metrics.precision_score(y_test, y_pred))
        print("F measure:",metrics.f1_score(y_test, y_pred))

# k-fold validation, X and y shoudl be full dataset
def kfold_test(model, X, y, k):
    kf = KFold(n_splits=k)
    kf.get_n_splits(X)
    acc= 0
    for train_index, test_index in kf.split(X):
        X_test, y_test = X.iloc[test_index], y.iloc[test_index]
        X_train, y_train= X.iloc[train_index], y.iloc[train_index]
        model = model.fit(X_train, y_train)
        y_pred = model.predict(X_test)
        acc =acc + metrics.accuracy_score(y_test, y_pred)
        print(metrics.confusion_matrix(y_test,y_pred))
        print("Accuracy:",metrics.accuracy_score(y_test, y_pred))
    print("Average accuracy: ", acc/k) # return the average accuracy


# ## Model training
# ### Airport choice model

# #### A. Default prameters

# In[7]:


# train airport model with default parameter
X_train, X_test, y_train, y_test = train_test_split(Xap, yap, test_size=0.30,random_state=6)
airport_model_default = decision_tree(X_train, y_train)#, maxdepth = 10, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2 )

#testing model training accuracy
print('Trainning accuracy')
test_decisiont_tree(X_train,y_train,airport_model_default, False)#, maxdepth = 5,max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2)
print('Testing accuracy')
#testing with 30% testing
test_decisiont_tree(X_test,y_test,airport_model_default, False)


# #### B. With different parameter

# In[21]:



X_train, X_test, y_train, y_test = train_test_split(Xap, yap, test_size=0.30,random_state=6)
airport_model_maxdepth8 = decision_tree(X_train, y_train, maxdepth = 8, max_feature=None, maxleaf =None, minsamleaf =1, minsamsplit = 2 )
#testing the result
print('Trainning accuracy')
print("maxdepth = 8, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2 ")
test_decisiont_tree(X_train,y_train, airport_model_maxdepth8, False)#, maxdepth = 5,max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2)

#testing with 30% testing
print('Testing accuracy')
test_decisiont_tree(X_test,y_test,airport_model_maxdepth8, False)


# ### Airline choice model
# #### A. with default parameters

# In[22]:


# trainning airline model with default parameter
X_train, X_test, y_train, y_test = train_test_split(Xal,yal, test_size=0.30,random_state=6)
airline_model_default = decision_tree(X_train, y_train)#, maxdepth = 10, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2 )
# testing airline model with train set
print('Training accuracy')
test_decisiont_tree(X_train,y_train,airline_model_default, True)#, maxdepth = 5,max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2)

# testing airline model with test set
print('Testing accuracy')
test_decisiont_tree(X_test,y_test,airline_model_default, True)


# #### B. With different parameters

# In[24]:


## trainning airline model with default parameter
X_train, X_test, y_train, y_test = train_test_split(Xal,yal, test_size=0.30,random_state=6)
airline_model_11_1_2 = decision_tree(X_train, y_train, maxdepth =11, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit =2 )

# testing airline model
print('Training accuracy')
print("maxdepth = 11, max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2 ")
test_decisiont_tree(X_train,y_train,airline_model_11_1_2, True)#, maxdepth = 5,max_feature= None, maxleaf =None, minsamleaf =1, minsamsplit = 2)
# testing airline model with test set
print('Testing accuracy')
test_decisiont_tree(X_test,y_test,airline_model_11_1_2, True)


# ## Model testing (validation)
# Method: K-fold

# ### Airport

# In[14]:


#K =5
print('k=5')
kfold_test(airport_model_default, Xap, yap, 5)
#K =4
print('k=4')
kfold_test(airport_model_default, Xap, yap, 4)


# In[25]:


#K =5
print('k=5')
kfold_test(airport_model_maxdepth8, Xap, yap, 5)
#K =4
print('k=4')
kfold_test(airport_model_maxdepth, Xap, yap, 4)


# In[26]:


#K-fold testing Airline model, default parameter
# k =5
print('k=5')
kfold_test(airline_model_default, Xal, yal, 5)
#k=4
print('k=4')
kfold_test(airline_model_default, Xal, yal, 4)


# In[18]:


#K-fold testing Airline model
# k =5
print('k=5')
kfold_test(airline_model_11_1_2, Xal, yal, 5)
#k=4
print('k=4')
kfold_test(airline_model_11_1_2, Xal, yal, 4)

