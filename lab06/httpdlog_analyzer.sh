logFile=./access.log
cat $logFile | awk '/GET \/ HTTP/{ ipcount[$1]++ } END { for (i in ipcount) { printf "IP:%13s - %d times\n", i, ipcount[i] } }' | sort -rn | head -20

cat $logFile | awk '/GET \/ HTTP/{ ipcount[$1]++ } END { for (i in ipcount) { printf "IP:%13s - %d times\n", i, ipcount[i] } }' | sort -rn 
