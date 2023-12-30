//
//  ViewController.swift
//  MLChecker
//
//  Created by Shady El-Maadawy on 30/12/2023.
//

import Cocoa
import CoreML
class ViewController: NSViewController {

    @IBOutlet var jobTextField: NSTextView!
    @IBOutlet weak var resultTextField: NSTextField!
    
    // MARK: - This Model is in early early stage, and will not be accurate with One-Hundred Percent.
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func checkClick(_ sender: Any) {
        
        guard let jobBuffer = jobTextField.textStorage?.string else {
            return
        }
        
        let jobModel = try? AreYouIOSDev.init(
            configuration: .init()
        )
        guard let jobModel = jobModel else {
            return
        }
        
        let jobInput = AreYouIOSDevInput(text: jobBuffer.lowercased())
        
        guard let checkResult = try? jobModel.prediction(input: jobInput) else {
            return
        }

        resultTextField.stringValue = "Are you IOS Developer? \(checkResult.label)"
        if(checkResult.label == "yes") {
            resultTextField.textColor = .systemBlue
        } else {
            resultTextField.textColor = .systemRed
        }
        
    }
}

