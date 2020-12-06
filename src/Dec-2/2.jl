module Dec2Part2
function get_lower_upper_bounds(x::String)
    bounds = split(x, '-')
    bounds = parse.(Int64, bounds)
    return bounds
end

function get_char(x::String)
    return x[1]
end

function get_counts(x::String, y::Char)
    local counter = 0
    for c in x
        if c == y
            counter += 1
        end
    end
    return counter
end

function isinbounds(n::Int64, bounds::Array{Int64})
    lower = bounds[1]
    upper = bounds[2]
    return lower ≤ n ≤ upper
end

function get_chars(x::String, bounds::Array{Int64})
    return x[bounds[1]], x[bounds[2]]
end

function only_one_matches(c::Char, lower_c::Char, upper_c::Char)
    if (lower_c == c) & (upper_c != c)
        return true
    elseif (upper_c == c) & (lower_c != c)
        return true
    else
        return false
    end
    
end

function valid_password(password::String, c::Char, bounds::Array{Int64})
    lower_c, upper_c = get_chars(password, bounds)
    return only_one_matches(c, lower_c, upper_c)
end

function is_valid_password(x::String)
    arr = split(x, ' ')
    arr = String.(arr)
    bounds = get_lower_upper_bounds(arr[1])
    char = get_char(arr[2])
    flag_password = valid_password(arr[3], char, bounds)
    return flag_password
end

function main(input_file::String)::Int64
    lines = readlines(input_file)
    valid_passwords = is_valid_password.(lines)
    return sum(valid_passwords)
end
end