module Dec9Part2

function get_continuous_numbers(x::Array{Int64,1}, ref::Int64)::Union{Nothing,Array{Int64,1}}
    x = collect(filter(y -> y < ref, x))
    n_x = length(x)
    for i in 2:n_x
        for j in 1:n_x - (i + 1)
            if ref == sum(x[j:j + i])
                return x[j:j + i]
            end
        end
    end
    return nothing
end
function main(file_path::String)::Union{Int64,Nothing}
    numbers = parse.(Int64, readlines(file_path))
    ref = 144381670
    numbers = get_continuous_numbers(numbers, ref)
    return max(numbers...) + min(numbers...)
end
end