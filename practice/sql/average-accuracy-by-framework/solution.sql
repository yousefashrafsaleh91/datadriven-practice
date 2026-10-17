SELECT
  lower(framework) framework,
  round(AVG(accuracy),2) avg_accuracy
FROM ml_models
WHERE  framework in ('PyTorch','TensorFlow','XGBoost','tensorflow')
group by lower(framework)
