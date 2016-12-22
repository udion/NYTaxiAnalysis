using JLD

m = load("Graphs/Saved_Data/vendorweekly.jld")

ven1 = m["v"][1]
ven2 = m["v"][2]
total = m["v"][3]

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
