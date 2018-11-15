//
//  GalleryViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 15/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let GALLERY_URL:String = "https://api.imgur.com/3/gallery/hot/viral/0/week?showViral=true&mature=true&album_previews=true"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)"
        ]
        
        imagesDisplay(MY_URL: GALLERY_URL, headers: headers)
        
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
                            if let id = json["data"][count]["images"][0]["link"].string {
//                                let height = json["data"][count]["height"].int
//                                let width = json["data"][count]["width"].int
                                let title = json["data"][count]["title"].string
                                self.sendImageUrlToImageView(id: id, y: y, width: 750, height: 750, title: title ?? "Unknow Title...", count: count)
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
                        let textView = UILabel(frame: CGRect(x: 0.0, y: calc, width: 250.0, height: 100.0))
                        textView.text = title
                        textView.center = self.view.center
                        textView.textAlignment = NSTextAlignment.justified
                        textView.backgroundColor = UIColor(white: 1, alpha: 0)
                        textView.center = CGPoint(x: 200, y: calc + 20)
                        
                        let image = UIImage(data: imageData)
                        let imageView1 = UIImageView(image: image)
                        imageView1.tag = count + 100
                        //                        self.adjustImageSize(imageView1: imageView1, y: y, width: 200, height: 200)
                        imageView1.frame = CGRect(x: Double(0), y: Double(y), width: Double(imageSize), height: Double(imageSize))
                        //                        self.arrayImages.append(imageView1)
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
    

}
