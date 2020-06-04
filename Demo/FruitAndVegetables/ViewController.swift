//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Anatol Walger on 04.06.20.
//  Copyright http://www.brianadvent.com/build-simple-core-data-driven-ios-app/
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var foodItems : [NSManagedObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    
    func loadData(){
      
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Food")
        
        
        // 2
        let sortDescriptor = NSSortDescriptor(key: "added", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
                         foodItems = try context.fetch(fetchRequest)
                 
                     } catch let error as NSError {
                       print("Could not fetch. \(error), \(error.userInfo) ")
                     }
        
    
//        self.tableView.reloadData()
    }

    
    
    @IBAction func addFoodToDatabase(_ sender: UIButton) {
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Food", in: context)!
                 let foodItem = NSManagedObject(entity: entity, insertInto: context)
                 
       
         foodItem.setValue(NSDate(), forKeyPath: "added")
             
             if sender.tag == 0 {
                
                 foodItem.setValue("Fruit", forKeyPath: "type")
              
             }else {
                 foodItem.setValue("Vegetable", forKeyPath: "type")
             }
             
              do {
                          try context.save()
                
                              }
                             catch let error as NSError {
                              print("Could not fetch. \(error), \(error.userInfo) ")
                    }
             
             loadData()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return foodItems.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           
           // 1
           let foodItem = foodItems[indexPath.row]
           
           // 2
           let foodType = foodItem.value(forKeyPath: "type") as? String
           cell.textLabel?.text = foodType
           
           let foodDate = foodItem.value(forKeyPath: "added") as! Date
       
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMMM d yyyy, hh:mm"
           
           cell.detailTextLabel?.text = dateFormatter.string(from: foodDate)
           
           // 4
           if foodType == "Fruit" {
               cell.imageView?.image = UIImage(named: "Apple")
           }else{
               cell.imageView?.image = UIImage(named: "Salad")
           }
           
           return cell
       }
    

}

