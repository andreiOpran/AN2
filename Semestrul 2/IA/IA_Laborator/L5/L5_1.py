import numpy as np
from sklearn.utils import shuffle
from sklearn import preprocessing
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_error, mean_absolute_error, make_scorer
from sklearn.linear_model import Ridge

training_data = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L5\data\training_data.npy')
prices = np.load(r'C:\Users\andre\Desktop\AN2\Semestrul 2\IA\IA_Laborator\L5\data\prices.npy')

training_data, prices = shuffle(training_data, prices)


def normalizare(training_data_param, prices_param):
    scaler_data = preprocessing.StandardScaler()
    scaler_prices = preprocessing.StandardScaler()
    training_data_param = scaler_data.fit_transform(training_data_param)
    prices_param = scaler_prices.fit_transform(prices_param.reshape(-1, 1)).flatten()
    return training_data_param, prices_param


def regresie_liniara(training_data_param, prices_param):
    training_data_param, prices_param = normalizare(training_data_param, prices_param)
    linear_regression_model = LinearRegression()

    mean_squared_error_scorer = make_scorer(mean_squared_error)
    mean_absolute_error_scorer = make_scorer(mean_absolute_error)

    scores_mse = cross_val_score(linear_regression_model, training_data_param, prices_param, cv=3, scoring=mean_squared_error_scorer)
    scores_mae = cross_val_score(linear_regression_model, training_data_param, prices_param, cv=3, scoring=mean_absolute_error_scorer)

    mean_mse = np.mean(scores_mse)
    mean_mae = np.mean(scores_mae)

    print(f'Media MSE: {mean_mse}')
    print(f'Media MAE: {mean_mae}')


def regresie_ridge(training_data_param, prices_param):
    training_data_param, prices_param = normalizare(training_data_param, prices_param)

    alphas = [1, 10, 100, 1000]
    max_alpha = None
    max_MSE = float('inf')
    max_MAE = float('inf')

    for a in alphas:
        ridge_model = Ridge(alpha=a)

        mean_squared_error_scorer = make_scorer(mean_squared_error)
        mean_absolute_error_scorer = make_scorer(mean_absolute_error)

        scores_mse = cross_val_score(ridge_model, training_data_param, prices_param, cv=3, scoring=mean_squared_error_scorer)
        scores_mae = cross_val_score(ridge_model, training_data_param, prices_param, cv=3, scoring=mean_absolute_error_scorer)

        mean_mse = np.mean(scores_mse)
        mean_mae = np.mean(scores_mae)

        print(f'Alpha: {a} Media MSE: {mean_mse} Media MAE: {mean_mae}')

        if mean_mse < max_MSE:
            max_MSE = mean_mse
            max_MAE = mean_mae
            max_alpha = a

    print(f'Alpha-ul optim {max_alpha} MSE-ul {max_MSE} MAE-ul {max_MAE}')


def antrenare_model_ridge(training_data_param, prices_param, alph):
    training_data_param, prices_param = normalizare(training_data_param, prices_param)
    ridge_model = Ridge(alpha=alph)
    ridge_model.fit(training_data_param, prices_param)

    coeficienti = ridge_model.coef_
    print('Coeficienti (primii 5)', coeficienti[:5])
    bias = ridge_model.intercept_
    print('Bias ', bias)

    coeficienti_sortati = np.argsort(np.abs(coeficienti))
    coeficienti_sortati = coeficienti_sortati[::-1]
    cel_mai_semnificativ_coeficient = coeficienti_sortati[0]
    al_doilea_cel_mai_semnificativ_coeficient = coeficienti_sortati[1]
    cel_mai_putin_semnficativ_coeficient = coeficienti_sortati[-1]

    print()
    print(f'Cel mai semnificativ coeficient: {cel_mai_semnificativ_coeficient}')
    print(f'Al doilea cel mai semnificativ coeficient: {al_doilea_cel_mai_semnificativ_coeficient}')
    print(f'Cel mai putin semnificativ coeficient: {cel_mai_putin_semnficativ_coeficient}')


# regresie_liniara(training_data, prices)
# regresie_ridge(training_data, prices)
antrenare_model_ridge(training_data, prices, 10)