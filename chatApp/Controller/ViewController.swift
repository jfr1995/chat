

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(fromURL: "https://primeval-proton-202518.firebaseio.com/")
        ref.updateChildValues(["someValue": 123])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }
    @objc func handleLogout(){
        let lcontroller  = loginController()
        present(lcontroller, animated: true, completion: nil)
        
    }
  

}

