//
//  EntryViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 05/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
import AuthenticationServices

//import Alamofire

class EntryViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var webAuthSession: ASWebAuthenticationSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 1.0).cgColor
        
    }

    @IBAction func connexionClick(_ sender: Any) {
    
        getAuthTokenWithWebLogin()
        
    }
    
    @available(iOS 12.0, *)
    func getAuthTokenWithWebLogin() {
        
        let authURL = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=4e1d3ef250c0041&response_type=token&state=APPLICATION_STATE")
        let callbackUrlScheme = "myepictureappepitech://"
        
        self.webAuthSession = ASWebAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in
            
            guard error == nil, let successURL = callBack else {
                return
            }
            
//            let oauthToken = NSURLComponents(string: (successURL.absoluteString))
//            print(("Alors:" + successURL.absoluteString) ?? "putin");
//            print(oauthToken ?? "ZEUBI ")
//            let test1 = self.getQueryStringParameter(url: successURL.absoluteString, param: "access_token");
//            print(test1 ?? "Error my men");
        
            if let match = (successURL.absoluteString).range(of: "(?<=access_token=)[^&]+", options: .regularExpression) {
                print((successURL.absoluteString).substring(with: match))
            }
        })
        
        // Kick it off
        self.webAuthSession?.start()
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    

}



//        if let url = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=4e1d3ef250c0041&response_type=token&state=APPLICATION_STATE") {
//            UIApplication.shared.open(url, options: [:])
//

//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//            let TabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
//
//            self.present(TabBarViewController, animated:true, completion:nil)
//        }

//        let MY_URL:String = "https://api.imgur.com/3/upload"
//        let CLIENT_ID:String = "4e1d3ef250c0041"
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
