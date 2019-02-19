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
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        fetchUsers()
    }

    // MARK: - Table view data source
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded) { (DataSnapshot) in
            
            if let dictionary = DataSnapshot.value as? [String: AnyObject]{
                let user = User()
               
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            let user = users[indexPath.row]
            cell.textLabel?.text = user.name
            cell.detailTextLabel?.text = user.email
            return cell
    }

}



class UserCell : UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no implementation")
    }
}
