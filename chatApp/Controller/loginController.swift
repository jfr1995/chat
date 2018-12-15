

import UIKit

class loginController: UIViewController {

    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        
        
    }
    
    
    func setupInputsContainerView(){
        //constraints need x, y, width and height
        inputsContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
    self.init(red : r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
