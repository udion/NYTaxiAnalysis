using JLD

m = load("Graphs/Saved_Data/vendorperhour.jld")

x1 = m["v"][1]
x2 = m["v"][2]

Gadfly.plot(layer(x=1:24,y=x1,Geom.point, Geom.line,order=1,Theme(default_color=color("blue"))),
layer(x=1:24,y=x2,Geom.point, Geom.line,order=2,Theme(default_color=color("purple"))),
Guide.xlabel("Hours of day"), Guide.ylabel("No of vehicles"),
Guide.title("Vendor 1 vs Vendor 2 (Per Hour)"),
Guide.manual_color_key("Legend", ["Vendor1", "Vendor2"], ["blue", "purple"]))