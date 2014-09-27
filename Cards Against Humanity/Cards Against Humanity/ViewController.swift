//
//  ViewController.swift
//  Cards Against Humanity
//
//  Created by Daniel Valencia on 9/26/14.
//  Copyright (c) 2014 Daniel Valencia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var testObject = PFObject(className: "TestObject")
        testObject.setObject("bar", forKey: "foo")
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            if success {
                NSLog("Object created with id: \(testObject.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

