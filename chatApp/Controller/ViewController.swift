

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }
    @objc func handleLogout(){
        let lcontroller  = loginController()
        present(lcontroller, animated: true, completion: nil)
        
    }
  

}

