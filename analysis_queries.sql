-- Using Join and Aggregate
select date_trunc(ct.transaction_date,MONTH) transaction_month
,sum(transaction_amount) transaction_amount
,cast(sum(session_duration)/(60*60) as INT64) session_duration
from `orders_ds.customer_transactions`  ct join `orders_ds.customer_sessions` cs
on ct. transaction_id = cs. transaction_id
group by 1
--bq-arrays:US.bquxjob_64092a23_174a36d6c60
--slot time : 1 min 34.738 sec
--elapsed time : 2.1 sec

-- Using Aggregate and Union
select  transaction_month,sum(transaction_amount) transaction_amount,sum(session_duration) session_duration
from 
(select date_trunc(transaction_date,MONTH) transaction_month,sum(transaction_amount) transaction_amount,0 session_duration
from `orders_ds.customer_transactions`
group by 1
union all
select date_trunc(transaction_date,MONTH) transaction_month,0 transaction_amount,sum(session_duration) session_duration
from `orders_ds.customer_sessions`
group by 1
)
group by 1
