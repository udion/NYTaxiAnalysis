@everywhere using CSV,DataFrames,Clustering,JLD,GLM
@everywhere function read_data(file::String)
  return CSV.read(file)
end
@everywhere type Taxidata
  dataset::DataFrame
  function Taxidata(dt::DataFrame)
    data_set=DataFrame()
    columns=size(dt,2)
        for i=1:columns
      z::DataArray=@data([x.isnull ? NA : x.value for x in dt[:,i]])
      data_set=hcat(data_set,z)
    end
    new(data_set)
  end
end

println("taxidata loaded")
x1=collect(1:9);
x2=collect(10:12);
z=String[]
  for i in 1:9
        push!(z,"../Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-0$(x1[i])");
  end
  for i in 1:2
       push!(z,"../Yellow_Taxi_Data_2013-15/yellow_tripdata_2015-$(x2[i])");
  end
#this is a script which performs linear regression while dividing times in batches
#the number of buckets will be varying depending upon the need
@everywhere function batch_regression(file)
  println("Reading file $(file)")
  @time read_file=read_data("$(file).csv");
  println("Converting file $(file)")
  @time dt=Taxidata(read_file);
  dt=dt.dataset
  println("Starting for file $(dt)")
  n_buckets = 8
  ind = round(24/n_buckets)
  last_column=size(dt,2)
  result_v1=zeros(n_buckets,3)
  result_v2=zeros(n_buckets,3)
  for i=1:n_buckets
      println("Starting for file $(dt) and time-bucket $(i)")
      batch=DataFrame()
      reg_v1 = DataFrame()
      reg_v2 = DataFrame()
      if i==1
        batch = dt[Dates.hour(dt[:3]) .<= ind,:];
      end
      if i*ind <24
        batch_intr = dt[Dates.hour(dt[:3]) .> (i-1)*ind, :];
        batch = batch_intr[Dates.hour(batch_intr[:3]) .<= i*ind, :];
      else
        batch_intr = dt[Dates.hour(dt[:3]) .> (i-1)*ind, :];
        batch = batch_intr[Dates.hour(batch_intr[:3]) .< 24, :];
      end
      batch1=batch[batch[:,1].==1,:];
      batch2=batch[batch[:,1].==2,:];
      reg_v1[:cost] = batch1[:,last_column];
      reg_v1[:dist] = batch1[:,5];
      reg_v1[:time] = batch1[:,3]-batch1[:,2];
      reg_v2[:cost] = batch2[:,last_column];
      reg_v2[:dist] = batch2[:,5];
      reg_v2[:time] = batch2[:,3]-batch2[:,2];
      model_v1 = glm(cost~dist+time, reg_v1, Normal(), IdentityLink())
      model_v2 = glm(cost~dist+time, reg_v2, Normal(), IdentityLink())
      for j in 1:3 
         result_v1[i,j]=coef(model_v1)[j]
      end
      for j in 1:3 
         result_v2[i,j]=coef(model_v2)[j]
      end
      println(model_v1)
      println(model_v2)
  end
    println("Done!!!!")
    return (result_v1,result_v2,file) 
end


@time @sync begin
    v=pmap(batch_regression,z)
end
v
save("../Graphs/Saved_Data/regressionmodels_vendor_wise.jld","v",v)