//
//  SelfiePresenter.swift
//  CaptureSelfieBK
//
//  Created by mac on 24/08/2021.
//

import Foundation
import UIKit

public protocol CaptureOutputPhotoDelegate : AnyObject {
    func didFinishCaptureProcess(photo:UIImage?,error:Error?)// or base 64 string to remove uikit 
}

/* // use in way thats depend on close button
  //don't use now causee depend on navigationcontroller
protocol DismissAcrossAnotherDelegate : AnyObject {
    func dismissAcrossOtherControllers() 
} */

