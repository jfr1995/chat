//
//  NewMessageController.swift
//  chatApp
//
//  Created by Juan Ramirez on 1/19/19.
//  Copyright © 2019 Juan Ramirez. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    let cellID = "Some cell"
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        fetchUsers()
    }

    // MARK: - Table view data source
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded) { (DataSnapshot) in
            let dictionary = DataSnapshot.value as? [String: AnyObject?] ?? [:]
            let newUsers = User()
            newUsers.name = (dictionary["name"]! as! String)
            newUsers.email = (dictionary["email"]! as! String)
            self.users.append(newUsers)
        }
    
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            cell.textLabel?.text = "some text"
            return cell
    }

}
