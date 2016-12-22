#Weekends
function vendorperhourweekend(dataset)
  x1=zeros(24)
  x2=zeros(24)
  date_filter=dt[Dates.dayofweek(dt[:,2]) .>5,:];
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
#plot for weekends
x1,x2=vendorperhourweekend(dt)

v = [x1, x2]
save("../Graphs/Saved_Data/vendorperhourweekend.jld","v",v)

Gadfly.plot(layer(x=1:24,y=x1,Geom.point, Geom.line,order=1,Theme(default_color=color("blue"))),
layer(x=1:24,y=x2,Geom.point, Geom.line,order=2,Theme(default_color=color("purple"))),
Guide.xlabel("Hours of day"), Guide.ylabel("No of vehicles"),
Guide.title("Weekend comparison of Vendor 1 vs Vendor 2 (Per Hour)"),
Guide.manual_color_key("Legend", ["Vendor1", "Vendor2"], ["blue", "purple"]))