//
//  FirstViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 05/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class FirstViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerDisplay()
        uploadButton.layer.cornerRadius = 30
    }
    
    
    @IBAction func btnClicked(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    func headerDisplay() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 75), cornerRadius: 0).cgPath
        layer.fillColor = UIColor(red:0.00, green:0.11, blue:0.15, alpha:1.0).cgColor
        view.layer.addSublayer(layer)
        
        let textView = UILabel(frame: CGRect(x: 0.0, y: 0, width: 250.0, height: 100.0))
        textView.text = "Epicture"
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.backgroundColor = UIColor(white: 1, alpha: 0)
        textView.center = CGPoint(x: self.view.frame.size.width / 2, y: 50)
        textView.textAlignment = NSTextAlignment.center;
        textView.textColor = UIColor(red:0.96, green:0.80, blue:0.54, alpha:1.0)
        textView.font = UIFont(name:"Kefa", size: 26.0)
        self.view.addSubview(textView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
            sendImage(image: image)
        }
        else {
            print("Can't Load...")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendImage(image: UIImage) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)",
//            "Authorization": "Client-ID aa5fbf8a617ba88"
        ]
        let urlReq = "https://api.imgur.com/3/image"
        let parameters = ["Authorization": "Client-ID aa5fbf8a617ba88"]//you can comment this if not needed
        
        let imgData = image.jpegData(compressionQuality:)
        
//        let headers = ["Content-Type":"multipart/form-data", "Accept":"application/json"]
        let url = try! URLRequest(url: urlReq, method: .post, headers: headers)
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image", mimeType: "image/jpeg")
        }, with: url) {  result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    EntryViewController.GlobalVariable.NewUpload = true
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }

}


