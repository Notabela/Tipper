//
//  SettingsViewController.swift
//  Tipper
//
//  Created by daniel on 12/9/16.
//  Copyright © 2016 Notabela. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController
{

    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadDefaults()
    }

    @IBAction func onDismiss(_ sender: Any)
    {
        saveDefaults()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveDefaults()
    {
        let defaults = UserDefaults.standard
        defaults.set(segmentControl.selectedSegmentIndex, forKey: "default_tip_percentage")
        defaults.synchronize()
    }
    
    private func loadDefaults()
    {
        let defaults = UserDefaults.standard
        let default_tip: Int? = defaults.integer(forKey: "default_tip_percentage")
        segmentControl.selectedSegmentIndex = default_tip ?? 0
    }

}
