using JLD
m=load("Graphs/Saved_Data/regressionmodels_vendor_wise.jld")
coefficient_v1=m["v"][1][1][1,1]+m["v"][1][1][4,2]*5
slope_v1=m["v"][1][1][1,3]*60000
coefficient_v2=m["v"][1][2][1,1]+m["v"][1][2][4,2]*5
slope_v2=m["v"][1][2][1,3]*60000
c=0:30
plot(
layer(x=c,y=coefficient_v1+slope_v1*c,Geom.line,Geom.point, Theme(default_color=color("purple"))),
layer(x=c,y=coefficient_v2+slope_v2*c,Geom.line,Geom.point, Theme(default_color=color("green"))),
Guide.xlabel("Time (journey_distance=5km)"), Guide.ylabel("Total cost"),
Guide.title("Regression model for cost between 9am-12noon"),
Guide.manual_color_key("Legend", ["Vendor1", "Vendor2"], ["purple","green"]))