function flag = is_extremum(octv, intvl, r, c)
global dog_pyr

flag = 0;
val = dog_pyr{octv, intvl}(r, c);

if val > 0
    for i = -1 : 1
        if find(dog_pyr{octv, intvl+i}(r-1:r+1, c-1:c+1) > val)
            return
        end
    end
else
    for i = -1 : 1
        if find(dog_pyr{octv, intvl+i}(r-1:r+1, c-1:c+1) < val)
            return
        end
    end
end

flag = 1;