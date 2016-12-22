#function to anayse the distribution of vendors
function vendorweekly()
    numVendor1weekly=zeros(Int,7);
    numVendor2weekly=zeros(Int,7);
    total = zeros(Int,7)
    
    [ dt[i,1]==1? numVendor1weekly[Int(Dates.dayofweek(dt[i,2]))]+=1 : numVendor2weekly[Int(Dates.dayofweek(dt[i,2]))]+=1 for i in 1:length(dt[:,2])]
    total=numVendor1weekly+numVendor2weekly
    
    return numVendor1weekly, numVendor2weekly, total
end
ven1, ven2, total = vendorweekly()

v = [ven1, ven2, total]
save("../Graphs/Saved_Data/vendorweekly.jld","v",v)

c=["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
Gadfly.plot(
layer( x=c, y=ven1,Geom.point, Geom.line, Theme(default_color=color("blue")) ),
layer( x=c, y=ven2,Geom.point, Geom.line, Theme(default_color=color("purple"))),
layer( x=c, y=total,Geom.point, Geom.line, Theme(default_color=color("green"))),
Guide.ylabel("vendor frequency"),
Guide.xlabel("days in weeks Jan"),
Guide.title("frequency of vendors"),
Guide.manual_color_key("Legend", ["vendor1", "vendor2", "total"], ["blue", "purple", "green"])
)
