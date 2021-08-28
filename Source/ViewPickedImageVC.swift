//
//  ViewPickedImageVC.swift
//  CaptureSelfieBK
//
//  Created by mac on 22/08/2021.
//

import UIKit

class ViewPickedImageVC: UIViewController {
  
    weak var capDelegate : CaptureOutputPhotoDelegate?
//    weak var dismissDelegate : DismissAcrossAnotherDelegate?
    var takenPhoto : UIImage?
    var errorTakedPhoto : Error?
    let bigBtnWidth : CGFloat = 120.0
    let bigBtnHeight : CGFloat = 40.0
    
    private var pickImage : UIImageView = {
        let pick = UIImageView()
        pick.contentMode = .scaleAspectFit
        return pick//btn
    }()

    private let setBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemBackground
        btn.setTitle("Set", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    private let retakeBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .systemBackground
        btn.setTitle("Retake", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
 
    
    override func viewDidLoad() {
            super.viewDidLoad()
        pickImage.frame = CGRect(x: 0, y: 20, width: view.frame.width , height: view.frame.height - 50)
        setBtn.frame = CGRect(x: (view.frame.width - (bigBtnWidth + 40)), y: (view.frame.height - (bigBtnHeight + 50)), width: bigBtnWidth, height: bigBtnHeight)
        retakeBtn.frame = CGRect(x: 40, y: (view.frame.height - (bigBtnHeight + 50)), width: bigBtnWidth, height: bigBtnHeight)
      //  closeBtn.frame = CGRect(x: 20, y: 25, width: 40, height: 40)

        //closeBtn.layer.cornerRadius = closeBtn.frame.height / 2
        //closeBtn.clipsToBounds = true
        
        view.addSubview(pickImage)
        view.addSubview(setBtn)
        view.addSubview(retakeBtn)
     //   view.addSubview(closeBtn)

        if let availableImage = takenPhoto {
            pickImage.image = availableImage
        }
        view.backgroundColor = .systemBackground
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setBtn.addTarget(self, action: #selector(setImageAct), for: .touchUpInside)
        retakeBtn.addTarget(self, action: #selector(retakeCancelAction), for: .touchUpInside)
     //   closeBtn.addTarget(self, action: #selector(retakeCancelAction), for: .touchUpInside)
    }
    
   
    @objc private func setImageAct()  {
        capDelegate?.didFinishCaptureProcess(photo:  takenPhoto, error: errorTakedPhoto)
        
        dismiss(animated: true)
      //  dismissDelegate?.dismissAcrossOtherControllers()

    }
    
    @objc private func retakeCancelAction(){
      //  dismiss(animated: true)
        if (self.navigationController != nil){
               self.navigationController?.popViewController(animated: true)
           }else {
               dismiss(animated: true, completion: nil)
           }
    }

}

