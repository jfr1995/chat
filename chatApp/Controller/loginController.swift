

import UIKit
import Firebase

class loginController: UIViewController {
    
    
    // grab referecne to constraint anchor
    var inputsContainerViewHeightAnchor : NSLayoutConstraint?
    
    
    // grab references to text fields
    var nameTextFieldHeightAnchor : NSLayoutConstraint?
    var emailTextFieldHeightAnchor : NSLayoutConstraint?
    var passwordTextFieldHeightAnchor : NSLayoutConstraint?
    
    
    
    let loginSegmentedControls : UISegmentedControl = {
       let segmentedControl  = UISegmentedControl(items: ["Sign In", "Register"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return segmentedControl
    }()
    
    @objc func handleSegmentChange(){
        guard let title = loginSegmentedControls.titleForSegment(at: loginSegmentedControls.selectedSegmentIndex) else {
            return
        }
        registerButton.setTitle(title, for: .normal)
        print(loginSegmentedControls.selectedSegmentIndex)
        inputsContainerViewHeightAnchor?.constant = loginSegmentedControls.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of name text field
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentedControls.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        // change height of email and password text fields
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentedControls.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentedControls.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true 
    }
    
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var registerButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let separatorView : UIView = {
        let sv = UIView()
        //sv.backgroundColor = UIColor.init(r: 220, g: 220, b: 220)
        sv.backgroundColor = UIColor.black
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let separatorView2 : UIView = {
        let sv2 = UIView()
        //sv.backgroundColor = UIColor.init(r: 220, g: 220, b: 220)
        sv2.backgroundColor = UIColor.black
        sv2.translatesAutoresizingMaskIntoConstraints = false
        return sv2
    }()
    
    let nameTextField : UITextField = {
        let textField  = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField : UITextField = {
        let ef = UITextField()
        ef.placeholder = "Email"
        ef.translatesAutoresizingMaskIntoConstraints = false
        return ef
    }()
    
    let passwordTextField : UITextField = {
        let pf = UITextField()
        pf.placeholder = "Password"
        pf.translatesAutoresizingMaskIntoConstraints =  false
        pf.isSecureTextEntry = true
        return pf
    }()
    
    let loginTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = UIColor.white
        label.text = "Chat App"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputsContainerView)
        view.addSubview(registerButton)
        view.addSubview(loginTitle)
        view.addSubview(loginSegmentedControls)
        setupInputsContainerView()
        setupRegisterLoginButton()
        setupLoginSegmentedControls()
        
    }
    
    
    // function to handle register button action
    @objc func handleRegister(){
        // ensure there is a response in the email and password fields
        guard let email = emailTextField.text else {
            print("invalid input for email")
            return
        }
        guard let password = passwordTextField.text else {
            print("invalid input for password")
            return
        }
        guard let name = nameTextField.text else {
            print("Please enter a name")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            // ...
            print("\n\n\n\n")
            if error != nil {
                print("error 11111111")
                return
            }
            guard let uid  = authResult?.user.uid else {
                return
            }
            // successfully created
            let ref =  Database.database().reference(fromURL: "https://primeval-proton-202518.firebaseio.com/")
            let val = ["name": name, "email": email]
            let userRef = ref.child("users").child(uid)
            userRef.updateChildValues(val, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                print("users saved into firebase database")
            })
            
        }
        
        
        
    }
    
    func setupLoginSegmentedControls() {
        // x, y, width, and height
        loginSegmentedControls.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginSegmentedControls.heightAnchor.constraint(equalToConstant: 34).isActive = true
        loginSegmentedControls.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSegmentedControls.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -10).isActive = true
    }
    
    func setupRegisterLoginButton(){
        // need x, y, widht, and height constraints
        registerButton.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setupInputsContainerView(){
        
        //inputs container view constraints
        inputsContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        /////////////////////////////////////////////////////////////////
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        // add the subviews of inputs container view
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(separatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(separatorView2)
        inputsContainerView.addSubview(passwordTextField)
    
        
        
        // name text field constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor =  nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        // email field constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant : 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor =  emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        // password field constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant : 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: separatorView2.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        // separator view constraints
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0).isActive = true
        // separator view 2 constraints
        separatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        separatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        separatorView2.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        
        
        // title label constraints
        loginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTitle.bottomAnchor.constraint(equalTo: loginSegmentedControls.topAnchor, constant: -16).isActive = true
        loginTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        
        
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
