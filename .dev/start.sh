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
# sinatra
# sin) ruby ~/Projects/stored_sheet/stored_sheet.rb
#    ;;
*) echo "Invalid option. Options are: grd, mon, rls"
   ;;
esac
