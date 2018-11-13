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
    
    @IBAction func btnClicked(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
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
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadButton.layer.cornerRadius = 15
        uploadButton.layer.borderWidth = 1.5
        uploadButton.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 0.0).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

}


