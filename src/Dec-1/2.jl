module Dec1Part2
function main(file_path::String)
    lines = readlines(file_path)
    lines = parse.(Int32, lines)
    n_lines = length(lines)
    for i in 1:n_lines
        for j in i + 1:n_lines
            for k in j + 1:n_lines
                val1 = lines[i]
                val2 = lines[j]
                val3 = lines[k]
                if val1 + val2 + val3 == 2020 
                    return val1 * val2 * val3
                end
            end
        end
    end     
end
end