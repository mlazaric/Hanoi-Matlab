function [G, p] = hanoi(numOfDisks, numOfPegs)
    numOfBits = ceil(log2(numOfPegs));
    offset = 2^numOfBits;
    
    edges = zeros(numOfPegs^numOfDisks, 1);
    names = cell(numOfPegs^numOfDisks, 1);
    number_in_base = zeros(numOfDisks, 1);
    curr_number = 0;
    curr_name = repmat('A', 1, numOfDisks);
    
    for edge = 0:(numOfPegs^numOfDisks-1)
        edges(edge + 1) = curr_number;
        names{edge + 1} = curr_name;
        
        number_in_base(1) = number_in_base(1) + 1;
        curr_number = 0;
        curr_name = '';
        
        for digit = 1:(numOfDisks - 1)
            if number_in_base(digit) == numOfPegs
                number_in_base(digit + 1) = number_in_base(digit + 1) + 1;
                number_in_base(digit) = 0;
            end    
        end
        
        for digit = 1:numOfDisks
            curr_number = curr_number + number_in_base(digit) * offset^(digit - 1);
            curr_name = strcat(char(65 + number_in_base(digit)), curr_name);
        end
    end
    
    [X, Y] = meshgrid(edges, edges);
    A = arrayfun(@hanoiEdgeCheck, X, Y);
    G = graph(A, names);
    p = plot(G);


    function isValidEdge = hanoiEdgeCheck(from, to)
        isValidEdge = 1;

        if from == to
           isValidEdge = 0;
        else
            numOfChanges = 0;
            changed = -1;

            for disk=0:(numOfDisks - 1)
                numOfChanges = numOfChanges + ((bitand(bitshift(from, -disk * numOfBits), offset - 1)) ~= (bitand(bitshift(to, -disk * numOfBits), offset - 1))); 

                if numOfChanges == 1 && changed == -1
                    changed = disk;
                end
            end

            if numOfChanges > 1 
                isValidEdge = 0;
            else
                for disk=0:(changed - 1)
                    if (bitand(bitshift(from, -disk * numOfBits), offset - 1)) == (bitand(bitshift(from, -changed * 2), offset - 1)) || (bitand(bitshift(to, -disk * numOfBits), offset - 1)) == (bitand(bitshift(to, -changed * numOfBits), offset - 1))
                       isValidEdge = 0;
                    end
                end
            end
        end
    end
end
