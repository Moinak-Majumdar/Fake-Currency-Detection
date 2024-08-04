# Fake Currency Detection
### Maulana Abul Kalam Azad University of Technology - Masters of Computer Application Final Year Project, 2024
### Submitted by **Moinak Majumdar**, Supervised by **Dr. Supriyo De**

---

### **Content**
- [Abstract](#abstract)
- [Objective](#objective)
- [Result](#result)
- [Implementation](#implementation)
- [App Recording](#recording)

## <a id='abstract'>Abstract</a>

Counterfeit currency poses a significant threat to the stability and integrity of our financial system, public trust and causing economic losses. To addresses this issue by developing a fake currency detection system that primarily utilizes Convolutional Neural Networks (CNN) to identify counterfeit banknotes with high accuracy Additionally, the performance of the CNN model is compared with Support Vector Classifier (SVC) and Random Forest algorithms to ensure robust analysis and validation of results. A mobile-based solution for real-time detection of fake currency using machine learning algorithms, allows common people to easily verify banknotes.

<b><i>Keywords: Convolutional Neural Networks, Support vector classifier, Random Forest classifier. Counterfeit detection technique, Indian currency security features.</i></b>


## <a id='objective'>Objective</a>

This work focuses on the development of a mobile-based solution to detect counterfeit currency notes in real time. The approach used ensured accurate detection by Convolutional Neural Networks, the Support Vector Classifier and Random Forest algorithms. This would have a user-friendly interface to make the application vivid and easy to use for the common people. This will, therefore, incorporate the solution into mobile devices as a convenient and efficient tool for instant verification of banknotes to enhance financial security and gain user trust

## <a id='result'>Result</a>
- CNN Training vs Validation accuracy and loss

![cnnGraph](/media/cnnGraph.png)

- CNN confusion matrix

![cnn_cm](/media/cnn_cm.png)

- Random forest confusion matrix

![rf_cm](/media/rf_cm.png)

- Support vector classifier confusion matrix

![svc_cm](/media/svc_cm.png)

## <a id='implementation'>Implementation</a>
- **Model Conversion:** To implement the model on mobile device, the model need to be converted in optimized format: 
    - **TfLite:** TensorFlow Lite is a lightweight, cross-platform framework designed to deploy machine learning models on mobile and embedded devices.
    - **Onnx:** Open Neural Network Exchange Runtime is a cross-platform machine-learning model accelerator, with a flexible interface to integrate hardware-specific libraries. ONNX Runtime can be used with models from PyTorch, Tensorflow/Keras, scikit-learn, and other frameworks.

- **Application Development with Flutter:** Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase. 

## <a id='recording'>Recording</a>

https://github.com/user-attachments/assets/046f796f-c3fa-4a65-b8bf-f9e863e8a771

