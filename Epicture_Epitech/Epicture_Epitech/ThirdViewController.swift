//
//  ThirdViewController.swift
//  Epicture_Epitech
//
//  Created by sifdine on 05/11/2018.
//  Copyright © 2018 sifdine All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class ThirdViewController: UIViewController {
    
    var arrayImages: [UIImageView] = []
    var refHash: [Int: String] = [:]
    var refFav: [Int: Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
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
                                let hash = json["data"][count]["id"].string
                                self.sendImageUrlToImageView(id: id, y: y, width: width ?? 750, height: height ?? 750, title: title ?? "untitled", count: count, hash: hash ?? "vmlDWGV")
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
    
    func sendImageUrlToImageView(id: String, y: Int, width: Int, height: Int, title: String, count: Int, hash: String) {
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
                        
                        let textView1 = UILabel(frame: CGRect(x: 0.0, y: 200, width: 250.0, height: 100.0))
                        textView1.text = title
                        textView1.center = self.view.center
                        textView1.textAlignment = NSTextAlignment.justified
                        textView1.backgroundColor = UIColor(white: 1, alpha: 0)
                        textView1.center = CGPoint(x: Double(imageSize / 2), y: calc + 45)
                        textView1.textAlignment = NSTextAlignment.center;
                        textView1.textColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
                        textView1.font = UIFont(name:"Kefa", size: 16.0)
                        
                        let image = UIImage(data: imageData)
                        let imageView1 = UIImageView(image: image)
                        imageView1.tag = count + 100
                        imageView1.frame = CGRect(x: Double(0), y: Double(y), width: Double(imageSize), height: Double(imageSize))
                        
                        let back = UIImage(named: "star") as UIImage?

                        let button = UIButton(frame: CGRect(x: Double(300), y: Double(calc + 30), width: 30, height: 30))
                        button.setImage(back, for: .normal)

                        button.addTarget(self, action: #selector(self.favor), for: .touchUpInside)
                        button.tag = count + 1000
                        self.view.bringSubviewToFront(button)
                        self.view.sendSubviewToBack(imageView1)

                        self.view.addSubview(imageView1)
                        self.view.addSubview(textView1)
                        self.view.addSubview(button)
                        self.refHash[button.tag] = hash
                        self.refFav[button.tag] = false

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
    
    @IBAction func favor(sender: UIButton) {
        let back: UIImage
        if (self.refFav[sender.tag] == false) {
            back = (UIImage(named: "fullStar") as UIImage?)!
            self.refFav[sender.tag] = true
        } else {
            back = (UIImage(named: "star") as UIImage?)!
            self.refFav[sender.tag] = false
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)"
        ]
        print(self.refHash[sender.tag] ?? "Error")
        favoriteImage(headers: headers, hash: self.refHash[sender.tag] ?? "vmlDWGV")
        sender.setImage(back, for: .normal)
        EntryViewController.GlobalVariable.NewFavorite = true
    }
    
    func favoriteImage(headers: HTTPHeaders, hash: String) {
        let URL:String = "https://api.imgur.com/3/image/\(hash)/favorite"
//        Alamofire.request(URL, method: .get, headers: headers).responseJSON {_ in
//        }
        Alamofire.request(URL, method: .post, headers: headers).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let dataFromString = utf8Text.data(using: .utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        print("Fmo")
                        print(json)
                        print("Flo")
                    } catch {
                        print(error)
                        return
                    }
                }
            }
        }
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
