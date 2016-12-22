println("Starting")
println("Starting")
@everywhere using CSV,DataFrames,Clustering,JLD
using Cairo,Fontconfig,Gadfly
@everywhere function read_data(file::String)
  return CSV.read(file)
end
println("taxidata loaded")
x1=collect(1:9);
x2=collect(10:12);
z=String[]
for i in 9:9
    push!(z,"../Green_Taxi_Data_2013-15/green-13-0$(x1[i])");
end
for i in 1:3
    push!(z,"../Green_Taxi_Data_2013-15/green-13-$(x2[i])");
end
for i in 1:9
    push!(z,"../Green_Taxi_Data_2013-15/green-14-0$(x1[i])");
end
for i in 1:3
    push!(z,"../Green_Taxi_Data_2013-15/green-14-$(x2[i])");
end
for i in 1:9
    push!(z,"../Green_Taxi_Data_2013-15/green0$(x1[i])");
end
for i in 1:3
    push!(z,"../Green_Taxi_Data_2013-15/green$(x2[i])");
end
@everywhere function calculation(file::String)
        println("Reading file $(file)")
        @time read_file=read_data("$(file).csv");
        row,column=size(read_file)
        dataset=Matrix{Float64}(row,2)
        println("Vendor calculation")
        column_name_latitude=[Symbol("Dropoff_latitude"),Symbol(" Dropoff_latitude")]
        column_name_longitude=[Symbol("Dropoff_longitude"),Symbol(" Dropoff_longitude")]
        try 
            latitude=read_file[column_name_latitude[1]]
            longitude=read_file[column_name_longitude[1]]
            for i in 1:row 
                dataset[i,1]=latitude[i].value
                dataset[i,2]=longitude[i].value
            end
        catch
            latitude=read_file[column_name_latitude[2]]
            longitude=read_file[column_name_longitude[2]]
            for i in 1:row 
                dataset[i,1]=latitude[i].value
                dataset[i,2]=longitude[i].value
            end
        end
        println("Filtering")
        xfilter=dataset[dataset[:,1] .<40.9,:];
        xfilter=xfilter[xfilter[:,1] .>40.5,:];
        xfilter=xfilter[xfilter[:,2] .<-73.6,:];
        xfilter=xfilter[xfilter[:,2] .>-74.2,:];
        println("Done!!!! $(file)")
    return xfilter
end

@time @sync begin
    v=pmap(calculation,z)
end

println("Combining Dataset")
dataset=Matrix{Float64}(0,2)
for i=1:28
    dataset=vcat(dataset,v[i])
end
println("Plotting Map")
myplot=plot(x=dataset[:,2], y=dataset[:,1],Scale.y_continuous(minvalue=40.5, maxvalue=40.9),
     Scale.x_continuous(minvalue=-74.2, maxvalue=-73.6),Geom.hexbin(xbincount=1000, ybincount=1000));
println("Creating PNG")
draw(PNG("green_dropoff.png", 9inch, 9inch), myplot)