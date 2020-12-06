module Dec4Part2
ref_key = ["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"]
const ref_keys = filter(x -> x ≠ "cid", ref_key)

function read_passport(file_path::String)::String
    return read(file_path, String)
end

function extract_chunks(x::String, pattern)::Array{String,1}
    match_iterator = eachmatch(pattern, x)
    return map(x -> x.match, match_iterator)
end

function extract_kv(x::String;delimiter=":")::Tuple{String,String}
    substring = split(x, delimiter)
    string = String.(substring)
    string = Tuple(string)
    return string
end

function convert(type::Type{Dict}, x::String;delimter_kv=":")::type
    chunks = extract_chunks(x, r"((?:[^\s])+)")
    chunks = extract_kv.(chunks)
    return type(chunks)
end

function extract_key_from_chunk(x::String, delimiter=":")::String
    substring = split(x, delimiter)
    string = String.(substring)
    return string[1]
end

function extract_keys(chunk::String)::Array{String,1}
    chunks = extract_chunks(chunk, r"((?:[^\s])+)")
    keys_chunks = extract_key_from_chunk.(chunks)
    return keys_chunks
end

function validlength(x::Any, y::Int64)::Bool
    return length(x) == y
end
function isinrange(x::Int64, l::Int64, u::Int64)::Bool
    return l ≤ x ≤ u
end

function get_value(x::String, key::String)::Union{String,Nothing}
    regex_exp = Regex("(.+)$(key)")
    regex_object = match(regex_exp, x)
    if regex_object === nothing
        return nothing
    else
        regex_object.captures[1]
    end
end

function pattern_present(x::String, pattern::Regex)::Bool
    return occursin(pattern, x)
end

function validate_str_length_range(x::String, length_str::Int64, l::Int64, u::Int64)::Bool
    if validlength(x, length_str)
        x = parse(Int64, x)
        if isinrange(x, l, u)
            return true
        end
    end
    return false
end

function isvalid(x::String, key::String)::Bool
    if key == "byr"
        if validate_str_length_range(x, 4, 1920, 2002)
            return true
        end
    elseif key == "iyr"
        if validate_str_length_range(x, 4, 2010, 2020)
            return true
        end
    elseif key == "eyr"
        if validate_str_length_range(x, 4, 2020, 2030)
            return true
        end
    elseif key == "hgt"
        value = get_value(x, "cm")
        if value ≠ nothing
            value = parse(Int64, value)
            if isinrange(value, 150, 193)
                return true
            end
        end
        value = get_value(x, "in")
        if value ≠ nothing
            value = parse(Int64, value)
            if isinrange(value, 59, 76)
                return true
            end
        end
    elseif key == "hcl" 
        if pattern_present(x, r"^#[0-9a-z]{6}$")
            return true
        end
    elseif key == "ecl"
        if x ∈ ["blu","amb","brn","gry","grn","hzl","oth"]
            return true
        end
    elseif key == "pid"
        if length(x) == 9
            return true
        end
    end
    return false
end

function check_validity(passport::Dict)::Bool
    keys_passport = keys(passport)
    for key in ref_keys
        if key ∉ keys_passport
            return false
        elseif isvalid(passport[key], key)
            continue
        else
            return false
        end
    end
    return true
end

function get_valid_passports(passports::String)::Int64
    passports_array = extract_chunks(passports, r"(?s)((?:[^\n][\n]?)+)")
    passports_dict = convert.(Dict, passports_array)
    bools = check_validity.(passports_dict)
    return sum(bools)
end

function main(file_path::String)::Int64
    passports = read_passport(file_path)
    return get_valid_passports(passports)
end
end