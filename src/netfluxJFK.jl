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
        push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2013-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2013-$(x2[i])");
  end
  for i in 1:9
        push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2014-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2014-$(x2[i])");
  end
  for i in 1:9
        push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"/home/somil55/newyorktaxidata/Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-$(x2[i])");
  end


@everywhere function AirportFlux(file)
    println("Reading file $(file)")
    @time read_file=read_data("$(file).csv");
    println("Pickup calculation")
    #JFK Aiport pickup by month
    row,column=size(read_file)
    tempdatasetpick=read_file[:,6:7];
    v=(-73.788040,40.658410)
    count_pickup=0
    for i in 1:row
        s=0.0
        for j in 1:2
            s+=(tempdatasetpick[i,j].value-v[j])^2
        end
        s=sqrt(s)
        if(s<.0181)
            count_pickup=count_pickup+1
        end
    end

    println("Dropoff calculation")
    #JFK Aiport Dropoff by month
    tempdatasetdrop=read_file[:,10:11];
    count_dropoff=0
    for i in 1:row
        s=0.0
        for j in 1:2
            s+=(tempdatasetdrop[i,j].value-v[j])^2
        end
        s=sqrt(s)
        if(s<.0181)
            count_dropoff=count_dropoff+1
        end
    end
    netflux = count_pickup-count_dropoff
    println("Done!!")
    return (netflux,count_pickup,count_dropoff,file)
end

@time @sync begin
    v=pmap(AirportFlux,z)
end
v
save("/home/somil55/newyorktaxidata/Graphs/Saved_Data/yellow_dropoff_airport.jld","v",v)