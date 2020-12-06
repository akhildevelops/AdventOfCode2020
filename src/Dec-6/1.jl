module Dec6Part1
function string_2_set(x::String)::Set
    return Set(x)
end

function multiple_to_single(x::String)::String
    return join(split(x, '\n'))
end

function extract_chunks(x::String, pattern::Regex)::Array{String,1}
    match_iterator = eachmatch(pattern, x)
    return map(x -> x.match, match_iterator)
end

function get_counts(x::String)::Int64
    single_line = multiple_to_single(x)
    single_line_set = string_2_set(single_line)
    return length(single_line_set)
end

function main(file_path::String)::Int64
    groups_string = read(file_path, String)
    group_array = extract_chunks(groups_string, r"(?s)((?:[^\n][\n]?)+)")
    counts = get_counts.(group_array)
    return sum(counts)
end
end