#!/bin/bash # -vx
# starts various development processes

case "$1" in

# autotest
# aut) autotest --no-full-after-failed
#    ;;
# guard
grd) guard --notify false
   ;;
# mongo
mon) mongod run --config /usr/local/Cellar/mongodb/1.8.2-x86_64/mongod.conf
   ;;
# rails
rls) rails server
   ;;
# sdoc
sdc) #idea: add bundle before this & call it "bundoc"
   export gemdir="$(rvm gemset dir)/gems"
   (cd $gemdir
   echo $gemdir
   pwd
   date
   for d in $(ls)
   do
      echo $d
      (cd $d
      pwd
      sdoc --format=sdoc -O --op=/Users/laripk/Projects/stored_sheet/.dev/docs -g -v      
      date
      )
   done
   ) # cd ~/Projects/stored_sheet
   ;;
# sinatra
# sin) ruby ~/Projects/stored_sheet/stored_sheet.rb
#    ;;
*) echo "Invalid option. Options are: grd, mon, rls, sdc"
   ;;
esac
