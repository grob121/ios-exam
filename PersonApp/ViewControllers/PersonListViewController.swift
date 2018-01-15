//
//  PersonListViewController.swift
//  PersonApp
//
//  Created by Allan Pagdanganan on 15/01/2018.
//  Copyright © 2018 Cybilltek Software Inc. All rights reserved.
//

import Foundation
import UIKit

class PersonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var personTableView: UITableView!
    
    var personArray:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTableView.delegate = self;    //set delegate for the tableView
        personTableView.dataSource = self;  //set dataSource for the tableView
        
        let defaults = UserDefaults.standard
        
        //pull out and unwrap optional data
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            personArray = NSKeyedUnarchiver.unarchiveObject(with: savedPeople) as! [Person] //convert data object to array
        } else {
            loadPeople()
        }
    }
    
    func loadPeople(){
        //create NSURL with the URL string
        let url = NSURL(string: "https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole")
        
        //fetch tha data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            //extract jsonObject as array
            if let jsonArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                
                //loop through all the objects in array
                for jsonObj in jsonArray! {
                    
                    //cast the object as dictionary
                    if let jsonDict = jsonObj as? NSDictionary {
                        
                        //get the string objects from dictionary
                        let firstName = jsonDict.object(forKey: "first") as! String
                        let lastName = jsonDict.object(forKey: "last") as! String
                        let birthday = jsonDict.object(forKey: "created") as! String
                        let emailAdd = jsonDict.object(forKey: "email") as! String
                        let mobileNo = jsonDict.object(forKey: "balance") as! String
                        let address = jsonDict.object(forKey: "address") as! String
                        let contactPerson = String(format: "%@ %@",jsonDict.object(forKey: "last") as! String, jsonDict.object(forKey: "first") as! String)
                        let contactPersonNo = jsonDict.object(forKey: "balance") as! String
                        
                        //call the method to calculate age with parameter birthday
                        let age = self.calculateAge(birthday: jsonDict.object(forKey: "created") as! String)
                        
                        //cast the strings to the the model initializer
                        let person = Person(firstName: firstName, lastName: lastName, birthday: birthday, age: age, emailAdd: emailAdd, mobileNo: mobileNo, address: address, contactPerson: contactPerson, contactPersonNo: contactPersonNo)
                        
                        //append model created to the array
                        self.personArray.append(person)
                    }
                }
                
                //prioritize this operation after fetching data
                OperationQueue.main.addOperation({
                    self.personTableView.reloadData()   //reload tableView
                    self.saveToDefaults()
                })
            }
        }).resume()
    }
    
    func saveToDefaults() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: personArray)   //convert array into data object
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")   //save data object to userDefaults
    }
    
    func calculateAge(birthday:String) -> String {
        //convert date String to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let date = dateFormatter.date(from:birthday)!
        
        //get current date
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        //calculate age based on current date and birthdate
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        
        //return age converted to String
        return String(age);
    }
    
    // MARK: Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1    //set the number of sections in tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count    //set the number of rows in tableView based on the count of array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as UITableViewCell   //identify the cell to be used
        
        cell.textLabel?.text = personArray[indexPath.row].firstName + " " + personArray[indexPath.row].lastName  //set text for the label in cell
        
        return cell
    }
    
    // MARK: Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdvc = self.storyboard!.instantiateViewController(withIdentifier: "PersonDetailViewController") as! PersonDetailViewController  //instantiate destination viewController
        
        pdvc.person = personArray[indexPath.row]    //pass model object based from the index path clicked on table view
        
        self.navigationController!.pushViewController(pdvc, animated: true) //move to destination viewController
    }
}

