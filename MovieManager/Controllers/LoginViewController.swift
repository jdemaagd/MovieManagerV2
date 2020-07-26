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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!      // not email!
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
    
    func handleLoginResponse(success: Bool, error: Error?) {
        print(TMDBClient.Auth.requestToken)
        if (success) {
            TMDBClient.createSession(completion: handleSessionResponse(success:error:))
        }
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if (success) {
            print(TMDBClient.Auth.requestToken)
            TMDBClient.login(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        
        if (success) {
            self.performSegue(withIdentifier: "completeLoginSegue", sender: nil)
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    @IBAction func loginViaWebsiteTapped() {
        setLoggingIn(true)
        TMDBClient.getRequestToken { (success, error) in
            if (success) {
                // hand-off validating request token to browser:
                // must handle redirect url in AppDelegate/SceneDelegate
                //UIApplication.shared.open(Client.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                
                self.performSegue(withIdentifier: "completeLoginSegue", sender: nil)
            }
        }
    }
}
