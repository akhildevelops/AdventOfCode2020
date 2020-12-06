module AdventOfCode2020

include_dates = [1,2,3,4,5,6]

function get_filepath(date::Int64)::Tuple{String,String}
    return joinpath(@__DIR__, "Dec-$(date)", "1.jl"), joinpath(@__DIR__, "Dec-$(date)", "2.jl")
end

function include_files(x::Array{String,1})
    include.(x)
end

function include_modules_dates(dates::Array{Int64,1})
    file_paths = get_filepath.(dates)
    file_paths = collect(Iterators.flatten(file_paths))
    include_files(file_paths)
end

include_modules_dates(include_dates)

function run(part::Int64, date::String, file_path::String)
    date = join(split(date, '-'))
    module_date = Symbol("$(date)Part$(part)")
    return @eval $module_date.main($file_path)
end
end