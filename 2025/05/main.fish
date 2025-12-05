#!/usr/bin/env fish

#set ranges (cat input-test-ranges.txt)
#set ids (cat input-test-ids.txt)

set ranges (cat input-ranges.txt)
set ids (cat input-ids.txt)

function check_id
    set ok false
    for range in $ranges
        set range_parts (string split "-" $range)
        set start $range_parts[1]
        set end $range_parts[2]
        if test "$argv[1]" -ge "$start"
            if test "$argv[1]" -le "$end"
                set ok true
            end
        end
    end

    if $ok
        echo fresh
    end
end

function check_ids
    for id in $ids
        check_id $id
    end
end

set fresh (check_ids | wc -l)
echo $fresh
