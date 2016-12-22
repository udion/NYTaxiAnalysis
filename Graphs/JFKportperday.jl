using JLD

m = load("Graphs/Saved_Data/JFKportperday.jld")

x1 = m["v"][1]
x2 = m["v"][2]

c=["Monday","Tuesday","Wednesday","Thursday","Friday","saturday","Sunday"]

Gadfly.plot(layer(x=c,y=x1,Geom.point, Geom.line,order=1,Theme(default_color=color("purple"))),
layer(x=c,y=x2,Geom.point, Geom.line,order=1,Theme(default_color=color("red"))),
Guide.xlabel("Days"), Guide.ylabel("No of vehicles"),
Guide.title("Airport Pickup(Per WeekDay)"),
Guide.manual_color_key("Legend", ["pick-ups", "drop-offs"], ["purple", "red"]))