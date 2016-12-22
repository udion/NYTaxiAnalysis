using JLD

m = load("Graphs/Saved_Data/JFKportperhour.jld")

x1 = m["v"][1]
x2 = m["v"][2]

c=collect(0:23)
Gadfly.plot(layer(x=c,y=x1,Geom.point, Geom.line,order=1,Theme(default_color=color("purple"))),
layer(x=c,y=x2,Geom.point, Geom.line,order=1,Theme(default_color=color("red"))),
Guide.xlabel("Time in hour"), Guide.ylabel("No of vehicles"),
Guide.title("Airport Pickup(Per Hour)"),
Guide.manual_color_key("Legend", ["pick-ups", "drop-offs"], ["purple", "red"]))