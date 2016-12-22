#Airport Pickup per hour of day
row,column=size(dt)
tempdatasetpick=dt[:,[2,6,7]];
function JFKirportpickupperhour(tempdataset,row)
  v=(-73.788040,40.658410)
  count=zeros(24)
  for i in 1:row
    s=0.0
    for j in 2:3
      s+=(tempdataset[i,j]-v[j-1])^2
    end
    s=sqrt(s)
    if(s<.0181)
      count[Dates.hour(tempdataset[i,1])+1]=count[Dates.hour(tempdataset[i,1])+1]+1
    end
  end
  return count
end

#Airport Dropoff per hour of month
row,column=size(dt)
tempdatasetdrop=dt[:,[3,10,11]];
  v=(-73.788040,40.658410)
  function JFKirportdropoffperhour(tempdataset,row)
  count=zeros(24)
  for i in 1:row
    s=0.0
    for j in 2:3
      s+=(tempdataset[i,j]-v[j-1])^2
    end
      s=sqrt(s)
    if(s<.0181)
      count[Dates.hour(tempdataset[i,1])+1]=count[Dates.hour(tempdataset[i,1])+1]+1
    end
  end
  return count
end


#graph for pickup per hour
x1=JFKirportpickupperhour(tempdatasetpick,row)
x2=JFKirportpickupperhour(tempdatasetdrop,row)

v = [x1, x2]
save("Graphs/Saved_Data/JFKportperhour.jld","v",v)