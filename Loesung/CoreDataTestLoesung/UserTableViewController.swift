//
//  UserTableViewController.swift
//  CoreDataTest
//
//  Created by Anatol Walger on 03.06.20.
//  Copyright © 2020 Anatol Walger. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController {
    
    // MARK: - Context initialisieren
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var users : [NSManagedObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    
    // MARK: - createUser() implementieren
      func createUser(name: String, password: String) {
          
          let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
          let user = NSManagedObject(entity: entity, insertInto: context)
          
          user.setValue(name, forKeyPath: "name")
          user.setValue(password, forKeyPath: "password")
          
           do {
              try context.save()
    
                  }
                 catch let error as NSError {
                  print("Could not fetch. \(error), \(error.userInfo) ")
        }
        
      }
    
        
    @IBAction func addUsers(_ sender: UIBarButtonItem) {
        
        // MARK: - Test-Benutzer erstellen mit der createUser()
//
//        createUser(name: "Peter", password: "12345")
//         createUser(name: "Herbert", password: "45678")
//
//        print("Users created")
        
        
    // MARK: - Bonus: Test-Benutzer erstellen mit der createUser() und dem Alert-Fenster
          let alert = UIAlertController(title: "New User",
                                        message: "Add a new user",
                                        preferredStyle: .alert)

        alert.addTextField { (usernameTextField) in
            usernameTextField.placeholder = "Username eingeben"
        }

        alert.addTextField { (ageTextField) in
            ageTextField.placeholder = "Passwort eingeben"

              }

          let saveAction = UIAlertAction(title: "Save",
                                         style: .default) {
            (saveAction) in


        self.createUser(name: (alert.textFields?.first?.text!)!, password: (alert.textFields?.last?.text!)!)

                                              print("Users created")




          }

          let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .cancel)


        alert.addAction(saveAction)
          alert.addAction(cancelAction)

          present(alert, animated: true)
        
        
    
    }
    
    
    // MARK: - fetchUsers() implementieren, um die Benutzer aus dem Speicher zu laden
          func fetchUsers() {
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
              
              
              do {
                  users = try context.fetch(fetchRequest)
          
              } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo) ")
              }
             
          }
      
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
       // MARK: - User mit der fetchUsers() laden, um die Tabelle beim Starten der App mit Daten zu füllen

         fetchUsers()
       }
    
  
    
    @IBAction func loadUsers(_ sender: UIBarButtonItem) {
           
        
         // MARK: - richtige Methode laden
        
           //fetchUsers()
        
           fetchSpecificUsers()
             
        
           print("Users loaded")
           
           
       
       }
    
    
    // MARK: - Bonus: Mit Predicate nur Benutzer mit Namen "Herbert" laden
       func fetchSpecificUsers() {
           
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
                  
           fetchRequest.predicate = NSPredicate(format: "name == %@", "Herbert")
                  
                  do {
                      users = try context.fetch(fetchRequest)
              
                  } catch {
                      print(error.localizedDescription)
                  }
       }
    
    
    
    
    
    
    
    
    // MARK: - Ab hier nichts ändern
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
          return users.count
      }

      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

          let user = users[indexPath.row]
          
          cell.textLabel?.text = user.value(forKeyPath: "name") as? String
    
          cell.detailTextLabel?.text = user.value(forKeyPath: "password") as? String

          return cell
      }
    
    
    @IBAction func deleteUsers(_ sender: UIBarButtonItem) {
           
           deleteUser()
        print("Users deleted")
           
       }
       
    
    func deleteUser() {
          let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do
                  {
                      try context.execute(deleteRequest)
                      try context.save()
                    
                     self.users = []
                   
                  }
                  catch
                  {
                      print ("There was an error")
                  }
      
       }
}


