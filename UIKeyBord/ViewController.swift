//
//  ViewController.swift
//  UIKeyBord
//
//  Created by Phan Thi Ngoc Cam on 5/5/17.
//  Copyright © 2017 ngoccam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        
        view.addGestureRecognizer(dismiss)
        
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow:")), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillHide:")), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        // 1
        let userInfo: [NSObject : AnyObject] = sender.userInfo! as [NSObject : AnyObject]
        // 2
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        
        let offset: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        
        // 3
        if keyboardSize.height == offset.height {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
               self.view.frame.origin.y -= keyboardSize.height
            })
       } else {
           UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let _: [NSObject : AnyObject] = sender.userInfo! as [NSObject : AnyObject]
        
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue.size
        
        self.view.frame.origin.y += keyboardSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

}

