#Airport Pickup per day of week
row,column=size(dt)
tempdatasetpick=dt[:,[2,6,7]];
function JFKirportpickupperday(tempdataset,row)
  v=(-73.788040,40.658410)
  count=zeros(7)
  for i in 1:row
    s=0.0
    for j in 2:3
      s+=(tempdataset[i,j]-v[j-1])^2
    end
    s=sqrt(s)
    if(s<.0181)
      count[Int(Dates.dayofweek(tempdataset[i,1]))]=count[Int(Dates.dayofweek(tempdataset[i,1]))]+1
    end
  end
  return count
end

#Airport Dropoff per day of week
row,column=size(dt)
tempdatasetdrop=dt[:,[3,10,11]];
function JFKirportdropoffperday(tempdataset,row)
  v=(-73.788040,40.658410)
  count=zeros(7)
  for i in 1:row
    s=0.0
    for j in 2:3
      s+=(tempdataset[i,j]-v[j-1])^2
    end
    s=sqrt(s)
    if(s<.0181)
      count[Int(Dates.dayofweek(tempdataset[i,1]))]=count[Int(Dates.dayofweek(tempdataset[i,1]))]+1
    end
  end
  return count
end


#graph for pickup per day
x1=JFKirportpickupperday(tempdatasetpick,row)
x2=JFKirportdropoffperday(tempdatasetdrop,row)
v = [x1, x2]
save("Graphs/Saved_Data/JFKportperday.jld","v",v)