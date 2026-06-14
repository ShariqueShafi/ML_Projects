import os

projects = {
    "Insurance_Charge_Prediction": {
        "title": "Medical Insurance Charge Prediction",
        "problem": "The objective of this project is to predict medical insurance costs (charges) based on patient characteristics such as age, sex, BMI, number of children, smoking habits, and region.",
        "approach": "Exploratory Data Analysis (EDA) was performed, followed by correlation analysis. A multiple Linear Regression model was built. Assumptions of linear regression such as multicollinearity (using VIF) and heteroscedasticity (using Breusch-Pagan and White's tests) were checked.",
        "findings": "Smoking status was found to be the most significant predictor of medical insurance charges. The final multiple linear regression model explains approximately 74% of the variance in insurance charges."
    },
    "Housing_Finance_Logistic_Regression": {
        "title": "Housing Finance & Loan Analysis (Logistic Regression)",
        "problem": "This project aims to analyze housing finance data to predict loan approval using demographic and financial factors.",
        "approach": "Data preprocessing was done on the HousingFinance dataset. A Logistic Regression classification model was implemented to predict loan status.",
        "findings": "Important factors such as credit history and applicant income play a major role in loan approval. The logistic regression model achieved strong predictive accuracy."
    },
    "Housing_Finance_Decision_Tree": {
        "title": "Housing Finance & Loan Analysis (Decision Tree)",
        "problem": "This project aims to analyze housing finance data to predict loan approval using demographic and financial factors.",
        "approach": "A Decision Tree classification model was implemented to predict loan status, providing interpretable rules for the approval process.",
        "findings": "Important factors such as credit history and applicant income were identified as the root nodes for loan approval."
    },
    "Hospital_Cost_Analysis": {
        "title": "Total Cost to Hospital Analysis",
        "problem": "The goal is to analyze the total cost incurred by the hospital per patient and identify the key drivers using patient demographics and medical history.",
        "approach": "Data cleaning and preprocessing were performed. Logistic Regression and multiple regression techniques were applied to understand the impact of various predictors on the total cost.",
        "findings": "Certain treatments and length of stay significantly impact the total hospital cost. The logistic regression model helps in predicting high-cost patients."
    },
    "Customer_Segmentation_Churn": {
        "title": "Customer Segmentation & Churn Prediction",
        "problem": "This project focuses on segmenting customers based on their purchasing behavior and predicting customer churn to improve retention strategies.",
        "approach": "RFM (Recency, Frequency, Monetary) analysis was conducted. K-Means clustering was applied to segment the customers into distinct groups based on their value. Churn prediction models were also explored.",
        "findings": "Customers were successfully segmented into high-value, at-risk, and churned groups. The K-Means clusters helped in tailoring targeted marketing strategies."
    },
    "Market_Basket_Recommendation": {
        "title": "Market Basket Analysis & Recommendation System",
        "problem": "The goal is to analyze Point of Sale (POS) data to discover patterns in customer purchasing behavior and build a recommendation system.",
        "approach": "Association Rule Mining (Apriori algorithm) was used to find frequent itemsets and generate rules (Support, Confidence, Lift).",
        "findings": "Strong associations were found between certain product categories. These rules can be directly used for cross-selling and product placement in stores."
    },
    "Sentiment_Analysis_IMDB": {
        "title": "IMDB Movie Review Sentiment Analysis",
        "problem": "The objective is to classify IMDB movie reviews into positive and negative sentiments.",
        "approach": "A pre-trained HuggingFace transformer model was utilized to perform advanced Sentiment Analysis on the IMDB dataset.",
        "findings": "The HuggingFace pipeline achieved high accuracy in classifying sentiments, demonstrating the power of transfer learning in NLP."
    },
    "Sentiment_Analysis_Jawan_Movie": {
        "title": "Jawan Movie Review Sentiment Analysis",
        "problem": "The objective is to extract and analyze audience sentiments from reviews of the movie 'Jawan'.",
        "approach": "Text preprocessing and sentiment scoring techniques were applied to classify user reviews into positive, negative, and neutral sentiments.",
        "findings": "The analysis highlighted key themes and overall audience reception, showing predominantly positive/mixed sentiments based on specific movie aspects."
    },
    "Sentiment_Analysis_Anjuna_Beach": {
        "title": "Anjuna Beach Text Mining & Sentiment Analysis",
        "problem": "To understand tourist experiences and sentiments based on textual reviews of Anjuna Beach.",
        "approach": "Text mining techniques including tokenization, stop-word removal, and frequency analysis were employed to extract insights from the textual data.",
        "findings": "Word clouds and frequency distributions revealed the most common positive and negative experiences reported by tourists."
    },
    "Sentiment_Analysis_Soya_Review": {
        "title": "Soya Product Review Sentiment Analysis",
        "problem": "To analyze consumer feedback and sentiments regarding Soya products.",
        "approach": "Natural Language Processing (NLP) techniques were used to clean the text data and perform sentiment classification.",
        "findings": "The sentiment analysis provided actionable insights into product quality and customer satisfaction levels."
    },
    "Sentiment_Analysis_Kotkin_Comments": {
        "title": "Kotkin Comments Sentiment Analysis",
        "problem": "To analyze public comments and extract sentiment.",
        "approach": "Standard NLP preprocessing and sentiment analysis pipelines were utilized to process the comments dataset.",
        "findings": "The distribution of sentiments provided insights into public opinion regarding the specified topics."
    },
    "Sentiment_Analysis_Tweeter": {
        "title": "Twitter Sentiment Analysis",
        "problem": "To classify tweets into different sentiment categories to gauge public opinion.",
        "approach": "Text mining and sentiment scoring algorithms were applied to the tweet data.",
        "findings": "The analysis successfully categorized the tweets, revealing the dominant public sentiment."
    },
    "Sentiment_Analysis_YouTube": {
        "title": "YouTube Video Sentiment Analysis",
        "problem": "To analyze audience sentiment from YouTube video data.",
        "approach": "NLP techniques were used to extract and analyze textual data related to YouTube videos.",
        "findings": "The findings highlighted the overall sentiment trend and audience reaction to the video content."
    },
    "WSMA_Youtube_Text_Modeling": {
        "title": "YouTube Comments Text Data Modeling",
        "problem": "To analyze YouTube comments and extract underlying conceptual frameworks and audience engagement metrics.",
        "approach": "Text data was scraped using the YouTube Data API. Regression models and hypothesis testing were used to evaluate the impact of different comment features on user engagement.",
        "findings": "Specific linguistic features and sentiments in comments significantly influence video engagement and viewer interaction."
    },
    "WSMA_Indian_Election_Tweet_Analysis": {
        "title": "Indian Election 2019 Tweet Toxicity Analysis",
        "problem": "To detect and analyze toxicity, hate speech, and aggression in tweets related to the 2019 Indian Elections.",
        "approach": "A dataset of election-related tweets was analyzed using NLP models to classify tweets based on toxicity levels.",
        "findings": "The analysis revealed patterns in aggressive political discourse and highlighted the prevalence of toxic speech during the election period."
    },
    "MLWBA_LendingClub_Defaults": {
        "title": "Predicting LendingClub Loan Defaults",
        "problem": "To help LendingClub reduce credit losses by predicting loan defaults before loans are approved.",
        "approach": "A classification model was built to predict loan defaults. Derived features such as credit length and loan-to-income ratio were engineered to align with risk policy.",
        "findings": "The model successfully benchmarked against existing repositories, providing a deployable approval-time model to strengthen investor confidence."
    }
}

base_path = "/Users/shariqueshafi/Documents/ML-Projects/Projects"

for folder, data in projects.items():
    readme_path = os.path.join(base_path, folder, "README.md")
    content = f"# {data['title']}\n\n"
    content += f"## Problem Statement\n{data['problem']}\n\n"
    content += f"## Approach\n{data['approach']}\n\n"
    content += f"## Findings\n{data['findings']}\n\n"
    content += f"## Repository Structure\n- Code scripts (R/Python/.ipynb)\n- Datasets (CSV/Excel)\n- Problem Statements/Reports (PDF/HTML)\n"
    
    with open(readme_path, "w") as f:
        f.write(content)
    print(f"Generated README for {folder}")
