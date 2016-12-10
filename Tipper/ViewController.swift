//
//  ViewController.swift
//  Tipper
//
//  Created by daniel on 12/8/16.
//  Copyright © 2016 Notabela. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabel2: UILabel!
    @IBOutlet weak var totalLabel3: UILabel!
    @IBOutlet weak var totalLabel4: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var totalView: UIView!
    
    var viewPosition: CGPoint!
    var segmentPosition: CGPoint!
    var textFieldPosition: CGPoint!
    
    var currencyFormatter: NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewPosition = totalView.center
        segmentPosition = tipControl.center
        textFieldPosition = textField.center
        
        textField.becomeFirstResponder()
        hideViews(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appeared")
        loadDefaults()
        calculateTip(Any.self)
    }

    @IBAction func calculateTip(_ sender: Any)
    {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(textField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        textField.placeholder = currencyFormatter.currencySymbol
        tipLabel.text = currencyFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: tip+bill))
        totalLabel2.text = currencyFormatter.string(from: NSNumber(value: tip+bill*2))
        totalLabel3.text = currencyFormatter.string(from: NSNumber(value: tip+bill*3))
        totalLabel4.text = currencyFormatter.string(from: NSNumber(value: tip+bill*4))
        
        if (textField.text?.isEmpty)! {
            hideViews(animated: true)
        } else {
            showViews()
        }
    }
    
    @IBAction func changedTip(_ sender: Any)
    {
        calculateTip(Any.self)
    }
    
    //MARK : Gesture Recognizers
    @IBAction func onTapView(_ sender: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    //MARK : Private Functions
    private func hideViews(animated: Bool)
    {
        if animated
        {
            UIView.animate(withDuration: 0.3, animations: {
                self.totalView.center.y = self.view.center.y + self.view.frame.height
                self.totalView.alpha = 0
                //self.tipControl.center.y = self.view.center.y + self.view.frame.height
                self.tipControl.frame.origin.x = -self.view.frame.width
                self.tipControl.alpha = 0
                self.textField.center.y = self.view.frame.height / 3
            })
        }
        else
        {
            self.totalView.center.y = self.view.center.y + self.view.frame.height
            //self.tipControl.center.y = self.view.center.y + self.view.frame.height
            self.tipControl.frame.origin.x = -self.view.frame.width
            self.textField.center.y = self.view.frame.height / 3
        }
    }
    
    private func showViews()
    {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.totalView.center = self.viewPosition
            self.totalView.alpha = 1
            self.tipControl.center = self.segmentPosition
            self.tipControl.alpha = 1
            self.textField.center = self.textFieldPosition
        })
    }
    
    private func loadDefaults()
    {
        let defaults = UserDefaults.standard
        let default_tip: Int? = defaults.integer(forKey: "default_tip_percentage")
        tipControl.selectedSegmentIndex = default_tip ?? 0
    }
    
}

