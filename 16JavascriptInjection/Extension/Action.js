var Action = function() {};
Action.prototype = {
    
run: function(parameters) {
    //tell IOS the javascript has finished preprocessing and give this data dictionary to the extension
    
    parameters.completionFunction({"URL": document.URL, "title": document.title });
    
},
    
finalize: function(parameters){
    
    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript)
    
}
    
};

var ExtensionPreProcessingJS = new Action