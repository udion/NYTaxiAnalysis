#this script is to estimate pi using monte Carlo simulation

function parallel_findpi(n)
    inside =  @parallel (+) for i = 1:n
        x, y = rand(2)
        x^2 + y^2 <= 1 ? 1 : 0
    end
    4 * inside / n
end

@time parallel_findpi(10)

time = [893.081954, 437.424609, 288.011919, 219.332380,111.764335,98.156851,63.623772,51.070448,43.202897,34.187504,28.481205, 26.948234,26.782099]

npocs=[1,2,3,4,8,10,16,20,24,32,48,64,80]