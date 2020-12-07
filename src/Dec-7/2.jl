module Dec7Part2

function extract_chunks(x::String, pattern::Regex)::Array{String,1}
    matches = split(x, pattern)
    return strip.(String.(matches))
end

function capture_groups(x::String, pattern::Regex)::Tuple{String,String}
    matching = match(pattern, x)
    return strip(String(matching[1])), strip(String(matching[2]))
end

function extract_colors_number(x::String)::Tuple{Union{Nothing,Int64},Union{Nothing,String}}
    if x == "no other bags."
        return nothing, nothing
    end
    count, color = capture_groups(x, r"(\d)\s?([a-zA-Z ]+)\s?bags?")
    return parse(Int64, count), color
end

function get_parent_child(x::String)::Tuple
    strings = extract_chunks(x, r"bags contain|,")
    child_count = extract_colors_number.(strings[2:end])
    parent = strings[1]
    return parent, child_count
end

function get_nested_counts(x::Dict, key::String)::Union{Nothing,Int64}
    total = 0
    for child in x[key]
        count = child[1]
        child_name = child[2]
        if count === nothing
            return 1
        end
        total += count * get_nested_counts(x, child_name)
    end
    return total + 1
end

function main(file_path::String)::Int64
    baggage_conditions = readlines(file_path)
    parents_child = Dict(get_parent_child.(baggage_conditions))
    bags = get_nested_counts(parents_child, "shiny gold") - 1
    return bags
end
end