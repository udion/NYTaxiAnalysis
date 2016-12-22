#All days
function vendorperhour(dataset)
  x1=zeros(24)
  x2=zeros(24)
    for i in 1:length(dataset[:,1])
    if(dataset[i,1]==1)
      x1[Int(Dates.hour(dataset[i,2]))+1]= x1[Int(Dates.hour(dataset[i,2]))+1]+1
    elseif(dataset[i,1]==2.0)
      x2[Int(Dates.hour(dataset[i,2]))+1]= x2[Int(Dates.hour(dataset[i,2]))+1]+1
    else
      #do nothing
    end
  end
    return (x1,x2)
end

#plot for all days
x1, x2 = vendorperhour(dt)
v = [x1, x2]
save("../Graphs/Saved_Data/vendorperhour.jld","v",v)