//
//  AccountViewController.swift
//  Epicture
//
//  Created by Flo on 02/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPress(_ sender: Any) {
        
//        let url = URL(string: "https://api.imgur.com/3/account/{{flofli}}")
//                var request = URLRequest(url: url!)
//                request.setValue("Client-ID", forHTTPHeaderField: "0d5157377ac285c")
//
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    print("cc")
//        }
        let urlString = "https://api.imgur.com/oauth2/addclient"
        let session = URLSession.shared
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(url: url as URL)
        let parameters: Parameters = [
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "Authorization": "Bearer \(EntryViewController.GlobalVariable.AccessToken)"
        ]
        request.setValue("Client-ID", forHTTPHeaderField: "0d5157377ac285c")
        request.setValue("Client-Secret", forHTTPHeaderField: "69c0ee46b39409ea981e74a71b01817628a598b3")
        request.setValue("Bearer", forHTTPHeaderField: "146af9e6c0f7de3bae56c44ee7e12344c0f4f0fe")


        
        session.dataTask(with: request as URLRequest) {
            (data: Data?,response: URLResponse?, error: Error?) -> Void in
            
            if let responseData = data
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                }catch{
                    print("Could not serialize")
                }
            }
            
            }.resume()
    }
    }


