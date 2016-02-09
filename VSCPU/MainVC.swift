//
//  MainVC.swift
//  VSCPU
//
//  Created by Walter Berreta on 11/18/15.
//  Copyright © 2015 Edsims. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var CommandPicker: UIPickerView!
    
    @IBOutlet weak var CommandView: UITextView!
    
    @IBOutlet weak var CommandNumber: UITextField!
    
    let pickerData = ["ADD", "AND", "JMP", "INC"]
    
    var pickerValue = ""
    
    var counting = 0
    
    var arrInst = [String]()
    
    var InstStackFull = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.CommandPicker.delegate = self
        
        self.CommandPicker.dataSource = self
        
        CommandNumber.keyboardType = .NumberPad
        
        CommandView.text = ""
        CommandView.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        CommandView.layer.borderColor = UIColor.blackColor().CGColor
        CommandView.layer.borderWidth = 2.0;
        CommandView.layer.cornerRadius = 5.0;
        
        CommandPicker.layer.borderColor = UIColor.blackColor().CGColor
        CommandPicker.layer.borderWidth = 2.0;
        CommandPicker.layer.cornerRadius = 5.0;
      
        CommandNumber.layer.borderColor = UIColor.blackColor().CGColor
        CommandNumber.layer.borderWidth = 2.0;
        CommandNumber.layer.cornerRadius = 5.0;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func InsertToTextView(sender: AnyObject) {
        if (counting < 5 && (CommandNumber.text != ""))
        {
            CommandView.text = ""
            let tempStr = String(counting) + ": " + pickerValue + " " + CommandNumber.text! + "\n"
            arrInst.insert( tempStr , atIndex:counting)
            for var i = 0; i < arrInst.count; i++
            {
                CommandView.text! += arrInst[i]
            }
            counting++
        }
    }
    
    @IBAction func RemoveFromTextView(sender: UIButton) {
        if (!arrInst.isEmpty)
        {
            CommandView.text = ""
            counting--
            arrInst.removeLast()
            for var i = 0; i < arrInst.count; i++
            {
                CommandView.text! += arrInst[i]
            }
        }
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerValue = pickerData[row]
        return pickerValue
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
