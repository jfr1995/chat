

import UIKit
import Firebase

class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Message view controller view did load ")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(handleCreateMessage))
        checkIfUserIsLoggedIn()
    }
    
    @objc func handleCreateMessage(){
        let newMessageController = NewMessageController()
        present(UINavigationController(rootViewController: newMessageController), animated: true, completion: nil)
    }
    func checkIfUserIsLoggedIn(){
        // user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid  = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (DataSnapshot) in
                if let dictionnary = DataSnapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionnary["name"] as? String
                }
            }
        }
    }
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let loginError {
            print(loginError)
        }
        let lcontroller  = loginController()
        present(lcontroller, animated: true, completion: nil)
        
    }
  

}

