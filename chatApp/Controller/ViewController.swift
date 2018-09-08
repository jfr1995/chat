

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(handleLogout))
    }

    @objc func handleLogout(){
        let lController = loginController()
        present(lController, animated: true, completion: nil)
        
    }


}

