//
//  ViewController.swift
//  MLChecker
//
//  Created by Shady El-Maadawy on 30/12/2023.
//

import Cocoa
import CoreML
import OrcaEngine


class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

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
    @IBOutlet weak var keyWordsTable: NSTableView!
    var keywords :Set<OrcaKeyword> = .init()
    let engine = OrcaEngine.init()
    @IBAction func checkClick(_ sender: Any) {
        
    guard let jobBuffer = jobTextField.textStorage?.string else {
        return
    }
        keywords.removeAll(keepingCapacity: true)
        engine.extractKeywords(
            jobBuffer,
            isSuitable: true
        ).forEach({ value in
            keywords.insert(value)
        })
        
        keyWordsTable.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return keywords.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Keywords Cell"), owner: self) as? NSTableCellView else { return nil }
        
        let setIndx = keywords.index(keywords.startIndex, offsetBy: row)
        let keyword = keywords[setIndx]
        cell.textField?.stringValue = keyword.keywordValue

        return cell

    }
}

