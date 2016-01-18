
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


// PROBABILITY GENERATION

// Make dictionaries for prefix, suffix, and postSuffix
var postSuffix = [String: Int] ()
var suffix = [String: [String: Int]] ()
var prefix = [String: [String: [String: Int] ] ] ()
// Loop over input words
for (index, word) in words.enumerate() {
    
    // Stop loop before no suffix remains
    if index == words.count - 1 {
        break
    }
    
    // when the current word from the input array is not in the prefix dictionary at all & skip blank entries
    if prefix[word] == nil && word != " " {
        
        postSuffix[words[index + 2]] = 1
        
        suffix[words[index + 1]] = postSuffix   // add a count of 1 for the suffix (word following current word in input)
        postSuffix["📐"] = 1                // triangular ruler key represents total # of suffixs count
        prefix[word] = suffix           // current word from input array becomes key in prefix dictionary with value of suffix dictionary just created
        
    } else {
        
        // add 1 to total in suffix dictionary
        prefix[word]![words[index+1]]!["📐"]! += 1
        
        // does current word exist as a suffix already?
        if suffix[word]![words[index + 1]] == nil {         // does not exist, so create and set to 1
            suffix[word]![words[index + 1]] = 1
            
        } else {                                            // does exist, so increment by 1
            suffix[word]![words[index + 1]]! += 1
        }
    }
    
    // wipe out the suffix dictionary for next iteration, so it starts blank
    postSuffix = [:]
}