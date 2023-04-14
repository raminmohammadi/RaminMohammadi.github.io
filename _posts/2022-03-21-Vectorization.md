---
title: All Sorts of Text Vectorization Techniques
subtitle: by Ramin Mohammadi
date: 2022-03-21 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi
categories: nlp
---

Text vectorization is the process of converting text into numerical vectors that can be processed by machine learning algorithms. There are various techniques for text vectorization, each with its own strengths and weaknesses. In this blog post, we will discuss four common text vectorization techniques and provide examples of each.

### 1. Bag of Words

The bag of words model is a simple and popular technique for text vectorization. It involves creating a vocabulary of all unique words in the corpus and representing each document as a vector of word frequencies. The frequency of each word in the document is counted and assigned to the corresponding dimension in the vector.

Suppose we have the following three documents:

Document 1: "the cat in the hat" \\
Document 2: "the cat sat on the mat" \\
Document 3: "the dog chased the ball" 

The vocabulary for these documents is ["ball", "cat", "chased", "dog", "hat", "in", "mat", "on", "sat", "the"] in  alphabetical order. The vector representation for Document 1 is [0 1 0 0 1 1 0 0 0 2], the vector representation for Document 2 is [0 1 0 0 0 0 1 1 1 2], and the vector representation for Document 3 is [1 0 1 1 0 0 0 0 0 2].

```python
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the ball"]
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(corpus)
print(X.toarray())
```

Output:

```
[[0 1 0 0 1 1 0 0 0 2]
 [0 1 0 0 0 0 1 1 1 2]
 [1 0 1 1 0 0 0 0 0 2]]
```

### 2. TF-IDF

The `TF-IDF` (Term Frequency-Inverse Document Frequency) model is a more advanced technique for text vectorization that takes into account the importance of each word in the corpus. The TF-IDF value for a word in a document is calculated as the product of its term frequency and inverse document frequency.

`TF` (Term Frequency) is calculated as the frequency of a word in a document divided by the total number of words in the document or just the raw count of a word in a document (we will use the later definition to explain below). `IDF` (Inverse Document Frequency) is calculated as the logarithm of the total number of documents, $N$, in the corpus divided by the number of documents that contain the word, $c$, i.e.,

\begin{equation}
    idf = log\frac{N}{c}
\end{equation}

For example, consider the same two documents from the bag of words example. The `TF-IDF` value for the word "the" in Document 1 is $1 * log(2/2) = 0.0$, and the `TF-IDF` value for the word "dog" in Document 2 is $1 * log(2/1) = 0.693$.

For smothing purpose, idf can be calculated using the formula below, 

<<<<<<< HEAD
\begin{equation}
    idf = log\frac{N+1}{c+1} + 1
\end{equation}
For example, the `TF-IDF` value for the word "the" in Document 1 is $2 * (log((1+3)/(3+1))+1) = 2$, which 
can be seen as the last element of the first list inside the below Output.
=======
The vocabulary for these documents is ["the", "cat", "in", "hat", "sat", "on", "mat", "dog", "chased", "ball"]. The vector representation for Document 1 is [2, 1, 1, 1, 0, 0, 0, 0, 0, 0], the vector representation for Document 2 is [2, 1, 0, 0, 1, 1, 1, 0, 0, 0], and the vector representation for Document 3 is [2, 0, 0, 0, 0, 0, 1, 1, 1].
>>>>>>> 44450ac1ea27c1f4558adc32109ff45928fc60c5

```python
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the ball"]
vectorizer = TfidfVectorizer(norm=None)
X = vectorizer.fit_transform(corpus)
print(vectorizer.vocabulary_)
print(X.toarray())
```

Output:
```
{'the': 9, 'cat': 1, 'in': 5, 'hat': 4, 'sat': 8, 'on': 7, 'mat': 6, 'dog': 3, 'chased': 2, 'ball': 0}
[[0.         1.28768207 0.         0.         1.69314718 1.69314718
  0.         0.         0.         2.        ]
 [0.         1.28768207 0.         0.         0.         0.
  1.69314718 1.69314718 1.69314718 2.        ]
 [1.69314718 0.         1.69314718 1.69314718 0.         0.
  0.         0.         0.         2.        ]]
```

<<<<<<< HEAD
As most model will require a normalized input matrix, l2 normalization is recommended for the above output.
What we need to do is to assign the parameter `norm='l2'` or leave it as an empty (default),
=======
#### TF-IDF
Suppose we have the same three documents as in the previous example. The term frequency for the word "cat" in Document 1 is 1/5, the term frequency for "cat" in Document 2 is 1/6, and the term frequency for "cat" in Document 3 is 0/5. The inverse document frequency for "cat" is log(3/2) = 0.176, since there are three documents in the corpus and "cat" appears in two of them. The TF-IDF value for "cat" in Document 1 is (1/5) * 0.176 = 0.035, the TF-IDF value for "cat" in Document 2 is (1/6) * 0.176 = 0.029, and the TF-IDF value for "cat" in Document 3 is 0 * 0.176 = 0.
>>>>>>> 44450ac1ea27c1f4558adc32109ff45928fc60c5

