load data 
 infile 'gen/data/downloads/archive_question_stageOP.csv' 
 into table archive_question_stageOP
 fields terminated by "," optionally enclosed by '"' 
 (QUIZID,STARTDATE,ENDDATE,SCORE,TRANSACTIONID,QUESTIONINGSTYLETYPEFIELD
)
