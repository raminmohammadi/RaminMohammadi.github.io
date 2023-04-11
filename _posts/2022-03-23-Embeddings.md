---
title: Understanding Different Types of Text Embeddings in NLP
subtitle: by Ramin Mohammadi
date: 2022-03-23 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi
categories: nlp
---


Text embeddings are the building blocks of natural language processing (NLP) algorithms. They are used to transform text data into numerical vectors that can be fed into machine learning models. Text embeddings can be created at various levels of granularity, including characters, words, and sentences. In this tutorial, we'll explore the different types of text embeddings, including character embedding, word embedding, sentence embedding, and byte pair encoding.

## What are Text Embeddings?

Text embeddings are numerical representations of text data that capture its semantic meaning. They are created using unsupervised learning techniques that analyze the context and relationships between words in a corpus of text data. The resulting embeddings can be used as input to machine learning models for a variety of NLP tasks, such as text classification, sentiment analysis, and machine translation.

### Character Embedding 

Character embedding is a type of text embedding that represents each character in a text sequence as a numerical vector. This approach is often used when working with text data that contains rare or out-of-vocabulary words. By breaking down the text into its constituent characters, character embedding can capture the morphology and syntax of the text, regardless of the vocabulary size.

Here's an example of how to create a character embedding using Python and the keras library:

```python
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.layers import Embedding, LSTM, Dense
from keras.models import Sequential

text = ['hello world', 'goodbye world']

# Create character-level tokenizer
tokenizer = Tokenizer(char_level=True)
tokenizer.fit_on_texts(text)
sequences = tokenizer.texts_to_sequences(text)

# Pad sequences to same length
max_length = max([len(seq) for seq in sequences])
padded_sequences = pad_sequences(sequences, maxlen=max_length, padding='post')

# Define model
model = Sequential()
model.add(Embedding(input_dim=len(tokenizer.word_index)+1, output_dim=8, input_length=max_length))
model.add(LSTM(8))
model.add(Dense(1, activation='sigmoid'))
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Train model on text data
model.fit(padded_sequences, [1, 0], epochs=10)

```

In this example, we create a character-level tokenizer using the Tokenizer class from keras. We then use the tokenizer to convert the text data into numerical sequences of characters, and pad the sequences to ensure they are all the same length. We define a simple LSTM-based model to classify the text data into two categories, and train the model on the padded sequences.

### Word Embedding

Word embedding is a type of text embedding that represents each word in a text sequence as a numerical vector. This approach is often used when working with text data that contains a relatively large vocabulary size. By breaking down the text into its constituent words, word embedding can capture the semantic meaning and relationships between words in the text.

Here's an example of how to create a word embedding using Python and the gensim library:

```python
import gensim
from gensim.models import Word2Vec

text = [['hello', 'world'], ['goodbye', 'world']]

# Create word2vec model
model = Word2Vec(text, min_count=1)

# Get vector representation for a word
vector = model.wv['hello']
```


In this example, we create a Word2Vec model using the gensim library. We pass in a list of sentences, where each sentence is represented as a list of words. We then use the model to get the vector representation for a specific word, in this case 'hello'.

### Sentence Embedding

Sentence embedding is a type of text embedding that represents each sentence in a text corpus as a numerical vector. This approach is often used when working with text data that contains longer sequences of text, such as paragraphs or documents. By summarizing the semantic meaning of each sentence in the corpus, sentence embedding can capture the overall meaning and context of the text.

Here's an example of how to create a sentence embedding using Python and the sentence-transformers library:

```python
from sentence_transformers import SentenceTransformer

text = ['hello world', 'goodbye world']

# Create sentence transformer model
model = SentenceTransformer('bert-base-nli-mean-tokens')

# Get vector representation for a sentence
vector = model.encode(text)
```


In this example, we create a SentenceTransformer model using the sentence-transformers library. We pass in a pre-trained model, in this case the BERT model with mean pooling, and use it to encode the list of sentences. This returns a numerical vector representation of the semantic meaning of each sentence.

### Byte Pair Encoding

Byte pair encoding (BPE) is a type of text encoding that represents each word in a text sequence as a series of byte pairs. This approach is often used when working with text data that contains a large vocabulary size and many rare or out-of-vocabulary words. By breaking down words into smaller subword units, BPE can capture the morphology and syntax of the text, while reducing the overall vocabulary size.

Here's an example of how to create a BPE encoding using Python and the sentencepiece library:

```python
import sentencepiece as spm

text = ['hello world', 'goodbye world']

# Train BPE model
spm.SentencePieceTrainer.train(input='text.txt', model_prefix='m', vocab_size=500)

# Create BPE model
sp = spm.SentencePieceProcessor()
sp.load('m.model')

# Encode text using BPE
encoded_text = [sp.encode_as_pieces(sentence) for sentence in text]
```

In this example, we use the SentencePieceTrainer class from the sentencepiece library to train a BPE model on the input text. We then create a SentencePieceProcessor object and load the trained model, and use it to encode the input text into a series of byte pairs. This returns a list of encoded subword units for each sentence in the text.

### Conclusion
Text embeddings are a powerful tool for transforming text data into numerical vectors that can be fed into machine learning models. Depending on the type of text data you are working with, different types of embeddings may be more appropriate. Character embedding, word embedding, sentence embedding, and byte pair encoding each have their own strengths and weaknesses, and can be used to extract different levels of semantic meaning from text data. By understanding the differences between these types of embeddings, you can choose the right approach for your NLP project and create more accurate and effective models.


## Numerical Examples

Here are some numerical examples for each type of text embedding:

### Character Embedding

Let's say we have the following two sentences:

"The quick brown fox jumps over the lazy dog." \\
"Pack my box with five dozen liquor jugs."

