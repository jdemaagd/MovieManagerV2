//
//  ViewController.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/21/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var webLoginButton: UIButton!
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    // MARK: - private methods
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if components?.scheme == "themoviemanager" && components?.path == "authenticate" {
            //let loginVC = window?.rootViewController as! LoginViewController
            //Client.createSession(completion: loginVC.handleSessionResponse(sucess:error:))
        }
        return true
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        self.performSegue(withIdentifier: "completeLoginSegue", sender: nil)
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if (success) {
            print(Client.Auth.requestToken)
            Client.createSession(completion: self.handleSessionResponse(success:error:))
        }
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if (success) {
            print(Client.Auth.requestToken)
            Client.login(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        Client.getRequestToken(completion: self.handleRequestTokenResponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        Client.getRequestToken { (success, error) in
            if success {
                // hands-off task of validating request token to browser
                // but must handle redirect url
                UIApplication.shared.open(Client.Endpoints.webAuth.url, options: [:], completionHandler: nil)
            }
        }
    }
}
