using JLD
m=load("Graphs/Saved_Data/yellow_payment_type_count.jld")
c=["Aug'13","sep'13","Oct'13","Nov'13","Dec'13","Jan'14","Feb'14","Mar'14","Apr'14","May'14","Jun'14","July'14","Aug'14","sep'14","Oct'14","Nov'14","Dec'14","Jan'15","Feb'15","Mar'15","Apr'15","May'15","Jun'15","July'15","Aug'15","sep'15","Oct'15","Nov'15","Dec'15"]
k1=zeros(29)
for i in 1:29
    k1[i]=m["v"][i][1]/(m["v"][i][1]+m["v"][i][2])*100
end
k2=zeros(29)
for i in 1:29
    k2[i]=m["v"][i][2]/(m["v"][i][1]+m["v"][i][2])*100
end
plot(
layer(x=c,y=k1,Geom.smooth,Geom.point, Theme(default_color=color("purple"))),
layer(x=c,y=k2,Geom.smooth,Geom.point, Theme(default_color=color("green"))),
Guide.xlabel("Month"), Guide.ylabel("Percentage of Card/Cash used"),
Guide.title("Cash vs Card Use for Yellow taxi"),
Guide.manual_color_key("Legend", ["Cash", "Card"], ["purple","green"]))