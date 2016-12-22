using Clustering
using JLD
b=load("Graphs/Saved_Data/vendorcount_green_per_month.jld")
a=load("Graphs/Saved_Data/vendorcount_yellow_per_month.jld")
x1=zeros(29)
x2=zeros(29)
for i in 1:29
    x1[i]=a["v"][i][1]+a["v"][i][2]
    x2[i]=b["v"][i][1]+b["v"][i][2]
end
c=["Aug'13","sep'13","Oct'13","Nov'13","Dec'13","Jan'14","Feb'14","Mar'14","Apr'14","May'14","Jun'14","July'14","Aug'14","sep'14","Oct'14","Nov'14","Dec'14","Jan'15","Feb'15","Mar'15","Apr'15","May'15","Jun'15","July'15","Aug'15","sep'15","Oct'15","Nov'15","Dec'15"]
plot(layer(x=c,y=x1,Geom.point, Geom.line,order=1,Theme(default_color=color("Yellow"))),
layer(x=c,y=x2,Geom.point, Geom.line,order=2,Theme(default_color=color("Green"))),
Guide.xlabel("Month"), Guide.ylabel("No of Pickups"),
Guide.title("Monthly comparison of Yellow vs Green Taxis"),
Guide.manual_color_key("Legend", ["Yellow Taxi", "Green Taxi"], ["Yellow","Green"]))