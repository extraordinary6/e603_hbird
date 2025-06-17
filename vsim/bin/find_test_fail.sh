#!/bin/bash
ok=`grep '$finish at simulation time' $1 | wc -l`
if [ $ok -eq "0" ];
then 
  err=`grep "Error" $1 | wc -l`
  if [ $err -eq "0" ];
  then 
      echo -e "NOT_FINISHED $1"
  else
      echo -e "ERROR $1"
  fi
else
    #test_fails=`grep 'TEST_FAIL : *[0-9]*' $1  | sed 's/.*TEST_FAIL : *\([0-9]*\).*/\1/g'`
    test_passes=`grep "TEST_PASS" $1 | wc -l`
    res=`expr $test_passes + 0`
    if [ $res -ne 0 ];
    then 
        echo -e "PASS $1";
    else 
        echo -e "FAIL $1";
    fi
fi

