import os

projects = {
    "Insurance_Charge_Prediction": {
        "title": "Medical Insurance Charge Prediction",
        "problem": "The objective of this project is to predict medical insurance costs (charges) based on patient characteristics such as age, sex, BMI, number of children, smoking habits, and region.",
        "approach": "Exploratory Data Analysis (EDA) was performed, followed by correlation analysis. A multiple Linear Regression model was built. Assumptions of linear regression such as multicollinearity (using VIF) and heteroscedasticity (using Breusch-Pagan and White's tests) were checked.",
        "findings": "Smoking status was found to be the most significant predictor of medical insurance charges. The final multiple linear regression model explains approximately 74% of the variance in insurance charges."
    },
    "Housing_Finance_Analysis": {
        "title": "Housing Finance & Loan Analysis",
        "problem": "This project aims to analyze housing finance data to predict loan approval/amount requested using demographic and financial factors.",
        "approach": "Data preprocessing was done on the HousingFinance dataset. Logistic Regression and Decision Tree classification models were implemented to predict loan status or amount.",
        "findings": "Important factors such as credit history and applicant income play a major role in loan approval. Decision Trees provided interpretable rules for the approval process."
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
    "Sentiment_Analysis_Text_Mining": {
        "title": "Text Mining and Sentiment Analysis",
        "problem": "The objective is to extract insights and sentiments from unstructured text data such as movie reviews (IMDB, Jawan) and location reviews (Anjuna Beach, Soya).",
        "approach": "Text preprocessing (tokenization, stop words removal) was applied. Pre-trained HuggingFace models were used for advanced Sentiment Analysis on the IMDB dataset. Traditional text mining was applied to the other reviews.",
        "findings": "The HuggingFace models provided high accuracy in classifying positive and negative sentiments. Word clouds and frequency analysis highlighted the most common themes in the reviews."
    },
    "Market_Basket_Recommendation": {
        "title": "Market Basket Analysis & Recommendation System",
        "problem": "The goal is to analyze Point of Sale (POS) data to discover patterns in customer purchasing behavior and build a recommendation system.",
        "approach": "Association Rule Mining (Apriori algorithm) was used to find frequent itemsets and generate rules (Support, Confidence, Lift).",
        "findings": "Strong associations were found between certain product categories. These rules can be directly used for cross-selling and product placement in stores."
    }
}

base_path = "/Users/shariqueshafi/Documents/Data-Science-Portfolio/Projects"

for folder, data in projects.items():
    readme_path = os.path.join(base_path, folder, "README.md")
    content = f"# {data['title']}\n\n"
    content += f"## Problem Statement\n{data['problem']}\n\n"
    content += f"## Approach\n{data['approach']}\n\n"
    content += f"## Findings\n{data['findings']}\n\n"
    content += f"## Repository Structure\n- Code scripts (R/Python)\n- Datasets (CSV/Excel)\n- PDF Reports\n"
    
    with open(readme_path, "w") as f:
        f.write(content)
