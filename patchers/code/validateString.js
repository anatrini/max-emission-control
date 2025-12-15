inlets = 4;
outlets = 2;

var lastMapped = ["", "", "", ""];
var lastUnmapped = ["", "", "", ""];

function startsWithSlash(str) {
    return typeof str === "string" && str.charAt(0) === "/";
}

function anything() {
    var inletIndex = inlet;
    var tokens = arrayfromargs(messagename, arguments);
    
    var first  = tokens[0];
    var second = tokens[1];
    var third  = tokens[2];
    
    if (!startsWithSlash(first)) {
        return;
    }
    
    if (second === "unmap") {
        if (lastUnmapped[inletIndex] !== "" && lastUnmapped[inletIndex] !== first) {
            return;
        }
        if (lastMapped[inletIndex] !== "" && lastMapped[inletIndex] !== first) {
            return;
        }
        
        lastMapped[inletIndex] = "";
        lastUnmapped[inletIndex] = first;
        outlet(1, inletIndex + 1);
        outlet(0, "list", first, second);
        return;
    }
    
    if (second === "map") {
        if (lastMapped[inletIndex] !== "" && lastMapped[inletIndex] !== first) {
            return;
        }
        
        lastUnmapped[inletIndex] = "";
        lastMapped[inletIndex] = first;
        outlet(1, inletIndex + 1);
        outlet(0, "list", first, second, third);
        return;
    }
}