/* Big Big Channel’s raw data is ready now, please kindly find the raw data in below 2 tables. */

/*
Stream View
UA-48:   BBCL iOS (Live)
UA-49:   BBCL Android (Live)
UA-50:   BBCL Android (non-Live)
UA-51:   BBCL iOS (non-Live)
*/
select *
from SC_ETL_NEW.dbo.IMPORTSTREAM_NEW
where HKDATE = '2017-10-23'
and UA in ('48', '49', '50', '51')

/*
Page View
UA-84:   BBCL iOS
UA-85:   BBCL Android
*/
select *
from SC_ETL_NEW.dbo.IMPORTWEB
where HKDATE = '2017-10-23'
and UA in ('84', '85')


/* Please kindly refer to below table for the summarized stream views. (this table refreshes everyday) */

/*
Stream View
UA-48:   BBCL iOS (Live)
UA-49:   BBCL Android (Live)
UA-50:   BBCL Android (non-Live)
UA-51:   BBCL iOS (non-Live)
*/
select *
from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY
where convert(date, HKDATETIME) = '2017-10-23'
and UA in ('48', '49', '50', '51')


/* You may now try to aggregate the daily performance figures report for page view, stream view, unique browser, time spent, etc. */
