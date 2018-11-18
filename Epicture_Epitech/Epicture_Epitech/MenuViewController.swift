//
//  MenuViewController.swift
//  Epicture_Epitech
//
//  Created by Flo on 17/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController {

    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
