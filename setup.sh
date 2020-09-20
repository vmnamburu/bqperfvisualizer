bq rm -f orders_ds.customer_transactions
bq rm -f orders_ds.customer_sessions
bq rm -d orders_ds
bq mk -d orders_ds
bq mk --table --schema orders_ds.customer_transactions.json --time_partitioning_field transaction_date orders_ds.customer_transactions
bq mk --table --schema orders_ds.customer_sessions.json --time_partitioning_field transaction_date orders_ds.customer_sessions
sh populate_customer_transactions.sh
sh populate_customer_sessions.sh
