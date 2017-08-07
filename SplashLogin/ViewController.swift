//
//  ViewController.swift
//  SplashLogin
//
//  Created by Lynn on 8/3/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
import LocalAuthentication
import FBSDKLoginKit


class ViewController: UIViewController {

    @IBOutlet weak var fingerPrinterBtn: UIImageView!
    @IBOutlet weak var rotateImage: UIImageView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var userNameImage: UIImageView!
    var originSignIn:CGRect!
    var loginButton:FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        password.isSecureTextEntry = true
        signInBtn.setTitle("Sign In", for: .normal)
        loginButton = FBSDKLoginButton()
        loginButton?.center = CGPoint(x:187.5, y:532)
        self.view.addSubview(loginButton!)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInBtn.center.y = view.frame.size.height
        signInBtn.center.x = view.frame.size.width
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.frame = self.originSignIn
        //signInBtn.layer.removeAllAnimations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UISetUp(){
        originSignIn = CGRect(x: 37, y: 458, width: 320, height: 44)
        userNameImage.image = IonIcons.image(withIcon: ion_ios_person_outline, iconColor: .white, iconSize: 30, imageSize: CGSize(width: 30, height: 44))
        passwordImage.image = IonIcons.image(withIcon: ion_ios_locked_outline, iconColor: .white, iconSize: 30, imageSize: CGSize(width: 30, height: 44))
        rotateImage.image = IonIcons.image(withIcon: ion_load_c, iconColor: .white, iconSize: 35, imageSize: CGSize(width: 35, height: 35))
        rotateImage.isHidden = true
        signInBtn.layer.cornerRadius = signInBtn.frame.size.height / 2
    }
 
    @IBAction func fingerPrint(_ sender: UIButton) {
        let authenticationContext = LAContext()
        var error:NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else{
            let alert = UIAlertController(title: "Error", message: "This device does not jave a TouchID sensor.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Only awesome people are allowed") { [unowned self](success, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancel)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                   self.signInBtn.sendActions(for: .touchUpInside)
                }
            }
        }
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        /*let shrink = CABasicAnimation(keyPath: "transform.scale.x")
        shrink.toValue = 44 / signInBtn.bounds.width
        shrink.duration = 0.25
        shrink.fillMode=kCAFillModeForwards
        shrink.isRemovedOnCompletion = false
        signInBtn.layer.add(shrink, forKey: nil)*/
        self.signInBtn.frame.size.width = 44
        signInBtn.center.x = view.frame.size.width / 2
        signInBtn.setTitle("", for: .normal)
        rotateImage.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0.8, options: .allowAnimatedContent, animations: {
                self.rotateImage.rotate360Degrees()
                sender.frame = UIScreen.main.bounds
        }) { (done) in
            self.rotateImage.isHidden = true
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let toContent = storyboard.instantiateViewController(withIdentifier: "CVC")
            self.navigationController?.pushViewController(toContent, animated: false)
        }
        
    }

    @IBAction func signUp(_ sender: UIButton) {
        
    }
  
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailTest.evaluate(with: textField.text){
                password.becomeFirstResponder()
            }else{
                userName.shake()
                Utility.vibrate()
                userName.text = ""
                return false
            }
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}
