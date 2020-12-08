module Dec8Part1
visited_index = Int64[]
function get_new_index_compute_accumulator(op, value, current_index, accumulator)
    if op == "jmp"
        current_index += value
    elseif op == "acc"
        accumulator += value
        current_index += 1
    else
        current_index += 1
    end
    return current_index, accumulator
end

function parse_operation(x::String)::Tuple{String,Int64}
    op, value = split(x, ' ')
    return op, parse(Int64, value)
end

function get_accumulator_run_operations(operations::Array, index::Int64, accumulator::Int64)
    global visited_index
    push!(visited_index, index)
    while true
        op, value = operations[index]
        index, accumulator = get_new_index_compute_accumulator(op, value, index, accumulator)
        if index ∉ visited_index
            push!(visited_index, index)
        else
            return accumulator
        end
    end
end

function main(file_path::String)::Int64
    operations = readlines(file_path)
    current_index = 1
    accumulator = 0
    operations = parse_operation.(operations)
    return get_accumulator_run_operations(operations, current_index, accumulator)
end
end

println(Dec8Part1.main("./Inputs/Dec-8/input.txt"))