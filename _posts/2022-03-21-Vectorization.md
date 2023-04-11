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

For example, consider the following two documents:

Document 1: "The quick brown fox" \\
Document 2: "The lazy dog"

The vocabulary for these documents is ["the", "quick", "brown", "fox", "lazy", "dog"]. \\
The vector representation for Document 1 is [1, 1, 1, 1, 0, 0], and the vector representation for Document 2 is [1, 0, 0, 0, 1, 1].

### 2. TF-IDF

The `TF-IDF` (Term Frequency-Inverse Document Frequency) model is a more advanced technique for text vectorization that takes into account the importance of each word in the corpus. The TF-IDF value for a word in a document is calculated as the product of its term frequency and inverse document frequency.

`TF` (Term Frequency) is calculated as the frequency of a word in a document divided by the total number of words in the document. `IDF` (Inverse Document Frequency) is calculated as the logarithm of the total number of documents in the corpus divided by the number of documents that contain the word.

For example, consider the same two documents from the bag of words example. The `TF-IDF` value for the word "the" in Document 1 is $(1/4) * log(2/2) = 0.0$, and the `TF-IDF` value for the word "dog" in Document 2 is $(1/3) * log(2/1) = 0.366$.

### 3. Word Embeddings

Word embeddings are a type of text vectorization technique that maps each word in the corpus to a low-dimensional vector. The vectors are learned through a neural network that takes into account the context in which each word appears. Word embeddings capture the semantic and syntactic meaning of words and are useful for various natural language processing tasks.

For example, consider the word embeddings for the words "king", "queen", "man", and "woman". The vector for "king" might be [0.3, 0.2, -0.1, 0.5], the vector for "queen" might be [0.4, 0.1, -0.2, 0.6], the vector for "man" might be [0.2, 0.3, -0.3, 0.4], and the vector for "woman" might be [0.5, 0.1, -0.4, 0.3].

### 4. Doc2Vec

Doc2Vec is a text vectorization technique that extends the idea of word embeddings to entire documents. It represents each document as a low-dimensional vector that captures its meaning and context. Doc2Vec is trained using a neural network that takes into account both the words in the document and the document's unique identifier.

For example, consider a corpus of news articles. The vector representation for an article might be [0.3, -0.2, 0.1, 0.-0.5], where each dimension represents a different aspect of the article's content or sentiment.

### Examples

Here are some other mathematical examples for each type of text vectorization technique:

#### Bag of Words

Suppose we have the following three documents:

Document 1: "the cat in the hat" \\
Document 2: "the cat sat on the mat" \\
Document 3: "the dog chased the ball" 

The vocabulary for these documents is ["the", "cat", "in", "hat", "sat", "on", "mat", "dog", "chased"]. The vector representation for Document 1 is [1, 1, 1, 1, 0, 0, 0, 0, 0], the vector representation for Document 2 is [1, 1, 0, 0, 1, 1, 1, 0, 0], and the vector representation for Document 3 is [1, 1, 0, 0, 0, 0, 0, 1, 1].

```python
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the cat"]
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(corpus)
print(X.toarray())
```


#### TF-IDF
Suppose we have the same three documents as in the previous example. The term frequency for the word "cat" in Document 1 is 1/5, the term frequency for "cat" in Document 2 is 1/6, and the term frequency for "cat" in Document 3 is 0/6. The inverse document frequency for "cat" is log(3/2) = 0.176, since there are three documents in the corpus and "cat" appears in two of them. The TF-IDF value for "cat" in Document 1 is (1/5) * 0.176 = 0.035, the TF-IDF value for "cat" in Document 2 is (1/6) * 0.176 = 0.029, and the TF-IDF value for "cat" in Document 3 is 0 * 0.176 = 0.

```python
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the cat"]
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(corpus)
print(X.toarray())
```


#### Word Embeddings

Suppose we have a corpus of four words: "cat", "dog", "mouse", and "rat". We train a neural network to learn the following word embeddings:

cat: [0.5, 0.2, -0.3, 0.1] \\
dog: [0.4, 0.3, -0.4, 0.2] \\
mouse: [-0.1, 0.6, -0.2, 0.3] \\
rat: [-0.2, 0.5, -0.3, 0.4]

These vectors capture the semantic and syntactic meaning of the words, and can be used to perform various natural language processing tasks.

```python
import numpy as np
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.layers import Embedding, Flatten, Dense
from tensorflow.keras.models import Sequential

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the cat"]
tokenizer = Tokenizer()
tokenizer.fit_on_texts(corpus)
sequences = tokenizer.texts_to_sequences(corpus)
word_index = tokenizer.word_index
print(word_index)

embedding_matrix = np.array([
    [0.5, 0.2, -0.3, 0.1],
    [0.4, 0.3, -0.4, 0.2],
    [-0.1, 0.6, -0.2, 0.3],
    [-0.2, 0.5, -0.3, 0.4]
])

max_len = max([len(seq) for seq in sequences])
X = pad_sequences(sequences, maxlen=max_len, padding='post')
model = Sequential()
model.add(Embedding(input_dim=len(word_index)+1, output_dim=4, input_length=max_len, weights=[embedding_matrix], trainable=False))
model.add(Flatten())
model.add(Dense(1, activation='sigmoid'))
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
model.summary()

history = model.fit(X, [0, 1, 1], epochs=50, verbose=0)
print(model.predict(X))
```



#### Doc2Vec
Suppose we have the same three documents as in the first example. We train a Doc2Vec model to learn the following document vectors:

Document 1: [0.3, -0.2, 0.1, 0.5] \\
Document 2: [-0.1, 0.4, -0.3, 0.2] \\
Document 3: [0.5, -0.1, 0.2, 0.4]

These vectors capture the meaning and context of each document, and can be used to perform various natural language processing tasks such as document classification or clustering.

```python
import gensim
from gensim.models.doc2vec import Doc2Vec, TaggedDocument

corpus = ["the cat in the hat", "the cat sat on the mat", "the dog chased the cat"]

# Tag documents with unique IDs
tagged_docs = [TaggedDocument(words=doc.split(), tags=[i]) for i, doc in enumerate(corpus)]

# Train a Doc2Vec model
model = Doc2Vec(tagged_docs, vector_size=4, window=2, min_count=1, workers=4, epochs=100)

# Infer the vector representation for a new document
new_doc = "the cat in the mat"
inferred_vector = model.infer_vector(new_doc.split())
print(inferred_vector)
```


## Conclusion

Text vectorization is a crucial step in many natural language processing tasks. In this blog post, we have discussed four common text vectorization techniques: bag of words, TF-IDF, word embeddings, and Doc2Vec. Each technique has its own strengths and weaknesses, and the choice of technique depends on the specific task and the characteristics of the corpus. By understanding these techniques and their mathematical formulas, we can better preprocess text data and improve the performance of our machine learning models.