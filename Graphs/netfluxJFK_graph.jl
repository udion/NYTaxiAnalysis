using JLD
c=load("Graphs/Saved_Data/yellow_dropoff_airport.jld")
flux=zeros(29)
pickup=zeros(29)
dropoff=zeros(29)
d=["Aug'13","sep'13","Oct'13","Nov'13","Dec'13","Jan'14","Feb'14","Mar'14","Apr'14","May'14","Jun'14","July'14","Aug'14","sep'14","Oct'14","Nov'14","Dec'14","Jan'15","Feb'15","Mar'15","Apr'15","May'15","Jun'15","July'15","Aug'15","sep'15","Oct'15","Nov'15","Dec'15"]
for i=1:29
    flux[i]=c["v"][i][1]
    pickup[i]=c["v"][i][2]
    dropoff[i]=c["v"][i][3]
end
plot(
layer(x=d,y=pickup,Geom.line,Geom.point, Theme(default_color=color("purple"))),
layer(x=d,y=dropoff,Geom.line,Geom.point, Theme(default_color=color("red"))),
layer(x=d,y=flux,Geom.line,Geom.point, Theme(default_color=color("black"))),
Guide.xlabel("Month"), Guide.ylabel("Airport Count"),
Guide.title("Pickup Dropoff and net in-flux at JFK"),
Guide.manual_color_key("Legend", ["Pickup","Dropoff","Net in-flux"], ["purple","red","black"]))