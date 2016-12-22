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
    push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2013-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2013-$(x2[i])");
  end
  for i in 1:9
        push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2014-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2014-$(x2[i])");
  end
  for i in 1:9
        push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"../Yellow_Taxi_Data_2013-15/Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-$(x2[i])");
  end

@everywhere function modecount(file::String)
    println("Reading file $(file)")
    @time read_file=read_data("$(file).csv");
    println("Processing $(file)")
    count_cash=0
    count_card=0
    row=size(read_file,1)
    for i in 1:row
        if(read_file[names(read_file)[12]][i].value=="CSH" || read_file[names(read_file)[12]][i].value==2)
                count_cash+=1
        elseif(read_file[names(read_file)[12]][i].value=="CRD" || read_file[names(read_file)[12]][i].value==1)
                count_card+=1
        else
                #do nothing
        end
    end
    println("Done!!! $(file)")
    return (count_cash,count_card,file)
end

@time @sync begin
    v=pmap(modecount,z)
end
save("../Graphs/Saved_Data/yellow_payment_type_count.jld","v",v)