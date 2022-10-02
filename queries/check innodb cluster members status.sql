SELECT MEMBER_HOST,MEMBER_STATE,MEMBER_ROLE, COUNT_TRANSACTIONS_IN_QUEUE TRX_LOCAL_Q,                
COUNT_TRANSACTIONS_REMOTE_IN_APPLIER_QUEUE TRX_APPLY_Q         
FROM performance_schema.replication_group_member_stats t1         
JOIN performance_schema.replication_group_members t2          
 ON t2.MEMBER_ID=t1.MEMBER_ID