//
//  PersonDetailViewController.swift
//  PersonApp
//
//  Created by Allan Pagdanganan on 15/01/2018.
//  Copyright © 2018 Cybilltek Software Inc. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailViewController: UIViewController {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var emailAdd: UILabel!
    @IBOutlet weak var mobileNo: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contactPerson: UILabel!
    @IBOutlet weak var contactPersonNo: UILabel!
    
    public var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"  //set title of navigation bar
        
        //set text of labels from the model
        name.text = person.firstName + " " + person.lastName
        birthday.text = person.birthday
        age.text = person.age
        emailAdd.text = person.emailAdd
        mobileNo.text = person.mobileNo
        address.text = person.address
        contactPerson.text = person.contactPerson
        contactPersonNo.text = person.contactPersonNo
    }

}
