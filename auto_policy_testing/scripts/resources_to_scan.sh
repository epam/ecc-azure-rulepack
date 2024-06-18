# argv[1] - is a string formated as a list of resource types that must NOT be run in parallel
# argv[2] - is a string formated as a full list of resource types that must be run for auto-test

function get_not_parallel_resources_to_scan() {
    local not_parallel=$1
    local default_resource_priority_list=$2

    not_parallel_resources=$(python -c "
import sys
import ast
not_parallel = frozenset(ast.literal_eval(sys.argv[1]))
intersection = [x for x in ast.literal_eval(sys.argv[2]) if x in not_parallel]
print(intersection)" "$not_parallel" "$default_resource_priority_list")
    echo "$not_parallel_resources"
}

function get_parallel_resources_to_scan() {
    local not_parallel=$1
    local default_resource_priority_list=$2

    parallel_resources=$(python -c "
import sys
import ast
intersection =  [x for x in ast.literal_eval(sys.argv[2]) if x not in ast.literal_eval(sys.argv[1])]
print(intersection)" "$not_parallel" "$default_resource_priority_list")
    echo "$parallel_resources"
}