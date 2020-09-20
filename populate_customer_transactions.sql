insert into orders_ds.customer_transactions
(transaction_id,customer_id,transaction_date,transaction_amount)
with generate_timestamps as
(
  select generate_timestamp_array(@StartTimeStamp,@EndTimeStamp,interval 5 second) transaction_dates
),
transactions as
(
  select
  UNIX_MILLIS(tdts) transaction_id
  ,cast(rand()*1000 as INT64) customer_id
  ,date(tdts) transaction_date
  ,cast(rand()*10000 as INT64) transaction_amount
  from generate_timestamps,unnest(transaction_dates) tdts
)
select * from transactions
