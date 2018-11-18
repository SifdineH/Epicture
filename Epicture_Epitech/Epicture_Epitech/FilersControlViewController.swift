//
//  FilersControlViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 17/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit

class FilersControlViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var section = [String]()
    var sort = [String]()
    var window = [String]()
    var globalSection: String = "hot"
    var globalSort: String = "viral"
    var globalWindow: String = "day"

    @IBOutlet weak var saveChanges: UIButton!
    @IBOutlet weak var OUT: UIButton!
    
    @IBOutlet weak var sectionFilters: UIPickerView!
    @IBOutlet weak var sortFilters: UIPickerView!
    @IBOutlet weak var sectionText: UITextField!
    @IBOutlet weak var sortText: UITextField!
    @IBOutlet weak var windowText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(OUT)
        sectionText.isUserInteractionEnabled = false
        sortText.isUserInteractionEnabled = false
        windowText.isUserInteractionEnabled = false
        section = ["hot", "top", "user"]
        sort = ["viral", "top", "time"]
        window = ["day", "week", "mounth", "year", "all"]
        saveChanges.layer.cornerRadius = 25
        saveChanges.layer.borderWidth = 1.5
        saveChanges.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 1.0).cgColor
    }
    
    @IBAction func SaveSectionChanges(_ sender: Any) {
        EntryViewController.GlobalVariable.FilerSection = globalSection
        EntryViewController.GlobalVariable.FilerSort = globalSort
        EntryViewController.GlobalVariable.FilerWindow = globalWindow
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let TabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
        self.present(TabBarViewController, animated:true, completion:nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return section[row]
        } else if (pickerView.tag == 2){
            return sort[row]
        } else {
            return window[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return section.count
        } else if (pickerView.tag == 2) {
            return sort.count
        } else {
            return window.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if (pickerView.tag == 1) {
            globalSection = section[row]
        } else if (pickerView.tag == 2) {
            globalSort = sort[row]
        } else {
            globalWindow = window[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData: String
        var myTitle: NSAttributedString

        if (pickerView.tag == 1) {
            titleData = section[row]
        } else if (pickerView.tag == 2) {
            titleData = sort[row]
        } else {
            titleData = window[row]
        }
         myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedString.Key.foregroundColor:UIColor(red:0.96, green:0.80, blue:0.54, alpha:1.0)])
        return myTitle
    }
    

}
