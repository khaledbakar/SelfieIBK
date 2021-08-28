//
//  ViewController.swift
//  SelfieIBK
//
//  Created by khaled bakar on 08/27/2021.
//  Copyright (c) 2021 khaled bakar. All rights reserved.
//

import UIKit
import SelfieIBK

class ViewController: UIViewController , CaptureOutputPhotoDelegate {
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var takeSelfieBtn : UIButton!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeSelfieAction (_ sender : Any) {
       let cap = CaptureVC()
        cap.cDelegate = self
        let nav = UINavigationController(rootViewController: cap)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func didFinishCaptureProcess(photo: UIImage?, error: Error?) {
        guard  error == nil else {
            let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let photoImg = photo else {return}
        previewImg.image = photoImg
    }
    
}

