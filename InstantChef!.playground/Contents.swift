
import Cocoa

//INPUT TEXT

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

// Make dictionaries for preprefix, prefix, and suffix
var suffix = [String: Int] ()
var prefix = [String: [String: Int]] ()
// Loop over input words
for (index, word) in words.enumerate() {
    word
    index
    // Stop loop if no suffix remains
    if index == words.count - 1 {
        break
    }
    
    //the prefix is not a space and is not in the dictionary just yet
    if prefix[word] == nil && word != " " {
        
        suffix[words[index + 1]] = 1    // add a count of 1 for the suffix (word following current word in input)
        suffix["#️⃣"] = 1                // triangular ruler key represents total # of suffixs count
        prefix[word] = suffix           // current word from input array becomes key in prefix dictionary with value of suffix dictionary just created
        
        //otherwise just add to the suffix dictionary and move on
    } else {
        prefix[word]!["#️⃣"]! += 1 // add 1 to total suffixes
        // does current word exist as a suffix already?
        if prefix[word]![words[index + 1]] == nil {         //create and set to 1
            prefix[word]![words[index + 1]] = 1
            
        } else {                                            //add 1
            prefix[word]![words[index + 1]]! += 1
        }
    }
    //wipe for a fresh set of suffixes
    suffix = [:]
}



//OUTPUT GENERATION


//select seed word at random from the input words
var currentWord = words[Int(arc4random_uniform(UInt32(words.count)))]
var Recipe: String = currentWord + " "    // start the output sentence
var output: String  = "" //for actual output, minus the first sentence!
var end: Bool = false

//make 20 sentences
for i in 1...20 {
    //reset sentence loop stop
    end = false
    //loop until complete sentence
    while(end==false) {
        //for _ in 1...20 {
        
        //Ensure the presence of a valid seed word
        if prefix[currentWord] != nil && currentWord != " " {
            
            // Generate the random value
            let randVal = Float(arc4random_uniform(1000000)) / 10000
            randVal
            
            // Stores upper value of probabi lity for current suffix word
            var upVal: Float = 0
            
            // iterate over all suffix words for this prefix
            for (potSuf, count) in prefix[currentWord]! {
                
                // get total suffix words for this prefix
                let suffixTotal = prefix[currentWord]!["#️⃣"]!
                
                // exclude the instance of the suffix that contains the suffix total
                if potSuf != "#️⃣" {
                    
                    //get upper value
                    upVal += Float(count) / Float( suffixTotal ) * 100
                    
                    //Check if suffix is eligible for use
                    if (randVal < upVal) {
                        
                        // add the suffix to recipe
                        Recipe += potSuf
                        
                        // make the suffix the prefix
                        currentWord = potSuf
                        
                        //Check for end of sentence
                        if Recipe[Recipe.endIndex.predecessor()] == "." {
                            end = true
                        }
                        
                        // Add space before next word
                        Recipe += " "
                        
                        if (i>1) {
                            output += potSuf
                            output += " " //adds the recipe to output, minus the primary 'seed sentence' which is usually pretty bad.
                        }
                        
                        break
                    }
                }
                
            }
            
            
        } else {
            //If it can't find a seed word
            Recipe = "Seed Word Not Found! 😢"
            
            // Stop building the output sentence.
            break
        }
        
        // Stop building the sentence if last word added has a period
        if (end == true) {
            break
        }
    }
}
Recipe

print(output)
print("Now eat up and ENJOY!")




