//
//  Person.swift
//  PersonApp
//
//  Created by Allan Pagdanganan on 15/01/2018.
//  Copyright © 2018 Cybilltek Software Inc. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
    var firstName:String
    var lastName:String
    var birthday:String
    var age:String
    var emailAdd:String
    var mobileNo:String
    var address:String
    var contactPerson:String
    var contactPersonNo:String
    
    init(firstName: String, lastName: String, birthday: String, age: String, emailAdd: String, mobileNo: String, address: String, contactPerson: String, contactPersonNo: String) {
        //initialize objects from values inserted
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.age = age
        self.emailAdd = emailAdd
        self.mobileNo = mobileNo
        self.address = address
        self.contactPerson = contactPerson
        self.contactPersonNo = contactPersonNo
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        //decode and load objects of this class
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        self.birthday = aDecoder.decodeObject(forKey: "birthday") as! String
        self.age = aDecoder.decodeObject(forKey: "age") as! String
        self.emailAdd = aDecoder.decodeObject(forKey: "emailAdd") as! String
        self.mobileNo = aDecoder.decodeObject(forKey: "mobileNo") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.contactPerson = aDecoder.decodeObject(forKey: "contactPerson") as! String
        self.contactPersonNo = aDecoder.decodeObject(forKey: "contactPersonNo") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        //encode and save objects
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(emailAdd, forKey: "emailAdd")
        aCoder.encode(mobileNo, forKey: "mobileNo")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(contactPerson, forKey: "contactPerson")
        aCoder.encode(contactPersonNo, forKey: "contactPersonNo")
    }
}

