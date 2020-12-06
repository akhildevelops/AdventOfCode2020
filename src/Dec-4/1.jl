module Dec4Part1
ref_key = ["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"]
ref_keys = filter(x -> x ≠ "cid", ref_key)

function read_passport(file_path::String)::String
    return read(file_path, String)
end

function extract_chunks(x::String, pattern)::Array{String,1}
    match_iterator = eachmatch(pattern, x)
    return map(x -> x.match, match_iterator)
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

function check_validity(keys::Array{String,1})::Bool
    global ref_keys
    for key in ref_keys
        if key ∉ keys
            return false
        end
    end
    return true
end

function get_valid_passports(passports::String)::Int64
    passports_array = extract_chunks(passports, r"(?s)((?:[^\n][\n]?)+)")
    passport_keys = extract_keys.(passports_array)
    bools = check_validity.(passport_keys)
    return sum(bools)
end

function main(file_path::String)::Int64
    passports = read_passport(file_path)
    return get_valid_passports(passports)
end
end