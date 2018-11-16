//
//  ViewController.swift
//  Epicture
//
//  Created by Flo on 30/10/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
//import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var button: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 1.0).cgColor
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ConnexionClick(_ sender: Any) {
        if let url = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=0d5157377ac285c&response_type=token&state=APPLICATION_STATE") {
            UIApplication.shared.open(url, options: [:])


            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            let TabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController

            self.present(TabBarViewController, animated:true, completion:nil)
        }
        
//        let MY_URL:String = "https://api.imgur.com/3/upload"
//        let CLIENT_ID:String = "0d5157377ac285c"
//        let CLIENT_SECRET:String = "69c0ee46b39409ea981e74a71b01817628a598b3"
//        let parameters: Parameters = [
//            "client_id": CLIENT_ID,
//            "client_secret": CLIENT_SECRET,
//            "Bearer": "",
//        ]
//        let headers = ["Authorization": "Client-ID \("0d5157377ac285c")"]
        
        
//        Alamofire.request(MY_URL, method: .get, parameters: parameters).responseJSON { response in
//                        if let json = response.result.value {
//                            print("JSON: \(type(of: json))") // serialized json response
//                        }
//                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                            print("Data: \(utf8Text)") // original server data as UTF8 string
//                            print(type(of: data))
//                        }
//        }
    }
}
