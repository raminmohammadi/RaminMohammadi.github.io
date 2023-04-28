---
title: Text Cleaning
subtitle: by Ramin Mohammadi
date: 2022-03-20 00:00:00
description: 
featured_image: '/images/demo/demo-square.jpg'
author: Ramin Mohammadi
categories: nlp
---

A Beginner's Guide to Text Cleaning with Python
If you've ever worked with text data, you probably know how messy it can be. Whether you're dealing with tweets, emails, or news articles, text data often contains inconsistencies, misspellings, and irrelevant information that can negatively affect your analysis. Text cleaning, also known as text preprocessing, is the process of transforming raw text data into a clean and structured format that can be analyzed with ease. In this tutorial, we'll walk you through the necessary steps to clean text data using Python.

### Step 1: Import necessary libraries

The first step in any Python project is to import the necessary libraries. In this tutorial, we'll be using the following libraries:

`re` (short for regular expressions) for pattern matching and text manipulation
nltk (Natural Language Toolkit) for text processing and analysis
string for string manipulation
Here's how you can import them:

```python
import re
import nltk
import string

nltk.download('punkt')
```


The `nltk.download('punkt')` line downloads the necessary data for tokenization, which we'll be using later in this tutorial.

### Step 2: Load the raw text data

The next step is to load the raw text data that you want to clean. In this tutorial, we'll be using a sample text file containing the first paragraph of Charles Dickens' A Tale of Two Cities:

```python
with open('raw_text.txt', 'r') as file:
    text = file.read()
```

Replace `raw_text.txt` with the path to your own text file.

### Step 3: Remove special characters and punctuation

Special characters and punctuation can often be noise in text data. They don't contribute to the meaning of the text and can make it harder to analyze. To remove them, we'll use the `re` library:

```python
text = re.sub(r'\d+', '', text) # remove digits
text = re.sub(r'[^\w\s]', '', text) # remove special characters and punctuation
```

The first line removes any digits from the text using the regular expression `\d+`. The second line removes any characters that are not alphanumeric or whitespace using the regular expression `[^\w\s]`.

### Step 4: Convert text to lowercase

Converting all the text to lowercase can help with consistency and reduce the number of unique words in the text. We can do this easily with the `lower()` function:

```python
text = text.lower()
```

### Step 5: Tokenize the text

Tokenization is the process of splitting the text into individual words or tokens. We can use the `nltk` library to tokenize the text:

```python
tokens = nltk.word_tokenize(text)
```

This will create a list of tokens that we can work with.

### Step 6: Remove stop words

Stop words are common words in a language that don't contribute much to the meaning of the text, such as "the", "and", and "a". We can remove them to reduce noise and improve analysis:

```python
stop_words = nltk.corpus.stopwords.words('english')
tokens = [token for token in tokens if token not in stop_words]
```

This will create a new list of tokens without any stop words.

### Step 7: Stemming or Lemmatization

Stemming and lemmatization are techniques used to reduce words to their root form. This can help with consistency and reduce the number of unique words in the text. We'll be using the Porter Stemmer algorithm, which is available in the nltk library:

```python
porter = nltk.PorterStemmer()
stemmed_tokens = [porter.stem(token) for token in tokens]
```

Alternatively, you can use lemmatization which maps words to their root form based on their part of speech tag. For example, "running" and "ran" would both be mapped to "run". Here's how you can do it using the WordNetLemmatizer class from the nltk library:

```python
lemmatizer = nltk.WordNetLemmatizer()
lemmatized_tokens = [lemmatizer.lemmatize(token) for token in tokens]
```

### Step 8: Join the tokens back into text
After cleaning, stemming or lemmatizing the tokens, we can join them back into a clean text format. Here's how you can do it:

```python
clean_text = ' '.join(stemmed_tokens) # or lemmatized_tokens
```


This will create a clean text string that can be analyzed or stored.

## Conclusion

Text cleaning is an essential step in any text analysis project. By removing noise and inconsistencies, you can improve the accuracy and reliability of your analysis. In this tutorial, we've covered the basic steps for cleaning text data using Python, including removing special characters and punctuation, converting text to lowercase, tokenizing the text, removing stop words, and stemming or lemmatizing the tokens. With these techniques, you can clean and preprocess your text data for further analysis.
