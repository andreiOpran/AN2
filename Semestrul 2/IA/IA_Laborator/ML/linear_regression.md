# Linear & Ridge Regression Cheatsheet

## Introduction to Linear Regression

### What is Linear Regression?

Linear regression is a supervised machine learning algorithm used for predicting a continuous target variable based on one or more predictor variables. It models the relationship by fitting a linear equation to the observed data.

### Basic Concept

The simplest form (simple linear regression) follows the equation:
```
y = β₀ + β₁x + ε
```
Where:
- y is the target variable (dependent variable)
- x is the predictor variable (independent variable)
- β₀ is the y-intercept (bias)
- β₁ is the slope coefficient
- ε is the error term

For multiple predictors (multiple linear regression), the equation becomes:
```
y = β₀ + β₁x₁ + β₂x₂ + ... + βₙxₙ + ε
```

In matrix form:
```
y = Xβ + ε
```

### How Linear Regression Works

1. **Objective**: Find the values of coefficients (β) that minimize the sum of squared differences between observed and predicted values.
2. **Cost Function**: Usually Mean Squared Error (MSE)
3. **Solution Methods**:
   - Ordinary Least Squares (OLS): Analytical solution
   - Gradient Descent: Iterative optimization

### Key Assumptions

1. **Linearity**: The relationship between predictors and the target is linear
2. **Independence**: Observations are independent of each other
3. **Homoscedasticity**: Constant variance in errors
4. **Normality**: Errors are normally distributed
5. **No multicollinearity**: Predictors are not highly correlated

### Evaluation Metrics

1. **Mean Squared Error (MSE)**: Average of squared differences between predicted and actual values
2. **Root Mean Squared Error (RMSE)**: Square root of MSE, in same units as target
3. **Mean Absolute Error (MAE)**: Average of absolute differences
4. **R² (Coefficient of Determination)**: Proportion of variance explained by the model (0-1)

## Ridge Regression

### What is Ridge Regression?

Ridge regression is a regularized version of linear regression designed to mitigate multicollinearity and prevent overfitting.

### How it Works

Ridge regression adds a penalty term to the cost function:
```
Cost = MSE + α * (sum of squared coefficients)
```

Where α (alpha) is the regularization parameter that controls the amount of shrinkage.

### Key Differences from Linear Regression

1. **Coefficient Shrinkage**: Ridge shrinks coefficients toward zero but rarely to exactly zero
2. **Bias-Variance Tradeoff**: Increases bias slightly but decreases variance significantly
3. **Multicollinearity**: Handles correlated predictors better than linear regression
4. **Alpha Parameter**: Requires tuning to find optimal regularization strength

### When to Use Ridge Regression

- When predictors are highly correlated (multicollinearity)
- When you have many predictors relative to observations (p ≈ n or p > n)
- When you suspect overfitting with standard linear regression
- When you want to retain all features but reduce their impact

## Data Loading and Preparation

```python
# Load data from NumPy files
training_data = np.load('path/to/training_data.npy')
target_values = np.load('path/to/target_values.npy')

# Shuffle data to ensure random sampling
from sklearn.utils import shuffle
X, y = shuffle(training_data, target_values, random_state=42)

# Split data into train and test sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
    training_data, target_values, test_size=0.2, random_state=42)
```

## Data Normalization

```python
# Standardization (mean=0, std=1) - Recommended for regression
from sklearn import preprocessing

def standardize_data(X_train, y_train, X_test=None):
    # Create scalers
    X_scaler = preprocessing.StandardScaler()
    y_scaler = preprocessing.StandardScaler()
    
    # Fit and transform training data
    X_train_scaled = X_scaler.fit_transform(X_train)
    y_train_scaled = y_scaler.fit_transform(y_train.reshape(-1, 1)).flatten()
    
    # Transform test data if provided
    if X_test is not None:
        X_test_scaled = X_scaler.transform(X_test)
        return X_train_scaled, y_train_scaled, X_test_scaled, X_scaler, y_scaler
    
    return X_train_scaled, y_train_scaled, X_scaler, y_scaler

# Other normalization methods
def normalize_minmax(X_train, X_test=None):
    # Scale features to [0,1] range
    scaler = preprocessing.MinMaxScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    
    if X_test is not None:
        X_test_scaled = scaler.transform(X_test)
        return X_train_scaled, X_test_scaled, scaler
    
    return X_train_scaled, scaler

# Robust scaling (handles outliers better)
def robust_scale(X_train, X_test=None):
    scaler = preprocessing.RobustScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    
    if X_test is not None:
        X_test_scaled = scaler.transform(X_test)
        return X_train_scaled, X_test_scaled, scaler
    
    return X_train_scaled, scaler
```