```python
vectorizer = TfidfVectorizer(norm='l2')
```

In other words, 

```python
X = X.toarray()
X / np.sqrt(np.sum(X**2, axis=1, keepdims=True))
```

Output:

```
[[0.         0.38151877 0.         0.         0.50165133 0.50165133
  0.         0.         0.         0.59256672]
 [0.         0.34101521 0.         0.         0.         0.
  0.44839402 0.44839402 0.44839402 0.52965746]
 [0.4769856  0.         0.4769856  0.4769856  0.         0.
  0.         0.         0.         0.56343076]]
```

### 3. Word Embeddings

Word embeddings are a type of text vectorization technique that maps each word in the corpus to a low-dimensional vector. The vectors are learned through a neural network that takes into account the context in which each word appears. Word embeddings capture the semantic and syntactic meaning of words and are useful for various natural language processing tasks.

To develop an embedding using TensorFlow and Keras, follow these steps:

- Import necessary libraries
- Prepare your data (tokenization and padding)
- Create a model with an Embedding layer
- Compile and train the model

Here's a simple example to demonstrate these steps:

```python
# Step 1: Import necessary libraries
import tensorflow as tf
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

# Step 2: Prepare your data (tokenization and padding)
sentences = [
    "I love machine learning",
    "Natural language processing is fascinating",
    "Deep learning is a subset of machine learning",
]

tokenizer = Tokenizer(num_words=100, oov_token="<OOV>")
tokenizer.fit_on_texts(sentences)
word_index = tokenizer.word_index
sequences = tokenizer.texts_to_sequences(sentences)
padded_sequences = pad_sequences(sequences, maxlen=10, padding="post")

# Step 3: Create a model with an Embedding layer
model = tf.keras.Sequential([
    tf.keras.layers.Embedding(input_dim=100, output_dim=16, input_length=10),
    tf.keras.layers.Flatten(),  # You can use other layers such as GlobalAveragePooling1D as well
    tf.keras.layers.Dense(6, activation="relu"),
    tf.keras.layers.Dense(1, activation="sigmoid")
])

# Step 4: Compile and train the model
model.compile(loss="binary_crossentropy", optimizer="adam", metrics=["accuracy"])

# Dummy labels for demonstration purposes
labels = [1, 0, 1]

# Train the model
model.fit(padded_sequences.tolist(), labels, epochs=10)

```

This example demonstrates how to create a simple model with an Embedding layer using TensorFlow and Keras. First, the sentences are tokenized and converted to padded sequences. Then, a model is created with an Embedding layer followed by a Flatten layer, a dense layer with 6 units and ReLU activation, and an output layer with a single unit and sigmoid activation. Finally, the model is compiled and trained on the padded sequences and dummy labels.

After training the model, you can access the trained embedding layer's weights to inspect or use them for other purposes. Here's how you can do that:

```python
# Get the embedding layer
embedding_layer = model.layers[0]

# Access the weights of the embedding layer
weights = embedding_layer.get_weights()[0]

# The shape of the weights matrix will be (input_dim, output_dim)
print("Shape of the weights matrix:", weights.shape)

# Get the embedding for a specific word
word_index_to_find = word_index["machine"]
word_embedding = weights[word_index_to_find]
print("Embedding for 'machine':", word_embedding)
```

In this example, we first get the embedding layer from the model using `model.layers[0]`, as the embedding layer is the first layer in our model. Then, we access the weights of the embedding layer using `embedding_layer.get_weights()[0]`. The shape of the weights matrix will be `(input_dim, output_dim)`.

To get the embedding for a specific word, we can look up the word index using the tokenizer's word index dictionary, and then access the corresponding row in the weights matrix. In this example, we find the embedding for the word "machine".

```
Shape of the weights matrix: (100, 16)
Embedding for 'machine': [ 0.02413699 -0.05747801 -0.05382366 -0.00870479  0.04794465 -0.0100428
 -0.00971722 -0.03319969  0.04297956  0.04293872 -0.0194245  -0.03947173
  0.02845843  0.00695275  0.03985218 -0.01657288]
```


### 4. Doc2Vec

Doc2Vec is a text vectorization technique that extends the idea of word embeddings to entire documents. It represents each document as a low-dimensional vector that captures its meaning and context. Doc2Vec is trained using a neural network that takes into account both the words in the document and the document's unique identifier.

For example, consider a corpus of news articles. The vector representation for an article might be [0.3, -0.2, 0.1, 0.-0.5], where each dimension represents a different aspect of the article's content or sentiment.

Below is an example of using Doc2Vec with TensorFlow and Keras. In this example, we'll use the IMDB dataset to create document embeddings and classify movie reviews as positive or negative. Please note that Doc2Vec is not natively supported by TensorFlow or Keras, but we can achieve a similar effect using a custom approach.

