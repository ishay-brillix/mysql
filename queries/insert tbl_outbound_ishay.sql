INSERT tbl_outbound_ishay (osh_sender_number, osh_receiver_number, osh_via, osh_user_id, osh_campaign_id, osh_smpp_messageid ,osh_message,
        osh_sms_count, osh_sms_status, osh_status_code, osh_universal_sms_count, osh_time, osh_response_time, osh_message_type, osh_delivery_time, osh_jasmin_response,
        osh_country, osh_dlr_notification_url, osh_customer_msg_id, osh_dlr_notifiation_method, osh_dlr_error, osh_date, oshOriginalID, osh_msc, osh_provider, osh_im_id)
SELECT o.osh_sender_number, o.osh_receiver_number, o.osh_via, osh_user_id, o.osh_campaign_id, o.osh_smpp_messageid ,o.osh_message,
        o.osh_sms_count, j.osh_sms_status, o.osh_status_code, o.osh_universal_sms_count, o.osh_time, o.osh_response_time, o.osh_message_type,
        o.osh_delivery_time, o.osh_jasmin_response, o.osh_country, o.osh_dlr_notification_url, o.osh_customer_msg_id, o.osh_dlr_notifiation_method,
j.osh_dlr_error, DATE(o.osh_time), o.osh_id, j.jasmin_msc, j.jasmin_provider, o.osh_im_id
FROM tbl_outbound_sms_history o left join tbl_jasmin_response j on  jasmin_join_column = osh_join_column
WHERE o.osh_time >  '2019-08-02 23:59:59' 
and o.osh_time < '2019-08-04'