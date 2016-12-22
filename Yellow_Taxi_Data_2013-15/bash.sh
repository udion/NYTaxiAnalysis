#for i in {8..9};
#do
 # echo item: $i
  #sed -e '2d' yellow_tripdata_2013-0$i.csv > temp.csv 
  #cat temp.csv > yellow_tripdata_2013-0$i.csv
#done

for i in {8..9};
do
  echo item: $i
  cat yellow_tripdata_2013-0$i.csv > temp.csv
  sed -i 's/CMT/1/g' temp.csv
  sed -i 's/VTS/2/g' temp.csv
  cat temp.csv > yellow_tripdata_2013-0$i.csv
done

for i in {10..12};
do
  echo item: $i
  cat yellow_tripdata_2013-$i.csv > temp.csv
  sed -i 's/CMT/1/g' temp.csv
  sed -i 's/VTS/2/g' temp.csv
  cat temp.csv > yellow_tripdata_2013-$i.csv
done