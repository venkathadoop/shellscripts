for i in `cat /home/test6/word.txt` # required table content.
do
         if grep "$i" /home/test6/databases.txt; then # all tables required
			echo "Found $i" >> /home/test6/matchfound-out.txt
         else
            echo "Not found $i" >> /home/test6/matchnotfount.txt
         fi
done
