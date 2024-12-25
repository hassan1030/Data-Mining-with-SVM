# Pumpkin Seeds Classification Using SVM

## Project Scope
This project analyzes the geometric attributes of pumpkin seeds using a dataset that contains measurements like area, perimeter, roundness, and compactness. The dataset was selected to explore the effectiveness of machine learning, particularly Support Vector Machines (SVM), in classifying two pumpkin seed varieties: "Çerçevelik" and "Ürgüp Sivrisi." The dataset contains 2,500 observations and 13 variables, making it ideal for classification and pattern discovery.

## Dataset
- **Size**: 2,500 records with 13 variables.
- **Key Variables**:
  - `Area`: The area of the seed.
  - `Perimeter`: The perimeter of the seed.
  - `Roundness` and `Compactness`: Geometric attributes used for classification.
  - `Class`: The categorical variable indicating seed type.

## Analysis
The project aims to answer the following key questions:
1. **How accurately can we classify pumpkin seed varieties based on their geometric attributes?**
2. **What are the most influential features in differentiating between the two seed varieties?**
3. **How does tuning SVM parameters impact classification performance?**

### Steps in Analysis
1. **Data Preprocessing**:
   - Inspected and cleaned the dataset for missing values (none found).
   - Standardized column names for consistency.
   - Converted the target variable (`Class`) into a factor for classification.

2. **Visualization**:
   - Scatterplot of `Roundness` vs. `Compactness` shows strong positive correlation and distinct clustering patterns for each class.
   - Bar plot illustrates a balanced distribution of classes, ensuring unbiased model training.

3. **Model Training**:
   - The dataset was split into training (80%) and testing (20%) sets.
   - Features were scaled to normalize the range of values, improving SVM performance.
   - An SVM model with a radial kernel was trained on the scaled data.

4. **Gamma Tuning**:
   - The SVM model's performance was evaluated with different kernels (linear, polynomial, radial, sigmoid) and varying `gamma` parameters.
   - The radial kernel achieved the best accuracy (88.4%) with default gamma settings.

5. **Model Evaluation**:
   - The confusion matrix revealed:
     - Accuracy: **88.4%**
     - Sensitivity: **90%** (correctly identifying "Çerçevelik").
     - Specificity: **86.67%** (correctly identifying "Ürgüp Sivrisi").

## Key Findings
1. `Roundness` and `Compactness` are highly effective features for classification, as shown by their strong correlation and distinct clustering.
2. The radial kernel outperformed other kernels, demonstrating its ability to handle non-linear relationships in the data.
3. A balanced class distribution ensured robust model performance without bias toward either class.

## Conclusion
The study successfully demonstrated the potential of machine learning in classifying pumpkin seed varieties with high accuracy. The radial SVM model performed exceptionally well, achieving balanced accuracy across both classes. The findings suggest that geometric attributes like roundness and compactness are critical for differentiating between "Çerçevelik" and "Ürgüp Sivrisi."

## Future Considerations
1. **Incorporating Additional Features**:
   - Including textural or color features could enhance model performance.
   - Adding environmental data like geographical origin or growing conditions might provide deeper insights.
2. **Exploring Advanced Models**:
   - Using ensemble methods like Random Forests or Gradient Boosting could improve accuracy further.
   - Automated hyperparameter tuning could optimize SVM parameters more effectively.

