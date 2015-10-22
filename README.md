# Voice-Based-Digit-Recognition-Speech-Recognition-System-Machine-Learning-
- Implemented SVM Binary Classifier with 92% F-Score for classifying digits "1" and "2".  
- Implemented HMM Models with 99% F-Score and built a recognizer through a VIterbi Decoder  (Convolutional Decoding) for recognizing digits "1-10" and "oh" and the recognizer implemented in   Android Smartphone
- Implemented SVM Binary Classifier with 92% F-Score for classifying digits "1" and "2".
- Implemented HMM Models with 99% F-Score and built a recogniser through a VIterbi Decoder for recognising digits "1-10" and "oh".

Voice-Based Digit Recognition:
->  In computer science and electrical engineering, Voice recognition (VR) is the translation of spoken words into text. It is also known as "automatic speech recognition" (ASR), "computer speech recognition", or just "speech to text" (STT).
->  We will be using such Voice Recognition systems that use "training” where an individual speaker reads text or isolated vocabulary into the system. The system analyzes the person's specific voice and uses it to fine-tune the recognition of that person's speech, resulting in increased accuracy.
->  Two Approaches were taken by us in the Voice-Based Digit Recognition:
               1)  Support Vector Machine(SVM) trained and tested Binary Classifiers Algorithm which will classify between digits                      “1” and “2”.
               2)  Hidden Markov Models(HMM) trained through HMM Tool Kit(HTK), training set would be obtained through                           Matlab which will be used by the Android Application on test samples. All the digits from “0-9” and “oh” will be                       recognized and apart from that, words can be added as long as we have their training data. So, a “Voice-Based                     Calculator” can be made through this algorithm.


Algorithms Used:
1) Binary Classification using Support Vector Machine(SVM) :
->  For SVM Binary Classification algorithm, which is a Machine Learning algorithm we got all the training samples to train.
->  One sample was used, its Short-Term Energy was calculated, in which a window of 320 sample was used, energy in that frame was calculated and the windowing was shifted by 160 and so on, after that, similarly consecutive training samples were used, their STE was calculated which is shown below :



















->  After the STE was obtained(shown in red), the initial and ending points of the STE were determined and the area between those points was determined and that original signal was cropped out, as the rest of the values in the signal(initial and ending part) are basically noise, which are not required.

->  After cropping the required part, in the image shown here, the 3rd plot represented the required part of the signal on which feature extraction using MFCC has to be done.
->  After obtaining the required part of the signal, the MFCC was calculated with 13 coefficients.
So now as we got suppose 13x73* matrix of MFCC of one of the sample, I transposed it, as the number 73* here will be changing for different samples, but 13 coefficients of MFCC would remain constant.


















->  The features such as mean, mode, variance, co-variance, correlation coefficient, min, max, etc such nine calculations were done and these singular values were stored in Training Set matrix. Such calculations were done similarly for all the rest of the training samples.
->  The labels were arranged after that, such that every respective training sample, whether it is “1” or “2” were labelled accordingly as “1” or “2”. (* This value would be different for different samples)

Feature Extraction using MFCC:

->  Shown here is the MFCC
     calculated spectrum
     of the original cropped signal.
->  After labelling,
     the same procedure for test samples
     was carried out,
     cropping the required part of signal,
     labelling them, calculating
     their MFCC, oing feature extraction
     and then the final output matrix
     was termed as Test Set.
->  The Binary Classification
      using SVM Tool of Matlab
      was implemented on
      these two sets of data.
      The result was very poor,
      with F-Score of 52% and
      efficiency of 50%, which is almost equal to
      random guessing as we are doing binary classification here.

->  So, we only took one of the coefficients, i.e. the Energy Coefficient of MFCC and calculated all the above features, and followed the same procedure followed before, and this time the result were quite good. We got the F-Score of 86% and Efficiency of 85%.
->  Still, we had to increase the F-Score so finally we did the feature extraction frame-wise.
->  Cross Validation of Training Set had to be done, which was left and hadn’t been done at that time.

Frame-by-Frame labelling Feature Extraction:
->  In Frame wise feature extraction, all those different calculations of mean, mode, median, covariance, etc. were not done, instead after labelling the training data with their respective values, we labelled the MFCC Features too.
->  After the 13x73* Matrix of MFCC is obtained, transposing it to 73*x13, we got 73* rows suppose for one such sample and labelled all these rows with it’s current respective label whether it is “1” or “2”.
































->  Similarly, this procedure was followed for Training Samples and Testing Samples and respective Training Set and Test Set were obtained and then when binary classification using SVM was applied on these data and the results were okay to be implemented. The F-Score came 92% and Efficiency came as 90%. Now we have got the ready algorithm for implementing binary digit recognition in the Android Smart Phone.


Better Algorithm:
Hidden Markov Models(HMM) trained through HMM Tool Kit(HTK) :

->  Here, the forward algorithm of HMM was used to make the training set.
->  Forward algorithm is basically used to calculate the “belief state”, meaning the probability of state at a certain time, given the history of evidence.
->  My work is to detect the sound/silence through the android smart phone and whenever there is sound, I have to calculate the MFCC of that portion and send it over to the training set data after which Viterbi decoding of this sent data(test-data) will be done and accordingly the digit or mathematical sign(addition, subtraction etc.) would be identified which will be dependent on Training set data.
->  And as we can say, this algorithm is way better than SVM trained binary classifier and is considered ideal for digit recognition.
->  So, as a way forward, this algorithm would be implemented in the Android Smart Phone so that different applications like:
               1) Voice Calculator
               2) Voice Based Home Automation
               3) And many other applications are possible … 


->  Project led under Professor Prasanta Kumar Ghosh at his laboratory SPIRE.
To visit the page of SPIRE: Click Here

