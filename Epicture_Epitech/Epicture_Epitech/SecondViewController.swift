//
//  SecondViewController.swift
//  Epicture_Epitech
//
//  Created by sifdine on 05/11/2018.
//  Copyright © 2018 sifdine All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class SecondViewController: UIViewController, UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    var refHash: [Int: String] = [:]
    var refFav: [Int: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerDisplay()
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        searchBar.tintColor = .white
        searchBar.setImage(UIImage(named: "Search"), for: UISearchBar.Icon.search, state: .normal)
        (UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]) ).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.96, green:0.80, blue:0.54, alpha:1.0)]



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

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)"
        ]
        searchBar.resignFirstResponder()
        let text: String = searchBar.text!
        let SEARCH_URL:String = "https://api.imgur.com/3/gallery/search/viral/all/0?q=\(text)"
        imagesDisplay(MY_URL: SEARCH_URL, headers: headers)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
                        print("UNOOOOO")
                        print(json)
                        print("DOOOOOS")
                        while (statut) {
                            if let id = json["data"][count]["images"][0]["link"].string {
//                                let height = json["data"][count]["height"].int
//                                let width = json["data"][count]["width"].int
                                let title = json["data"][count]["title"].string
                                let hash = json["data"][count]["images"][0]["id"].string
                                self.sendImageUrlToImageView(id: id, y: y, width: 750, height: 750, title: title ?? "Unknow Title...", count: count, hash: hash ?? "vmlDWGV")
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
                        let back = UIImage(named: "star") as UIImage?
                        
                        let button = UIButton(frame: CGRect(x: Double(300), y: Double(calc + 30), width: 30, height: 30))
                        button.setImage(back, for: .normal)
                        
                        button.addTarget(self, action: #selector(self.favor), for: .touchUpInside)
                        button.tag = count + 1000
                        self.view.bringSubviewToFront(button)
                        self.view.sendSubviewToBack(imageView1)
                        
                        self.view.addSubview(imageView1)
                        self.view.addSubview(textView)
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
    
}

