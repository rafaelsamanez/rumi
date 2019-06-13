//
//  LoginRoomerViewController.swift
//  rumi
//
//  Created by Israel Matias on 6/12/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import os

class LoginRoomerViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let loginRequest = LoginRequest(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "")
        
        AccountApi.signIn(loginRequest: loginRequest, responseHandler: handleResponse, errorHandler: handleError)
    }
    
    func handleResponse(response: LoginResponse) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarRoomerViewController") as! TabBarRoomerViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func handleError(error: Error) {
        let message = "Error while requesting SignIn: \(error.localizedDescription)"
        os_log("%@", message)
        showToast(message: "Ha ocurrido un error")
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
