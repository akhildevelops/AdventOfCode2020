module Dec3Part1
slope = [3,1]


function get_level(pattern, level)
    return pattern[level]
end

function get_x_value(level, index)
    n_l = length(level)
    if index <= n_l
        return index
    else
        return index - n_l
    end
end
function get_next_point(current_point, slope, pattern)
    x_ref, y_ref = current_point + slope
    n_level = y_ref
    level = get_level(pattern, n_level)
    x = get_x_value(level, x_ref)
    y = y_ref
    return [x,y]
end

function get_marker_point(pattern, current_point)
    row, col = current_point
    return pattern[col][row]
end

function get_n_trees(pattern)
    global slope
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
function main(file_path::String)
    lines = readlines(file_path)
    return get_n_trees(lines)
end

end