## Linear Regression

```python
from sklearn.linear_model import LinearRegression

# Simple model training
def train_linear_regression(X_train, y_train):
    model = LinearRegression()
    model.fit(X_train, y_train)
    return model

# Get coefficients and intercept
def analyze_linear_model(model):
    coefficients = model.coef_
    intercept = model.intercept_
    print(f"Intercept: {intercept}")
    print(f"First 5 coefficients: {coefficients[:5]}")
    
    # Find most significant features
    most_important_idx = np.argsort(np.abs(coefficients))[::-1]
    print(f"Most important feature index: {most_important_idx[0]}")
    print(f"Second most important feature index: {most_important_idx[1]}")
    print(f"Least important feature index: {most_important_idx[-1]}")
    
    return coefficients, intercept, most_important_idx

# Prediction with linear regression
def predict_with_linear_model(model, X_test, y_scaler=None):
    predictions = model.predict(X_test)
    
    # Inverse transform if data was scaled
    if y_scaler is not None:
        predictions = y_scaler.inverse_transform(predictions.reshape(-1, 1)).flatten()
    
    return predictions
```

## Ridge Regression

```python
from sklearn.linear_model import Ridge

# Simple Ridge model training
def train_ridge_regression(X_train, y_train, alpha=1.0):
    model = Ridge(alpha=alpha)
    model.fit(X_train, y_train)
    return model

# Find optimal alpha parameter
def find_optimal_alpha(X_train, y_train, alphas=[0.1, 1.0, 10.0, 100.0], cv=5):
    from sklearn.model_selection import GridSearchCV
    
    # Set up grid search
    param_grid = {'alpha': alphas}
    ridge = Ridge()
    grid_search = GridSearchCV(ridge, param_grid, cv=cv, scoring='neg_mean_squared_error')
    
    # Fit grid search
    grid_search.fit(X_train, y_train)
    
    # Get best parameters and score
    best_alpha = grid_search.best_params_['alpha']
    best_score = -grid_search.best_score_  # Convert back to positive MSE
    
    print(f"Best alpha: {best_alpha}")
    print(f"Best MSE: {best_score}")
    
    return best_alpha, grid_search

# Manual alpha search with cross-validation
def manual_alpha_search(X_train, y_train, alphas=[1, 10, 100, 1000], cv=3):
    from sklearn.metrics import mean_squared_error, mean_absolute_error, make_scorer
    from sklearn.model_selection import cross_val_score
    
    best_alpha = None
    best_mse = float('inf')
    best_mae = float('inf')
    
    for alpha in alphas:
        ridge_model = Ridge(alpha=alpha)
        
        # Create scorers
        mse_scorer = make_scorer(mean_squared_error)
        mae_scorer = make_scorer(mean_absolute_error)
        
        # Cross-validation
        mse_scores = cross_val_score(ridge_model, X_train, y_train, cv=cv, scoring=mse_scorer)
        mae_scores = cross_val_score(ridge_model, X_train, y_train, cv=cv, scoring=mae_scorer)
        
        # Calculate mean metrics
        mean_mse = np.mean(mse_scores)
        mean_mae = np.mean(mae_scores)
        
        print(f"Alpha: {alpha} - MSE: {mean_mse:.4f} - MAE: {mean_mae:.4f}")
        
        if mean_mse < best_mse:
            best_mse = mean_mse
            best_mae = mean_mae
            best_alpha = alpha
    
    print(f"Optimal alpha: {best_alpha} - MSE: {best_mse:.4f} - MAE: {best_mae:.4f}")
    return best_alpha, best_mse, best_mae
```

## Model Evaluation

