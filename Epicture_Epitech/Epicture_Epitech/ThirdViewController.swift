//
//  ThirdViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 05/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class ThirdViewController: UIViewController {
    
    var arrayImages: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageStyle()
        viewWillAppear(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func nameDisplay() {
        let textViewName = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 250.0, height: 30.0))
        textViewName.text = EntryViewController.GlobalVariable.AccountUserName
        textViewName.center = self.view.center
        textViewName.textAlignment = NSTextAlignment.justified
        textViewName.backgroundColor = UIColor(white: 1, alpha: 0)
        textViewName.center = CGPoint(x: self.view.frame.size.width / 2, y: 170)
        textViewName.textColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        textViewName.font = UIFont(name:"Kefa", size: 20.0)
        textViewName.textAlignment = NSTextAlignment.center;

        self.view.addSubview(textViewName)
    }
    
    @IBAction func remove(_ sender: Any) {
       
//        if let foundView = self.view.viewWithTag(101) {
//            foundView.removeFromSuperview()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let AVATAR_URL:String = "https://api.imgur.com/3/account/\(EntryViewController.GlobalVariable.AccountUserName)/avatar"
        let IMAGES_URL:String = "https://api.imgur.com/3/account/\(EntryViewController.GlobalVariable.AccountUserName)/images"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)"
        ]
        
        if (EntryViewController.GlobalVariable.NewUpload) {
            view.subviews.forEach({ $0.removeFromSuperview() })
            headerDisplay()
            backProfilDisplay()
            avatarDisplay(MY_URL: AVATAR_URL, headers: headers)
            nameDisplay()
            imagesDisplay(MY_URL: IMAGES_URL, headers: headers)
            EntryViewController.GlobalVariable.NewUpload = false
        }
    }
    
    func backProfilDisplay() {
        let imageProfil = UIImage(named: "backProfil")

        let imageViewProfil = UIImageView(image: imageProfil)
        
        //                        self.adjustImageSize(imageView1: imageView1, y: y, width: 200, height: 200)
        imageViewProfil.frame = CGRect(x: 0, y: 75, width: self.view.frame.size.width, height: 150)
        self.view.addSubview(imageViewProfil)
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
    
    func manageStyle() {
//        button.layer.cornerRadius = 15
//        button.layer.borderWidth = 1.5
//        button.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 0.0).cgColor
//        labelName.text = nil
//        labelName.text = EntryViewController.GlobalVariable.AccountUserName
    }

    func imagesDisplay(MY_URL: String, headers: HTTPHeaders) {
        var count:Int = 0
        var statut:Bool = true
        var y:Int = 200

        Alamofire.request(MY_URL, method: .get, headers: headers).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let dataFromString = utf8Text.data(using: .utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        print("UNO")
                        print(json)
                        print("DOS")
                        while (statut) {
                            if let id = json["data"][count]["link"].string {
                                let height = json["data"][count]["height"].int
                                let width = json["data"][count]["width"].int
                                let title = json["data"][count]["title"].string
                                self.sendImageUrlToImageView(id: id, y: y, width: width ?? 750, height: height ?? 750, title: title ?? "Unknow Title...", count: count)
                                let size = self.view.frame.size.width
                                y = Int(y) + Int(size) + 200
                            } else {
                                statut = false
                            }
                            count = count + 1
                        }
                    } catch {
                        print(error)
                        return
                    }
                }
            }
        }
    }
    
    func sendImageUrlToImageView(id: String, y: Int, width: Int, height: Int, title: String, count: Int) {
        let URL_IMAGE = URL(string: id)
        let session = URLSession(configuration: .default)
        let imageSize = self.view.frame.size.width


        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            if let e = error  {
                print("Some error occured: \(e)")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let calc:Double = Double(imageSize) + Double(y)

                        let layerImage = CAShapeLayer()
                        layerImage.path = UIBezierPath(roundedRect: CGRect(x: 0.00, y: calc, width: Double(imageSize), height: Double(100)), cornerRadius: 1.00).cgPath
                        layerImage.fillColor = UIColor(red:0.00, green:0.11, blue:0.15, alpha:1.0).cgColor
                        self.view.layer.addSublayer(layerImage)
                        
                        let textView = UILabel(frame: CGRect(x: 0.0, y: calc, width: 250.0, height: 100.0))
                        textView.text = title
                        textView.center = self.view.center
                        textView.textAlignment = NSTextAlignment.justified
                        textView.backgroundColor = UIColor(white: 1, alpha: 0)
                        textView.center = CGPoint(x: Double(imageSize / 2), y: calc + 45)
                        textView.textAlignment = NSTextAlignment.center;
                        textView.textColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
                        textView.font = UIFont(name:"Kefa", size: 16.0)
                        
                        let image = UIImage(data: imageData)
                        let imageView1 = UIImageView(image: image)
                        imageView1.tag = count + 100
                        imageView1.frame = CGRect(x: Double(0), y: Double(y), width: Double(imageSize), height: Double(imageSize))
                        self.view.addSubview(imageView1)
                        self.view.addSubview(textView)

                    } else {
                        print("no image found")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
    }
    
    func avatarDisplay(MY_URL: String, headers: HTTPHeaders) {
        Alamofire.request(MY_URL, method: .get, headers: headers).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let dataFromString = utf8Text.data(using: .utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        if let id = json["data"]["avatar"].string {
                            self.sendAvatarUrlToImageView(id: id)
                        } else {
                            print("Error get avatar")
                            return
                        }
                    } catch {
                        print(error)
                        return
                    }
                }
            }
        }
    }
    
    func sendAvatarUrlToImageView(id: String) {
        let URL_IMAGE = URL(string: id)
        let session = URLSession(configuration: .default)
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            if let e = error  {
                print("Some error occured: \(e)")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let imageAvatar = UIImage(data: imageData)
                        let imageViewAvatar = UIImageView(image: imageAvatar)
                        imageViewAvatar.layer.cornerRadius = imageViewAvatar.frame.width/6.0
                        imageViewAvatar.clipsToBounds = true
                        imageViewAvatar.frame = CGRect(x: 0, y: 100, width: 50, height: 50)
                        imageViewAvatar.center = CGPoint(x: self.view.frame.size.width / 2, y: 130)
                        //self.arrayImages.append(imageView1)
                        self.view.addSubview(imageViewAvatar)
                    } else {
                        print("no image found")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        getImageFromUrl.resume()
    }
}
