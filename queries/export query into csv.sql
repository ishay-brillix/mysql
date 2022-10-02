SELECT `tbl_outbound_sms_history_2019`.`osh_id`,
    `tbl_outbound_sms_history_2019`.`osh_sender_number`,
    `tbl_outbound_sms_history_2019`.`osh_receiver_number`,
    `tbl_outbound_sms_history_2019`.`osh_via`,
    `tbl_outbound_sms_history_2019`.`osh_user_id`,
    `tbl_outbound_sms_history_2019`.`osh_campaign_id`,
    `tbl_outbound_sms_history_2019`.`osh_smpp_messageid`,
    `tbl_outbound_sms_history_2019`.`osh_message`,
    `tbl_outbound_sms_history_2019`.`osh_sms_count`,
    `tbl_outbound_sms_history_2019`.`osh_sms_status`,
    `tbl_outbound_sms_history_2019`.`osh_status_code`,
    `tbl_outbound_sms_history_2019`.`osh_universal_sms_count`,
    `tbl_outbound_sms_history_2019`.`osh_time`,
    `tbl_outbound_sms_history_2019`.`osh_response_time`,
    `tbl_outbound_sms_history_2019`.`osh_message_type`,
    `tbl_outbound_sms_history_2019`.`osh_delivery_time`,
    `tbl_outbound_sms_history_2019`.`osh_jasmin_response`,
    `tbl_outbound_sms_history_2019`.`osh_country`,
    `tbl_outbound_sms_history_2019`.`osh_dlr_notification_url`,
    `tbl_outbound_sms_history_2019`.`osh_customer_msg_id`,
    `tbl_outbound_sms_history_2019`.`osh_dlr_notifiation_method`,
    `tbl_outbound_sms_history_2019`.`osh_dlr_error`,
    `tbl_outbound_sms_history_2019`.`osh_date`,
    `tbl_outbound_sms_history_2019`.`oshOriginalID`,
    `tbl_outbound_sms_history_2019`.`osh_join_column`,
    `tbl_outbound_sms_history_2019`.`osh_api_id`,
    `tbl_outbound_sms_history_2019`.`osh_im_id`,
    `tbl_outbound_sms_history_2019`.`osh_msc`,
    `tbl_outbound_sms_history_2019`.`osh_provider`
FROM `multi_send_rmq`.`tbl_outbound_sms_history_2019`
where osh_date between '2019-03-01' and '2019-03-31'
    INTO OUTFILE '/var/lib/mysql-files/outbound_0319.csv'
    FIELDS ENCLOSED BY '"'
    TERMINATED BY ','
    ESCAPED BY '"'
    LINES TERMINATED BY '\n';