```python
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
from sklearn.model_selection import cross_val_score, KFold

# Basic evaluation metrics
def evaluate_regression_model(model, X_test, y_test, y_scaler=None):
    # Make predictions
    y_pred = model.predict(X_test)
    
    # Inverse transform if data was scaled
    if y_scaler is not None:
        y_pred = y_scaler.inverse_transform(y_pred.reshape(-1, 1)).flatten()
        y_test_original = y_scaler.inverse_transform(y_test.reshape(-1, 1)).flatten()
    else:
        y_test_original = y_test
    
    # Calculate metrics
    mse = mean_squared_error(y_test_original, y_pred)
    mae = mean_absolute_error(y_test_original, y_pred)
    rmse = np.sqrt(mse)
    r2 = r2_score(y_test_original, y_pred)
    
    print(f"Mean Squared Error: {mse:.4f}")
    print(f"Root Mean Squared Error: {rmse:.4f}")
    print(f"Mean Absolute Error: {mae:.4f}")
    print(f"R² Score: {r2:.4f}")
    
    return {'mse': mse, 'rmse': rmse, 'mae': mae, 'r2': r2}

# Cross-validation with custom metrics
def cross_validate_regression(model, X, y, cv=5):
    # Create scorers
    mse_scorer = make_scorer(mean_squared_error)
    mae_scorer = make_scorer(mean_absolute_error)
    r2_scorer = 'r2'  # Built-in R² scorer
    
    # Cross-validation
    mse_scores = -cross_val_score(model, X, y, cv=cv, scoring=mse_scorer)  # Negative because scorers are to be maximized
    mae_scores = -cross_val_score(model, X, y, cv=cv, scoring=mae_scorer)
    r2_scores = cross_val_score(model, X, y, cv=cv, scoring=r2_scorer)
    
    # Calculate mean and standard deviation
    print(f"MSE: {np.mean(mse_scores):.4f} ± {np.std(mse_scores):.4f}")
    print(f"MAE: {np.mean(mae_scores):.4f} ± {np.std(mae_scores):.4f}")
    print(f"R²: {np.mean(r2_scores):.4f} ± {np.std(r2_scores):.4f}")
    
    return {
        'mse': (np.mean(mse_scores), np.std(mse_scores)),
        'mae': (np.mean(mae_scores), np.std(mae_scores)),
        'r2': (np.mean(r2_scores), np.std(r2_scores))
    }
```

## Feature Analysis

```python
# Analyze model coefficients
def analyze_coefficients(model, feature_names=None):
    coefficients = model.coef_
    
    # Sort coefficients by absolute value
    sorted_indices = np.argsort(np.abs(coefficients))[::-1]
    sorted_coef = coefficients[sorted_indices]
    
    # Print important coefficients
    print("Most important features:")
    for i in range(min(5, len(sorted_indices))):
        idx = sorted_indices[i]
        if feature_names is not None:
            print(f"  {feature_names[idx]}: {coefficients[idx]:.4f}")
        else:
            print(f"  Feature {idx}: {coefficients[idx]:.4f}")
    
    print("\nLeast important features:")
    for i in range(min(5, len(sorted_indices))):
        idx = sorted_indices[-(i+1)]
        if feature_names is not None:
            print(f"  {feature_names[idx]}: {coefficients[idx]:.4f}")
        else:
            print(f"  Feature {idx}: {coefficients[idx]:.4f}")
    
    return sorted_indices, sorted_coef

# Compare feature importance between different models
def compare_feature_importance(linear_model, ridge_model, feature_names=None):
    linear_coef = linear_model.coef_
    ridge_coef = ridge_model.coef_
    
    # Calculate difference
    diff = np.abs(linear_coef) - np.abs(ridge_coef)
    
    # Sort by difference
    sorted_indices = np.argsort(diff)[::-1]
    
    print("Features with largest difference (Linear vs Ridge):")
    for i in range(min(5, len(sorted_indices))):
        idx = sorted_indices[i]
        if feature_names is not None:
            print(f"  {feature_names[idx]}: {linear_coef[idx]:.4f} vs {ridge_coef[idx]:.4f} (diff: {diff[idx]:.4f})")
        else:
            print(f"  Feature {idx}: {linear_coef[idx]:.4f} vs {ridge_coef[idx]:.4f} (diff: {diff[idx]:.4f})")
```

## Visualizing Results

