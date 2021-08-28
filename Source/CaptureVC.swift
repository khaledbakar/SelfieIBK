//
//  CaptureVC.swift
//  CaptureSelfieBK
//
//  Created by mac on 22/08/2021.
//

import UIKit
import  AVFoundation

public class CaptureVC: UIViewController {//, DismissAcrossAnotherDelegate {
   
//    func dismissAcrossOtherControllers() {
//        dismiss(animated: true, completion: nil)
//    }
    
    var captureSession : AVCaptureSession?
    let outputPhoto  = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    public weak var cDelegate : CaptureOutputPhotoDelegate?

    private let shutterBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        btn.layer.cornerRadius = btn.frame.height / 2
        btn.layer.borderWidth = 10
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()

    public override func viewDidLoad() {
           super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterBtn)
        checkCameraPermissions()
        shutterBtn.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    
        navigationController?.navigationBar.tintColor = .label
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissCloseAction)), animated: true)

       }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 80)
    }
    
    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .notDetermined:
            //Requst accsess permissions
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard  let self = self else {return}
                guard granted else {return}
                DispatchQueue.main.async {
                    self.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
        
    }
    
    private func setupCamera (){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front){
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(outputPhoto){
                    session.addOutput(outputPhoto)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
           
                session.startRunning()
                self.captureSession = session
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapTakePhoto(){
        outputPhoto.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    @objc private func dismissCloseAction(){
        dismiss(animated: true)
    }
}

extension CaptureVC : AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
     
        guard let data = photo.fileDataRepresentation() else {return}
        //output image
        let imageOutput = UIImage(data: data)
        captureSession?.stopRunning()
       // let imageView = UIImageView(image: imageOutput)
        //imageView.contentMode = .scaleAspectFill
       // imageView.frame = view.bounds
     //   view.addSubview(imageView)

        let ph = ViewPickedImageVC()
        ph.takenPhoto = imageOutput
        ph.errorTakedPhoto = error
        ph.modalPresentationStyle = .fullScreen
        ph.capDelegate = cDelegate
//      ph.dismissDelegate = self
        navigationController?.pushViewController(ph, animated: true)

        DispatchQueue.main.async { [weak self] () in
            guard let self = self else {return}
           //to capture again after cancel
            self.captureSession?.startRunning()

        }


     }
}
