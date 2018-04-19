function hanoi(numOfDisks, numOfPegs)
    numOfVertices = numOfPegs^numOfDisks;
    
    for from = 1:numOfVertices
        for to = (from + 1):numOfVertices
            % check if it is valid
        end
    end
    
    % Accepts an array of size numOfPegs that contains integers
    % which represent the position of that particular disk
    function name = getNameOfNode(positionsOfDisks)
        name = '';
        
        for disk = 1:numOfPegs
            name = strcat(name, char(positionsOfDisks(disk) + double('A')));
        end
    end
end