```python
import matplotlib.pyplot as plt

# Plot predictions vs actual values
def plot_predictions(y_true, y_pred, title="Predictions vs Actual Values"):
    plt.figure(figsize=(10, 6))
    plt.scatter(y_true, y_pred, alpha=0.5)
    
    # Perfect prediction line
    min_val = min(np.min(y_true), np.min(y_pred))
    max_val = max(np.max(y_true), np.max(y_pred))
    plt.plot([min_val, max_val], [min_val, max_val], 'r--')
    
    plt.xlabel('Actual Values')
    plt.ylabel('Predicted Values')
    plt.title(title)
    plt.grid(True)
    plt.tight_layout()
    plt.show()

# Plot residuals
def plot_residuals(y_true, y_pred, title="Residual Plot"):
    residuals = y_true - y_pred
    
    plt.figure(figsize=(10, 6))
    plt.scatter(y_pred, residuals, alpha=0.5)
    plt.axhline(y=0, color='r', linestyle='--')
    plt.xlabel('Predicted Values')
    plt.ylabel('Residuals')
    plt.title(title)
    plt.grid(True)
    plt.tight_layout()
    plt.show()

# Plot feature importance
def plot_feature_importance(coefficients, feature_names=None, top_n=10):
    # Get absolute values and sort
    abs_coef = np.abs(coefficients)
    sorted_idx = np.argsort(abs_coef)[::-1]
    
    # Select top N features
    top_idx = sorted_idx[:top_n]
    top_coef = coefficients[top_idx]
    
    # Create feature labels
    if feature_names is not None:
        labels = [feature_names[i] for i in top_idx]
    else:
        labels = [f"Feature {i}" for i in top_idx]
    
    # Plot
    plt.figure(figsize=(12, 8))
    plt.barh(range(len(top_idx)), top_coef, align='center')
    plt.yticks(range(len(top_idx)), labels)
    plt.xlabel('Coefficient Value')
    plt.title('Top Feature Importance')
    plt.grid(True)
    plt.tight_layout()
    plt.show()

# Plot alpha vs. error for Ridge regression
def plot_alpha_vs_error(alphas, mse_scores, mae_scores=None):
    plt.figure(figsize=(10, 6))
    
    plt.semilogx(alphas, mse_scores, 'o-', label='MSE')
    if mae_scores is not None:
        plt.semilogx(alphas, mae_scores, 's-', label='MAE')
    
    plt.xlabel('Alpha (log scale)')
    plt.ylabel('Error')
    plt.title('Error vs. Alpha')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()
```

## Regularization Comparison

```python
from sklearn.linear_model import Lasso, ElasticNet

# Compare different regularization methods
def compare_regularization_methods(X_train, y_train, X_test, y_test, alphas=[0.1, 1.0, 10.0]):
    results = {}
    
    # Test each alpha value
    for alpha in alphas:
        # Linear Regression (no regularization)
        lr = LinearRegression()
        lr.fit(X_train, y_train)
        lr_pred = lr.predict(X_test)
        lr_mse = mean_squared_error(y_test, lr_pred)
        
        # Ridge Regression (L2 regularization)
        ridge = Ridge(alpha=alpha)
        ridge.fit(X_train, y_train)
        ridge_pred = ridge.predict(X_test)
        ridge_mse = mean_squared_error(y_test, ridge_pred)
        
        # Lasso Regression (L1 regularization)
        lasso = Lasso(alpha=alpha)
        lasso.fit(X_train, y_train)
        lasso_pred = lasso.predict(X_test)
        lasso_mse = mean_squared_error(y_test, lasso_pred)
        
        # ElasticNet (L1 + L2 regularization)
        elastic = ElasticNet(alpha=alpha, l1_ratio=0.5)
        elastic.fit(X_train, y_train)
        elastic_pred = elastic.predict(X_test)
        elastic_mse = mean_squared_error(y_test, elastic_pred)
        
        results[alpha] = {
            'linear': lr_mse,
            'ridge': ridge_mse,
            'lasso': lasso_mse,
            'elastic': elastic_mse
        }
        
        print(f"Alpha = {alpha}:")
        print(f"  Linear MSE: {lr_mse:.4f}")
        print(f"  Ridge MSE:  {ridge_mse:.4f}")
        print(f"  Lasso MSE:  {lasso_mse:.4f}")
        print(f"  Elastic MSE: {elastic_mse:.4f}")
    
    return results
```

## Tips & Best Practices

1. **Always normalize your data for regression**
   - StandardScaler is usually best for regression problems
   - Apply the same scaler to both training and test data
   - Remember to inverse transform predictions before evaluation

2. **Choosing between Linear and Ridge Regression**
   - Use Linear Regression when:
     - You have more samples than features
     - Features are not highly correlated
     - You want interpretable coefficients
   - Use Ridge Regression when:
     - Features are correlated (multicollinearity)
     - You suspect overfitting
     - You want to shrink coefficients for less important features

3. **Finding the optimal alpha for Ridge**
   - Start with a wide range (e.g., 0.01, 0.1, 1, 10, 100)
   - Narrow down once you find a promising range
   - Use cross-validation to prevent overfitting

4. **Interpreting coefficients**
   - Larger absolute coefficient value = more influential feature
   - Positive coefficient = positive correlation with target
   - Negative coefficient = negative correlation with target
   - Ridge coefficients are generally smaller than Linear Regression

5. **When results are poor, try:**
   - Adding polynomial features (feature engineering)
   - Removing outliers
   - Log-transforming skewed target variables
   - Trying different regularization approaches (Lasso, ElasticNet)