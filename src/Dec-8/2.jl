module Dec8Part2
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

function parse_operation(x::String)::Array{Union{String,Int64},1}
    op, value = split(x, ' ')
    return [String(op), parse(Int64, value)]
end

function get_accumulator_run_operations(operations::Array, index::Int64, accumulator::Int64)::Union{Nothing,Int64}
    visited_index = Int64[]
    push!(visited_index, index)
    n_ops = length(operations)
    while index <= n_ops
        op, value = operations[index]
        index, accumulator = get_new_index_compute_accumulator(op, value, index, accumulator)
        if index ∉ visited_index
            push!(visited_index, index)
        else
            return nothing
        end
    end
    if n_ops ∈ visited_index
        return accumulator
    else
        return nothing
    end
end


function correct_get_accumulator(operations::Array, index::Int64, accumulator::Int64)
    for (index_op, operation) in enumerate(operations)
        ops = deepcopy(operations)
        op = operation[1]
        value = operation[2]
        if op == "jmp"
            ops[index_op][1] = "nop"
            acc = get_accumulator_run_operations(ops, index, accumulator)
            if acc === nothing
                continue
            else
                return acc
            end
        elseif op == "nop"
            ops[index_op][1] = "jmp"
            acc = get_accumulator_run_operations(ops, index, accumulator)
            if acc === nothing
                continue
            else
                return acc
            end
        end
    end
end

function main(file_path::String)::Int64
    operations = readlines(file_path)
    current_index = 1
    accumulator = 0
    operations = parse_operation.(operations)
    return correct_get_accumulator(operations, current_index, accumulator)
end
end