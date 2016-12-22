println("Starting")
println("Starting")
@everywhere using CSV,DataFrames,Clustering,JLD
@everywhere function read_data(file::String)
  return CSV.read(file)
end

println("taxidata loaded")
  x1=collect(1:9);
  x2=collect(10:12);
  z=[]
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
@everywhere function calculatepoints(file::String)
  println("Reading file $(file)")
  @time read_file=read_data("$(file).csv");
  row,column=size(read_file)
  dataset=Matrix{Float64}(row,1)
  println("Vendor calculation")
  column_name_id=[Symbol("VendorID"),Symbol(" VendorID")]
  v1=0
  v2=0
  try 
            id=read_file[column_name_id[1]]
            for i in 1:row
                if(id[i].value==1)
                    v1+=1
                elseif(id[i].value==2)
                    v2+=1
                else
                    #do nothing
                end
            end
  catch
            id=read_file[column_name_id[2]]
            for i in 1:row
                if(id[i].value==1)
                    v1+=1
                elseif(id[i].value==2)
                    v2+=1
                else
                    #do nothing
                end
            end
  end
  println("Done!!")
    return(v1,v2,file)
end
@time @sync begin
    v=pmap(calculatepoints,z)
end
v
save("../Graphs/Saved_Data/vendorcount_green_per_month.jld","v",v)