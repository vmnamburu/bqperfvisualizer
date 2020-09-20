insert into orders_ds.customer_sessions
(transaction_id,transaction_date,session_duration)
with generate_timestamps as
(
  select generate_timestamp_array(@StartTimeStamp,@EndTimeStamp,interval 5 second) transaction_dates
),
sessions as
(
  select
  UNIX_MILLIS(tdts) transaction_id
  ,date(tdts) transaction_date
  ,cast(rand()*600 as INT64) session_duration
  from generate_timestamps,unnest(transaction_dates) tdts
)
select * from sessions
