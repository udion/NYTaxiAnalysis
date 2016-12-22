println("Starting")
println("Starting")
@everywhere using CSV,DataFrames,Clustering,JLD
@everywhere function read_data(file::String)
  return CSV.read(file)
end
println("taxidata loaded")
x1=collect(1:9);
x2=collect(10:12);
z=String[]
for i in 8:9
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
    column_name_latitude=[Symbol(" Pickup_latitude"),Symbol("Pickup_latitude")]
    column_name_longitude=[Symbol(" Pickup_longitude"),Symbol("Pickup_longitude")]
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
        xfilter=dataset[dataset[:,1] .<40.871850,:];
        xfilter=xfilter[xfilter[:,1] .>40.561662,:];
        xfilter=xfilter[xfilter[:,2] .<-73.713301,:];
        xfilter=xfilter[xfilter[:,2] .>-74.037398,:];
        println("kmean calculation")
        @time result = kmeans(xfilter',100; maxiter=150, display=:iter);
        println("DOne!!!! $(file)")
        return (result,file)
end

@time @sync begin
    v=pmap(calculation,z)
end
v
save("../Graphs/Saved_Data/green_pickup_centers.jld","v",v)
#nohup julia x.jl &> my.log &
#nohup /home/somil55/julia-3c9d75391c/bin/julia -p 4 yellowtaxiscript.jl.jl &> my.log &