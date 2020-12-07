module Dec7Part1
child_to_parent = Dict()

function extract_chunks(x::String, pattern::Regex)::Array{String,1}
    matches = split(x, pattern)
    return strip.(String.(matches))
end

function capture_groups(x::String, pattern::Regex)::Tuple{String,String}
    matching = match(pattern, x)
    return strip(String(matching[1])), strip(String(matching[2]))
end

function extract_colors_number(x::String)::Tuple{Union{Nothing,String},Union{Nothing,String}}
    if x == "no other bags."
        return nothing, nothing
    end
    count, color = capture_groups(x, r"(\d)\s?([a-zA-Z ]+)\s?bags?")
    return count, color
end

function add_child_parent(parent::String, child::Tuple{Union{Nothing,String},Union{Nothing,String}})
    global child_to_parent
    child_name = child[2]
    count = child[1]
    value = get(child_to_parent, child_name, nothing)
    if value === nothing
        child_to_parent[child_name] = [(count, parent)]
    else
        push!(child_to_parent[child_name], (count, parent))
    end
end

function get_child_to_parent(parent::String, child_count)
    add_child_parent.(parent, child_count)
end
function get_child_parents(x::String)::Nothing
    strings = extract_chunks(x, r"bags contain|,")
    child_count = extract_colors_number.(strings[2:end])
    parent = strings[1]
    get_child_to_parent(parent, child_count)
    return nothing
end

function get_nested_bags(x::Dict, key::String)::Union{Nothing,Array{String,1}}
    if get(x, key, nothing) === nothing
        return nothing
    end
    parents = map(y -> y[2], x[key])
    actual_parents = []
    for parent in parents
        nested_parents = get_nested_bags(x, parent)
        if nested_parents ≠ nothing
            append!(actual_parents, nested_parents)
        end
        push!(actual_parents, parent)
    end
    return actual_parents
end

    function main(file_path::String)::Int64
    baggage_conditions = readlines(file_path)
    child_parents = get_child_parents.(baggage_conditions)
    bags = Set(get_nested_bags(child_to_parent, "shiny gold"))
    return length(bags)
end
end