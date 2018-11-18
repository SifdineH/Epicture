//
//  EntryViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 05/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit
import AuthenticationServices

class EntryViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    var webAuthSession: ASWebAuthenticationSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.isUserInteractionEnabled = false
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 244/255.0, green: 203/255.0, blue: 137/255.0, alpha: 1.0).cgColor
        
    }

    @IBAction func connexionClick(_ sender: Any) {
    
        getAuthTokenWithWebLogin()
        
    }
    
    @available(iOS 12.0, *)
    func getAuthTokenWithWebLogin() {
        
        let authURL = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=aa5fbf8a617ba88&response_type=token&state=APPLICATION_STATE")
        let callbackUrlScheme = "myepictureappepitech://"
        
        self.webAuthSession = ASWebAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in
            
            guard error == nil, let successURL = callBack else {
                return
            }
        
            if let token = (successURL.absoluteString).range(of: "(?<=access_token=)[^&]+", options: .regularExpression) {
                GlobalVariable.AccessToken.append((successURL.absoluteString).substring(with: token))
                if let name = (successURL.absoluteString).range(of: "(?<=account_username=)[^&]+", options: .regularExpression) {
                    GlobalVariable.AccountUserName = ""
                    GlobalVariable.AccountUserName.append((successURL.absoluteString).substring(with: name))
                }
                GlobalVariable.NewFavorite = true
                GlobalVariable.NewUpload = true
                GlobalVariable.FilerWindow = "week"
                GlobalVariable.FilerSort = "viral"
                GlobalVariable.FilerSection = "hot"
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let TabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBarViewController
                self.present(TabBarViewController, animated:true, completion:nil)
                
            }
        })
        self.webAuthSession?.start()
    }
    
    struct GlobalVariable {
        static var AccessToken = String()
        static var AccountUserName = String()
        static var NewFavorite = Bool()
        static var NewUpload = Bool()
        static var FilerSection = String()
        static var FilerSort = String()
        static var FilerWindow = String()
    }
    

}

//            let oauthToken = NSURLComponents(string: (successURL.absoluteString))
//            print(("Alors:" + successURL.absoluteString) ?? "putin");
//            print(oauthToken ?? "ZEUBI ")
//            let test1 = self.getQueryStringParameter(url: successURL.absoluteString, param: "access_token");
//            print(test1 ?? "Error my men");



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
