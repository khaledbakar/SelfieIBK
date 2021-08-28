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
        setupMainView()
       }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterBtn.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 80)
    }
    
    func setupMainView()  {
        view.backgroundColor = .systemBackground
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterBtn)
        checkCameraPermissions()
        shutterBtn.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    
        navigationController?.navigationBar.tintColor = .label
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissCloseAction)), animated: true)
    }
    
 
    @objc private func didTapTakePhoto(){
        outputPhoto.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    @objc private func dismissCloseAction(){
        dismiss(animated: true)
    }
   
}
//MARK:- photo processing
extension CaptureVC : AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
     
        guard let data = photo.fileDataRepresentation() else {return}
        //output image
        let imageOutput = UIImage(data: data)
        //check face detection
        let cImgProcess = CIImage(image: imageOutput ?? UIImage()) ?? CIImage()
        let accuracy = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces =  faceDetector?.features(in: cImgProcess, options: [CIDetectorSmile:true])
        guard !(faces?.isEmpty ?? false) else {
            let alert = UIAlertController(title: "No Face!", message: "Camera has detected no face try to pick photo again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        captureSession?.stopRunning()

        //navigation & delegation
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
//MARK:- setup camera
extension CaptureVC {
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
}
