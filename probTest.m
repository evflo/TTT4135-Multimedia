x0 = 0;
x1 = 0;
state = 0;
for k = 1:1000000
    if state
        if rand < 2/3
            x1 = x1 + 1;
            state = 1;
        else
            x0 = x0 + 1;
            state = 0;
        end
    else
        if rand < 0.75
            x0 = x0 + 1;
            state = 0;
        else
            x1 = x1 + 1;
            state = 1;
        end
    end
end