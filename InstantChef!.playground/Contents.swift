
import Cocoa

// Set file location
let fileURL = NSBundle.mainBundle().URLForResource("Recipes2", withExtension: "txt")

// make the file a string
var content: String = ""
content = try String(contentsOfURL: fileURL!, encoding: NSUTF8StringEncoding)

// Set delimiters
let delimiters = NSCharacterSet(charactersInString: ", \n")

// Break the string
let words = content.componentsSeparatedByCharactersInSet(delimiters)
