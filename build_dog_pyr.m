function build_dog_pyr(octvs, intvls)
global gauss_pyr dog_pyr

dog_pyr = cell(octvs, intvls+2);
for o = 1 : octvs
    for i = 1 : intvls+2
        dog_pyr{o, i} = gauss_pyr{o, i+1} - gauss_pyr{o, i};
    end
end
    