```python
import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, Model, preprocessing
from tensorflow.keras.datasets import imdb

# Load the IMDB dataset
max_features = 10000
maxlen = 300

(x_train, y_train), (x_test, y_test) = imdb.load_data(num_words=max_features)
x_train = preprocessing.sequence.pad_sequences(x_train, maxlen=maxlen)
x_test = preprocessing.sequence.pad_sequences(x_test, maxlen=maxlen)

class Doc2Vec(Model):
    def __init__(self, max_features, embedding_dim, maxlen):
        super(Doc2Vec, self).__init__()
        self.embedding = layers.Embedding(max_features, embedding_dim, input_length=maxlen)
        self.avg_pool = layers.GlobalAveragePooling1D()
        self.dense = layers.Dense(1, activation='sigmoid')

    def call(self, inputs):
        x = self.embedding(inputs)
        x = self.avg_pool(x)
        x = self.dense(x)
        return x

    def get_embeddings(self, inputs):
        x = self.embedding(inputs)
        x = self.avg_pool(x)
        return x

embedding_dim = 128
model = Doc2Vec(max_features, embedding_dim, maxlen)
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Train the model
epochs = 10
batch_size = 32

history = model.fit(
    x_train, y_train,
    epochs=epochs,
    batch_size=batch_size,
    validation_split=0.2
)

# Evaluate the model
test_loss, test_acc = model.evaluate(x_test, y_test)
print(f'Test accuracy: {test_acc}')

# Get the word index from the IMDB dataset
word_index = imdb.get_word_index()

# Define a sample document
sample_doc = "This movie is fantastic! I really enjoyed it and highly recommend it."

# Preprocess the sample document
def preprocess_doc(doc, word_index, maxlen=300):
    tokens = doc.lower().split()
    token_ids = [word_index.get(token, 1) for token in tokens]  # 1 is the index for out-of-vocabulary words
    padded_tokens = preprocessing.sequence.pad_sequences([token_ids], maxlen=maxlen)
    return padded_tokens

sample_doc_preprocessed = preprocess_doc(sample_doc, word_index, maxlen)

# Obtain the embeddings for the sample document
doc_embeddings = model.get_embeddings(sample_doc_preprocessed)
print(f"Document embeddings shape: {doc_embeddings.shape}")
print(f"Document embeddings: {doc_embeddings}")
```

Part of output:

```
Document embeddings shape: (1, 128)
Document embeddings: [[-0.03332498  0.02149555 -0.03570618 -0.01496935 -0.02809953  0.02970941
   0.02491445 -0.02052332  0.02021462 -0.00954685  0.03282563  0.01585981
  -0.03508868 -0.03854481  0.04335667  0.00857451  0.03536903  0.02139922
   0.02785825 -0.01258065  0.02099344 -0.04324191 -0.02876599  0.0381836
  -0.04068084  0.01699455  0.04381409 -0.00950469  0.02788743  0.04080617
  -0.01029504 -0.04217651 -0.0207891  -0.02794119 -0.04348803  0.03267356
   0.0122643   0.01809947 -0.02824404  0.0200795   0.04166844  0.00185017
   0.04230817 -0.02399788  0.0047141   0.01540776  0.00130954  0.01412019
   0.01188601  0.03322793  0.02316885 -0.02906333 -0.00211944  0.00920796
   0.03495089 -0.00085822 -0.03712093 -0.03742212  0.01604812 -0.0028497
  -0.01565623  0.00659219 -0.01928242 -0.01757747  0.0259659  -0.02001496
   0.01374836  0.02165808 -0.02058002  0.01073473 -0.03319663 -0.04416433
  -0.00037649 -0.02048877 -0.02593763 -0.02201134  0.02046788  0.03230011
   0.01069888  0.02703679  0.04115723 -0.00040947  0.00611654  0.0161706
  -0.00828066  0.01221789  0.03822241 -0.02687576  0.0035094  -0.02249913
   0.00462279  0.02576657  0.02639207  0.03381234 -0.0120204   0.0217866
  -0.0303988  -0.00331894  0.01864516  0.02433652 -0.02785279  0.00559374
   0.009917   -0.00494993 -0.04006478  0.00984478 -0.00093492 -0.03563965
  -0.02665879 -0.01499166 -0.00409812  0.02898056 -0.00355999 -0.04162361
   0.04168115  0.01700404 -0.02436942  0.02686478  0.01744992  0.02253166
   0.04268411 -0.00433293  0.0436205   0.02046859 -0.0444436  -0.01251493
  -0.04224044 -0.00371554]]
  ```

## Conclusion

Text vectorization is a crucial step in many natural language processing tasks. In this blog post, we have discussed four common text vectorization techniques: bag of words, TF-IDF, word embeddings, and Doc2Vec. Each technique has its own strengths and weaknesses, and the choice of technique depends on the specific task and the characteristics of the corpus. By understanding these techniques and their mathematical formulas, we can better preprocess text data and improve the performance of our machine learning models.
