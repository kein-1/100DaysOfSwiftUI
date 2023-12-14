//
//  ContentView.swift
//  WordScramble
//
//  Created by Kein Li on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        
        NavigationStack {
            
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never) // never auto cap

                }
                
                
                Section {
                    ForEach(usedWords, id: \.self){ word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Button("Add word"){
                    addNewWord(for: newWord)
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Start Game") { startGame() }
            }
            .onSubmit { // onsubmit works when user presses "return" on the keyboard
                addNewWord(for: newWord)
            }
            .onAppear { // Modifier for when the view is rendered, run this
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            
        }
    }
    
    func addNewWord(for word : String){
        let modifiedWord = word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if modifiedWord.isEmpty { return }
        
        // Put some animation to make it appear smoothly inside views/functions
        withAnimation(.easeInOut) {
            
            if modifiedWord.count < 3 {
                errorMessageMain(title: "Too short in length", message: "3 or more characters please ")
            }
            
            if modifiedWord == rootWord {
                errorMessageMain(title: "Same as root word", message: "Use a new word")
            }
            
            // checks
            if (isOriginal(word: modifiedWord)){
                errorMessageMain(title: "Word Used Already", message: "Be more original")
                return
            }
            
            if !isPossible(word: modifiedWord) {
                errorMessageMain(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
                return
            }

            if !isReal(word: modifiedWord)  {
                errorMessageMain(title: "Word not recognized", message: "You can't just make them up, you know!")
                return
            }
            
            usedWords.insert(modifiedWord, at: 0)
        }
        newWord = ""
    }
    
    func startGame(){
        guard let name = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            print("Error")
            return
        }
        do {
            let str = try String(contentsOf: name)
            let temp = str.components(separatedBy: .newlines)
            rootWord = temp.randomElement() ?? ""
            return
        } catch {
            fatalError("Erorr loading!!")
        }
    }
    
    func isOriginal(word : String) -> Bool {
        return usedWords.contains(word)
    }
    // basically if one word is an anagram of another
    func isPossible(word : String) -> Bool {
        var dict = [Character : Int]()
        
        // If doesn't exist, add it. Otherwise, update count by 1
        for char in rootWord {
            if let oldVal = dict[char] {
                dict[char] = oldVal + 1
            } else {
                dict[char] = 1
            }
        }
    
        for char in word {
            if let val = dict[char] {
                if (val == 0) { return false }
                dict[char] = val - 1
                
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func errorMessageMain(title : String, message : String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
