//
//  ViewController.swift
//  StudentAdmissionSQLiteApp
//
//  Created by DCS on 21/08/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var studArray = [Students]()
    private let username: UITextField = {
        let usr = UITextField()
        
        usr.textAlignment = .center
        usr.autocapitalizationType = .none
        usr.autocorrectionType = .no
        usr.font = UIFont(name: "", size: 20.0)
        usr.backgroundColor = .init(red: 0.921, green: 0.941, blue: 0.953, alpha: 1)
        usr.attributedPlaceholder = NSAttributedString(string: "USERNAME", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(red: 0.234, green: 0.289, blue: 0.294, alpha: 1)])
        usr.layer.cornerRadius = 20
        
        return usr
        
    } ()
    
    private let password: UITextField = {
        let psw = UITextField()
        psw.textAlignment = .center
        psw.autocorrectionType = .no
        psw.font = UIFont(name: "", size: 20.0)
        psw.isSecureTextEntry = true
        psw.backgroundColor = .init(red: 0.921, green: 0.941, blue: 0.953, alpha: 1)
        psw.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(red: 0.234, green: 0.289, blue: 0.294, alpha: 1)])
        psw.layer.cornerRadius = 20
        return psw
        
    } ()
    
    private let login : UIButton = {
        let con = UIButton()
        
        con.setTitle("Login", for: .normal)
        con.addTarget(self, action: #selector(logginTapped), for: .touchUpInside)
        con.setTitleColor(.white, for: .normal)
        con.layer.cornerRadius = 25
        con.backgroundColor = .blue
        return con
        

    } ()
    
    @objc func logginTapped()
    {
        let stdcnt = studArray.count
        
        if(username.text == "Admin" && password.text == "admin")
        {
            print("Clicked...")
            let vc = AdminVC()
            navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            for i in 0..<stdcnt
            {
                if (username.text! == studArray[i].spid) && (password.text! == studArray[i].password)
                {
                    let vc = StudentVC()
                    
                    UserDefaults.standard.setValue(username.text, forKey: "spid")
                    UserDefaults.standard.setValue(studArray[i].name, forKey: "name")
                    UserDefaults.standard.setValue(studArray[i].clas, forKey: "clas")
                    UserDefaults.standard.setValue(studArray[i].div, forKey: "div")
                    UserDefaults.standard.setValue(studArray[i].sem, forKey: "sem")
                    UserDefaults.standard.setValue(studArray[i].mobileno, forKey: "mobileno")
                    navigationController?.pushViewController(vc, animated: true)
                    break
                }
                else
                {
                    let alert = UIAlertController(title: "Please Enter Correct Credentials", message: "Incorrect Username Or Password", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Close", style: .cancel))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true) {
                            self.username.text = ""
                            self.password.text = ""
                            
                        }
                    }
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Student Admission"
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(login)
        
        studArray = SQLiteHandler.shared.fetch()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bgimg3")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        username.frame = CGRect(x: 30, y: 290, width: view.width - 60, height: 40)
        password.frame = CGRect(x: 30, y: username.bottom + 20, width: view.width - 60, height: 40)
        login.frame = CGRect(x: 30, y: password.bottom + 50, width: view.width - 60, height: 40)
        
    }
}
