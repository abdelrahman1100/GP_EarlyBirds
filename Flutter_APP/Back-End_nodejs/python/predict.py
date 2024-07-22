import sys
import joblib
from sklearn.feature_extraction.text import TfidfVectorizer
import nltk
import sys
import json
# Load the model and vectorizer
model = joblib.load('MLData/model3.joblib')
vectorizer = joblib.load('MLData/tfidf_vectorizer3.pkl')
import sklearn
import numpy

# Retrieve scikit-learn version
sklearn_version = sklearn.__version__

# Retrieve NumPy version
numpy_version = numpy.__version__


def preprocess_text(text):
   
    nltk.download('stopwords', quiet=True)
    nltk.download('punkt', quiet=True)
    from nltk.corpus import stopwords
    from nltk.tokenize import word_tokenize
    from nltk.stem import WordNetLemmatizer
    import string

    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    tokens = word_tokenize(text.lower())
    tokens = [lemmatizer.lemmatize(token) for token in tokens if token not in stop_words and token not in string.punctuation]
    return ' '.join(tokens)

# Get comment from command line arguments
comment = json.loads(sys.stdin.read())

# Preprocess and vectorize comment
processed_comment = preprocess_text(comment)
vectorized_comment = vectorizer.transform([processed_comment])

if vectorized_comment.shape[1] != model.n_features_in_:
    raise ValueError(f"Expected {model.n_features_in_} features, got {vectorized_comment.shape[1]} features.")


# Predict
prediction = model.predict(vectorized_comment)

# Print prediction
prediction_list = prediction.tolist()
print(json.dumps(prediction_list))
