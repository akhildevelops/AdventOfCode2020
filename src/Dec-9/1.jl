module Dec9Part1

function check_validity(x::Array{Int64,1}, ref::Int64)::Bool
    x = collect(filter(y -> y <= ref, x))
    n_x = length(x)
    if n_x < 2
        return false
    else
        for i in 1:n_x - 1
            for j in i + 1:n_x
                if ref == x[i] + x[j]
                    return true
                end
            end
        end
    end
    return false
end
function main(file_path::String)::Union{Int64,Nothing}
    numbers = parse.(Int64, readlines(file_path))
    stride = 25
    n = length(numbers)
    for i in 1:n - (stride + 1)
        validity = check_validity(numbers[i:i + stride], numbers[i + stride])
        if !validity
            return numbers[i + stride]
        end
    end
    return nothing
end
end