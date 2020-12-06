module Dec5Part2
function row_to_int(row::String)::Int64
    binary_array = map(x -> x == 'F' ? '0' : '1', row)
    return binary_to_int(binary_array)
end

function col_to_int(col::String)::Int64
    binary_array = map(x -> x == 'L' ? '0' : '1', col)
    return binary_to_int(binary_array)
end

function binary_to_int(x::String)::Int64
    return parse(Int64, x, base=2)
end

function get_seat(row::Int64, col::Int64)::Int64
    return row * 8 + col
end

function get_codes(x::String)::Tuple{String,String}
    return x[begin:7], x[8:end]
end
function get_seat_number(code::String)::Int64
    row, col = get_codes(code)
    row_id = row_to_int(row)
    col_id = col_to_int(col)
    return get_seat(row_id, col_id)
end

function get_missing_number(x::Array{Int64,1})::Int64
    x = sort(x)
    n = length(x)
    for i in 1:n
        if x[i] == x[i + 1] - 1
            continue
        else
            return x[i] + 1
        end
    end
end

function main(x::String)::Int64
    boardingpasses = readlines(x)
    seat_numbers = get_seat_number.(boardingpasses)
    return get_missing_number(seat_numbers)
end
end