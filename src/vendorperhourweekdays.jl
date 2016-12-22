#Weekdays
function vendorperhourweekdays(dataset)
  x1=zeros(24)
  x2=zeros(24)
  date_filter=dt[Dates.dayofweek(dt[:,2]) .<=5,:];
  row=size(date_filter)[1]
  for i in 1:row
    if(date_filter[i,1]==1.0)
      x1[Dates.hour(dataset[i,2])+1]+=1
    elseif(date_filter[i,1]==2.0)
      x2[Dates.hour(date_filter[i,2])+1]+=1
    else
      #do nothing
    end
  end
    return (x1,x2)
end
#plot for weekdays
x1,x2=vendorperhourweekdays(dt)

v = [x1, x2]
save("../Graphs/Saved_Data/vendorperhourweekdays.jld","v",v)