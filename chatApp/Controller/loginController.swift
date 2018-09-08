
//// create and setup the inputs container
//let inputsContainer = UIView()
//inputsContainer.backgroundColor = UIColor.white
//inputsContainer.translatesAutoresizingMaskIntoConstraints = false
//view.addSubview(inputsContainer)
//inputsContainer.layer.cornerRadius = 10
//inputsContainer.layer.masksToBounds = true
//
//// need an x, y, width and height constraints
//inputsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//inputsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//inputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120).isActive = true
//inputsContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true


import UIKit

class loginController: UIViewController {
    //inputs container variable
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        

    }


    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}


extension UIColor{
    
    convenience init( r : CGFloat, g: CGFloat, b: CGFloat){
    self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
