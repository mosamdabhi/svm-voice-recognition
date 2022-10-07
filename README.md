# Voice Recognition

- SVM Classifier with 92% F-Score for recognizing digits.

- HMM Model with 99% F-Score and corresponding Viterbi Decoder on Android smartphone.





## Feature Extraction using MFCC:

![issue3](https://cloud.githubusercontent.com/assets/7952344/23005707/a163b2a2-f423-11e6-9437-8bdd9e8e4011.png)


## Frame-by-Frame labelling Feature Extraction

![issue4](https://cloud.githubusercontent.com/assets/7952344/23005817/56508d16-f424-11e6-8706-6d5e08be57cb.jpg)





























-   Similarly, this procedure was followed for Training Samples and Testing Samples and respective Training Set and Test Set were obtained and then when binary classification using SVM was applied on these data and the results were okay to be implemented. The F-Score came 92% and Efficiency came as 90%. Now we have got the ready algorithm for implementing binary digit recognition in the Android Smart Phone.


Better Algorithm:
Hidden Markov Models(HMM) trained through HMM Tool Kit(HTK) :

- Here, the forward algorithm of HMM was used to make the training set.
- Forward algorithm is basically used to calculate the “belief state”, meaning the probability of state at a certain time, given the history of evidence.
- My work is to detect the sound/silence through the android smart phone and whenever there is sound, I have to calculate the MFCC of that portion and send it over to the training set data after which Viterbi decoding of this sent data(test-data) will be done and accordingly the digit or mathematical sign(addition, subtraction etc.) would be identified which will be dependent on Training set data.
- And as we can say, this algorithm is way better than SVM trained binary classifier and is considered ideal for digit recognition.
-   So, as a way forward, this algorithm would be implemented in the Android Smart Phone so that different applications like:
               1) Voice Calculator
               2) Voice Based Home Automation
               3) And many other applications are possible … 


-  Project led under Professor Prasanta Kumar Ghosh at his laboratory SPIRE.


