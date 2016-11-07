//
//  ViewController.swift
//  FacebookPirata
//
//  Created by Pablo Sedano on 04/11/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBOutlet var txtUsuario: UITextField!
    @IBOutlet var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
        
        navigationController?.navigationBar.isHidden = true
        
        if KeychainWrapper.standard.string(forKey: "FB_UID") != nil || KeychainWrapper.standard.string(forKey: "EMAIL_UID") != nil {
            
            print("El usuario ya habia ingresado anteriormente")
            //Pasar al siguiente VC
            
        }
        
    }
    
    @IBAction func emailBtnPressed(_ sender: UIButton) {
        
        if let email = txtUsuario.text, let pwd = txtPassword.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { user, error in
                
                if error != nil, let err = error as? NSError {
                    
                    if err.code == ERROR_PASSWORD_NOT_LONG {
                        print("Favor de ingresar un password de más de 6 caracteres.")
                    } else if err.code == ERROR_ACCOUNT_ALREADY_USED {
                        print("La cuenta de correo ya está siendo usada.")
                        
                        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { user, error in
                            
                            if error != nil, let err = error as? NSError {
                                
                                print(err)
                                if err.code == ERROR_INVALID_PASSWORD {
                                    print("El password ingresado no es valido.")
                                } else {
                                    
                                }
                                
                            } else {
                                // Ir al siguiente VC
                                print("Login Email exitoso")
                                KeychainWrapper.standard.set(user!.uid, forKey: "EMAIL_UID")
                            }
                            
                        })
                    }
                    
                } else {
                    
                }
            })
        } else {
            print("Favor de introducir su usuario y password")
        }
    }
    
    @IBAction func faceBookBtnPressed(_ sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions: ["email"], from: self) { result, error in
            
            if error != nil {
                print("No se pudo conectar con Facebook")
            } else if result?.isCancelled == true {
                print("El usuario ha cancelado el login con Facebook")
            } else {
                print("Login exitoso con Facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
            
        }
    }

    func firebaseAuth(_ credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { user, error in
            
            if error != nil {
                print("No se pudo autenticar con Firebase: Error: \(error.debugDescription)")
            } else {
                print("Se autenticó con exito con Firebase")
                
                print("Usuario: \(user?.displayName)")
                KeychainWrapper.standard.set(user!.uid, forKey: "FB_UID")
                //Ir al siguiente VC
            }
            
        })
    }

}

