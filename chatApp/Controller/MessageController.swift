

import UIKit
import Firebase

class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        checkIfUserIsLoggedIn()
    }
    
    
    func checkIfUserIsLoggedIn(){
        // user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
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

