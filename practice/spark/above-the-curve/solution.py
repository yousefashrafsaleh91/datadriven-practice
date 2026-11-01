from pyspark.sql import functions as F
from pyspark.sql.window import Window

# 1. Calculate each user's total spend
user_totals = transactions.groupBy("user_id").agg(
    F.sum("total_amount").alias("total_spend")
)

# 2. Define a global window to calculate the average spend across all users
global_window = Window.partitionBy()

# 3. Add the benchmark, filter, calculate the difference, and order
result_df = user_totals \
    .withColumn("avg_spend", F.avg("total_spend").over(global_window)) \
    .filter(F.col("total_spend") > F.col("avg_spend")) \
    .withColumn("amount_above_average", F.col("total_spend") - F.col("avg_spend")) \
    .select("user_id", "total_spend", "amount_above_average") \
    .orderBy(F.col("total_spend").desc())

# Show the top high-value customers
result_df.show()
