SET PAGESIZE 0
SET TRIMSPOOL ON
SET RECSEP OFF
SET COLSEP ","
SET FEEDBACK OFF
SET TERMOUT OFF
SET LINESIZE 10000
SPOOL gen/tmp/colnames_archive_question_stageOP.txt REPLACE 
select column_name from USER_TAB_COLUMNS WHERE table_name = UPPER('archive_question_stageOP');
SPOOL OFF 
EXIT