To create a character embedding for each sentence, we can convert each character to its corresponding ASCII code and represent each sentence as a matrix of shape (num_characters, embedding_size), where embedding_size is the size of the embedding vector for each character. For example, if we set embedding_size to 10, the matrix for the first sentence might look like this:

```
[[ 84. -49. -80. -32. -16.  17. -21.  42.  33. -36.]
 [ 72. -38. -16. -64. -80.  57. -79.  70. -62. -43.]
 [101. -27.  50. -80. -16.  53.  62.  43. -47. -36.]
 [ 32. -46. -64. -32. -16. -29. -10.  66. -47. -36.]
 [113. -43.  63. -16.  16.  12. -53.  62. -31. -36.]
 [117. -29.  31. -80. -16.  32. -43.  66. -32. -36.]
 [105. -47. -69. -32. -16.  45. -63.  70. -31. -36.]
 [ 99. -47.  47. -80. -16.  30. -63.  62.  33. -36.]
 [107. -39.  59. -80. -16.  63. -53.  66. -62. -36.]
 [ 32. -46. -64. -32. -16. -29. -10.  66. -47. -36.]
 [102. -29.  63. -80. -16.  12. -43.  66.  33. -36.]], 
```

### Word Embedding

Let's say we have the same two sentences as before:

"The quick brown fox jumps over the lazy dog." \\
"Pack my box with five dozen liquor jugs."

To create a word embedding for each sentence, we first need to tokenize the sentences into individual words. We can do this using Python's nltk library:

```python
import nltk
nltk.download('punkt')

sentence1 = "The quick brown fox jumps over the lazy dog."
sentence2 = "Pack my box with five dozen liquor jugs."

tokens1 = nltk.word_tokenize(sentence1)
tokens2 = nltk.word_tokenize(sentence2)
```

Next, we can use a pre-trained word embedding model like Word2Vec to create embeddings for each word. For example, we can use the gensim library to load a pre-trained Word2Vec model and get the embedding for the word "quick":

```python
import gensim.downloader as api

model = api.load('word2vec-google-news-300')

embedding = model['quick']
print(embedding)
```

This will output a 300-dimensional vector representing the word "quick".

We can then create a matrix of shape (num_words, embedding_size) for each sentence by concatenating the embeddings for each word in the sentence. For example, the matrix for the first sentence might look like this:

```
[[-0.12597656  0.11767578 -0.00286865 ... -0.05493164  0.02185059  -0.09765625]
 [ 0.16992188  0.04443359  0.25390625 ... -0.1171875   0.13183594  -0.25976562]
 [ 0.08398438 -0.11132812 -0.11914062 ... -0.10546875  0.10546875   0.01312256]
 [ 0.01977539 -0.13378906  0.12353516 ... -0.04760742 -0.01586914  -0.02636719]
 [-0.07617188  0.22265625 -0.03442383 ... -0.16015625 -0.00457764  -0.12597656]
 [-0.12890625 -0.05615234 -0.08984375 ... -0.01452637 -0.05297852   0.01062012]
 [-0.01141357  0.10253906  0.06640625 ... -0.1015625   0.02685547  -0.15429688]
 [ 0.02807617 -0.03515625 -0.10400391 ... -0.09570312  0.07958984  -0.171875  ]
 [-0.16992188 -0.12255859  0.10742188 ... -0.12695312  0.0859375  -0.18457031]]
```

### Sentence Embedding

To create a sentence embedding, we can use a pre-trained sentence embedding model like Universal Sentence Encoder (USE) from Google. We can use the tensorflow-hub library to load the pre-trained USE model and get the embedding for a sentence:

```python
import tensorflow_hub as hub

module_url = "https://tfhub.dev/google/universal-sentence-encoder/4"
model = hub.load(module_url)

sentence = "The quick brown fox jumps over the lazy dog."
embedding = model([sentence])[0]
print(embedding)
```

This will output a 512-dimensional vector representing the sentence "The quick brown fox jumps over the lazy dog."

### Byte Pair Encoding

Byte Pair Encoding (BPE) is a type of subword encoding that works by iteratively replacing the most frequent pair of bytes in a corpus with a new, unused byte symbol. This process is repeated until the desired vocabulary size is reached.

To use BPE to encode text, we first need to tokenize the text into individual characters. We can do this using Python's list function:

```python
text = "The quick brown fox jumps over the lazy dog."
tokens = list(text)
```

Next, we can use a library like subword-nmt to apply BPE to the tokens:

```python
!pip install subword-nmt

import codecs
import os
import re
import shutil
import tensorflow as tf
import subword_nmt

# Write the tokens to a file
with codecs.open('text.txt', 'w', encoding='utf8') as f:
    for token in tokens:
        f.write(token + '\n')

# Apply BPE to the tokens
subword_nmt.learn_bpe(
    input_file='text.txt',
    output_file='bpe_codes',
    num_symbols=10
)

bpe_codes = subword_nmt.apply_bpe(
    codes_path='bpe_codes',
    in_path='text.txt',
    out_path='text_bpe.txt'
)

with codecs.open('text_bpe.txt', 'r', encoding='utf8') as f:
    encoded_text = f.read().strip()
    
print(encoded_text)
```

This will output the BPE-encoded text:

```
T he @@ q ui c k @@ b ro wn @@ f ox @@ j um p s @@ ov e r @@ t he @@ l a zy @@ d og @@
```

The "@@" symbols represent the boundaries between the subword units.

Overall, these four types of encoding are commonly used in natural language processing for various tasks such as language translation, text classification, and information retrieval. Each has its strengths and weaknesses, and choosing the appropriate encoding method depends on the specific task and dataset at hand.