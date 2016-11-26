//
//  ViewController.swift
//  SillySong
//
//  Created by Pham, Quan on 11/26/16.
//  Copyright © 2016 Pham, Quan. All rights reserved.
//

import UIKit

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if (nameField.text != "") {
            lyricsView.text = lyricsForName(name: nameField.text!, lyrics: bananaFanaTemplate)
        }
    }
}

func shortNameFromName(_ name: String) -> String {
    let lowercaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    
    if (lowercaseName.rangeOfCharacter(from: vowelSet) != nil) {
        return lowercaseName.substring(from: (lowercaseName.rangeOfCharacter(from: vowelSet)?.lowerBound)!)
    }
    else {
        return lowercaseName
    }
}

func lyricsForName(name: String, lyrics: String) -> String {
    let lowercaseName = shortNameFromName(name)
    let fullName = name.replacingCharacters(in: name.startIndex..<name.index(after: name.startIndex), with: String(name[name.startIndex]).uppercased())
    var newLyrics = lyrics
    newLyrics = newLyrics.replacingOccurrences(of: "<SHORT_NAME>", with: lowercaseName)
    newLyrics = newLyrics.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    return newLyrics
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return false
    }
}
