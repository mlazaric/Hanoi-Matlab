function G = hanoi(numOfDisks, numOfPegs)
    numOfNodes = numOfPegs^numOfDisks;
    numOfEdges = 0;
    beginEdge = [];
    endEdge = [];
    names = {};
    
    for from = 1:numOfNodes
        fromVector = numberToVectorInBase(from - 1);
        
        for to = (from + 1):numOfNodes
            toVector = numberToVectorInBase(to - 1);
            
            if isValidEdge(fromVector, toVector)
                %disp([getNameOfNode(fromVector), ' ', getNameOfNode(toVector)]);
                beginEdge(numOfEdges + 1) = from;
                endEdge(numOfEdges + 1) = to;
                numOfEdges = numOfEdges + 1;
            end
        end
        
        names{from} = getNameOfNode(fromVector);
    end
    
    G = graph(beginEdge, endEdge, ones(1, numOfEdges), names);
    
    function validEdge = isValidEdge(fromVector, toVector)
        numOfChanges = 0;
        firstChanged = -1;
        validEdge = true;
        
        for disk = 1:numOfDisks
            if fromVector(disk) ~= toVector(disk)
                numOfChanges = numOfChanges + 1;
            end
            
            if numOfChanges == 1 && firstChanged == -1
                firstChanged = disk;
            end
        end
        
        if numOfChanges ~= 1
            validEdge = false; 
        else
            for disk = (firstChanged + 1):numOfDisks
                if fromVector(disk) == fromVector(firstChanged) || toVector(disk) == toVector(firstChanged)
                    validEdge = false;
                    return;
                end
            end
        end
    end
    
    % Turns number to specific base (base is numOfPegs)
    % Each digit is one element in a vector
    % Returns a vector which has numOfDisks elements
    function vectorInBase = numberToVectorInBase(number)
        vectorInBase = zeros(1, numOfDisks);
        
        for disk = (numOfDisks):-1:1
            vectorInBase(disk) = mod(number, numOfPegs);
            number = floor(number / numOfPegs);
        end
    end
        
        
    % positionsOfDisks is a vector of size numOfPegs that contains integers
    % which represent the position of that particular disk
    % Returns a string representing the name of that node
    function name = getNameOfNode(positionsOfDisks)
        name = '';
        
        for disk = 1:numOfDisks
            name = strcat(name, char(positionsOfDisks(disk) + double('A')));
        end
    end
end
