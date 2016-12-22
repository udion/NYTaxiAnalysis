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
        push!(z,"yellow_tripdata_2015-0$(x1[i])");
  end
  for i in 1:3
       push!(z,"yellow_tripdata_2015-$(x2[i])");
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
    results=zeros(n_buckets,3)
  for i=1:n_buckets
        println("Starting for file $(dt) and time-bucket $(i)")
      batch=DataFrame()
      reg = DataFrame()
      if i==1
        batch = dt[Dates.hour(dt[:3]) .<= ind,:]
      end
      if i*ind <24
        batch_intr = dt[Dates.hour(dt[:3]) .> (i-1)*ind, :]
        batch = batch_intr[Dates.hour(batch_intr[:3]) .<= i*ind, :]
      else
        batch_intr = dt[Dates.hour(dt[:3]) .> (i-1)*ind, :]
        batch = batch_intr[Dates.hour(batch_intr[:3]) .< 24, :]
      end
      reg[:cost] = batch[:,last_column];
      reg[:dist] = batch[:,5];
      reg[:time] = batch[:,3]-batch[:,2];
      model = glm(cost~dist+time, reg, Normal(), IdentityLink())
      for j in 1:3 
         results[i,j]=coef(model)[j]
      end
      println(model)
  end
    return (results,file) 
end


@time @sync begin
    v=pmap(batch_regression,z)
end
v
save("regressionmodels.jld","v",v)