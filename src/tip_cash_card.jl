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
  for i in 9:9
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

@everywhere function tipcount(file::String)
    println("Reading file $(file)")
    @time read_file=read_data("$(file).csv");
    println("Processing $(file)")
    tip_cash=0
    tip_card=0
    row=size(read_file,1)
    column_name_tip=[Symbol("tip_amount"),Symbol(" tip_amount")]
    column_name_type=[Symbol("payment_type"),Symbol(" payment_type")]
    try
        for i in 1:row
            if(read_file[column_name_type[1]][i].value=="CSH" || read_file[column_name_type[1]][i].value==2)
                if(read_file[column_name_tip[1]][i].value>0.0)
                    tip_cash+=1
                end
            elseif(read_file[column_name_type[1]][i].value=="CRD" || read_file[column_name_type[1]][i].value==1)
                if(read_file[column_name_tip[1]][i].value>0.0)
                    tip_card+=1
                end
            else
                    #do nothing
            end
        end
    catch
        for i in 1:row
            if(read_file[column_name_type[2]][i].value=="CSH" || read_file[column_name_type[2]][i].value==2)
                if(read_file[column_name_tip[2]][i].value>0.0)
                    tip_cash+=1
                end
            elseif(read_file[column_name_type[2]][i].value=="CRD" || read_file[column_name_type[2]][i].value==1)
                if(read_file[column_name_tip[2]][i].value>0.0)
                    tip_card+=1
                end
            else
                    #do nothing
            end
        end
    end
    println("Done!!! $(file)")
    return (tip_cash,tip_card,file)
end

@time @sync begin
    v=pmap(tipcount,z)
end
save("../Graphs/Saved_Data/tip_cash_card.jld","v",v)