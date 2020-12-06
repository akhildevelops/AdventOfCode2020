
module Dec3Part2
    

slopes = [1 1; 3 1; 5 1; 7 1; 1 2]


function get_level(pattern::Array{String,1}, level::Int64)
    return pattern[level]
end

function get_x_value(level::String, index::Int64)
    n_l = length(level)
    if index <= n_l
        return index
    else
        return index - n_l
    end
end
function get_next_point(current_point::Array{Int64,1}, slope::Array{Int64,1}, pattern::Array{String,1})
    x_ref, y_ref = current_point + slope
    n_level = y_ref
    level = get_level(pattern, n_level)
    x = get_x_value(level, x_ref)
    y = y_ref
    return [x,y]
end

function get_marker_point(pattern::Array{String,1}, current_point::Array{Int64,1})
    row, col = current_point
    return pattern[col][row]
end

function get_n_trees(pattern, slope)
    initial_point = [1,1]
    n_max = length(pattern)
    current_point = initial_point
    counter = 0
    while current_point[2] < n_max
        current_point = get_next_point(current_point, slope, pattern)
        marker = get_marker_point(pattern, current_point)
        if marker == '#'
            counter += 1
        end
    end
    return counter
end

function n_trees_multiple_slopes(pattern::Array{String,1}, slopes::Array{Int64,2})::Int64
    count = 1
    for slope in eachrow(slopes)
        slope = Array(slope)
        count *= get_n_trees(pattern, slope)
    end
    return count
end

function main(file_path::String)
    lines = readlines(file_path)
    return n_trees_multiple_slopes(lines, slopes)
end
end