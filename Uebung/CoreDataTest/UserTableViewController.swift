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
  
    
    
    // MARK: - Definition des Datenmodells in der .xcdatamodeld nicht vergessen
    
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
        
      
        
    }

    
    @IBAction func addUsers(_ sender: UIBarButtonItem) {
        
        // MARK: - Test-Benutzer erstellen mit der createUser()
              

        
   
        print("Users created")
        
        
//    // MARK: - Bonus: Test-Benutzer erstellen mit der createUser() und dem Alert-Fenster
//          let alert = UIAlertController(title: "New User",
//                                        message: "Add a new user",
//                                        preferredStyle: .alert)
//
//        alert.addTextField { (usernameTextField) in
//            usernameTextField.placeholder = "Username eingeben"
//        }
//
//        alert.addTextField { (ageTextField) in
//            ageTextField.placeholder = "Passwort eingeben"
//
//              }
//
//          let saveAction = UIAlertAction(title: "Save",
//                                         style: .default) {
//            (saveAction) in
//
//
//        // MARK: - createUser() aufrufen mit den Inhalten der Textfelder
//        // Zugriff auf erstes Textfeld mit (alert.textFields?.first?.text!)!
//        // und zweites Textfeld mit (alert.textFields?.last?.text!)!
//
//
//
//
//
//        print("Users created")
//
//          }
//
//          let cancelAction = UIAlertAction(title: "Cancel",
//                                           style: .cancel)
//
//
//        alert.addAction(saveAction)
//          alert.addAction(cancelAction)
//
//          present(alert, animated: true)
//
        
    
    }
    
    

    // MARK: - fetchUsers() implementieren
      func fetchUsers() {
        
   
        
      }
    
    
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
     // MARK: - User mit der fetchUsers() laden, um die Tabelle beim Starten der App mit Daten zu füllen

        
         
         
     }

  
    
    @IBAction func loadUsers(_ sender: UIBarButtonItem) {
           
        
         // MARK: - richtige Methode laden
        
           fetchUsers()
        
           //loadSpecificUsers()
             
        
           print("Users loaded")
           
           
       
       }
    
    
    // MARK: - Bonus: Mit Predicate nur Benutzer mit Namen "Herbert" laden
       func fetchSpecificUsers() {
           
           
         
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
    
}


