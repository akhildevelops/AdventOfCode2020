using AdventOfCode2020
using Test

inputs_dir = "../Inputs"
dates = readdir(inputs_dir)

dates = ["Dec-1","Dec-2","Dec-3","Dec-4","Dec-5","Dec-6"]
results = Dict("Dec-1" => [989824, 66432240], "Dec-2" => [546,275], "Dec-3" => [280,4355551200], "Dec-4" => [192,101], "Dec-5" => [896,659], "Dec-6" => [6542,3299])
@testset "AdventOfCode" begin
    @testset "Date - $(date)" for date in dates
        @test AdventOfCode2020.run(1, date, joinpath(inputs_dir, date, "input.txt")) == results[date][1]
        @test AdventOfCode2020.run(2, date, joinpath(inputs_dir, date, "input.txt")) == results[date][2]
    end
end