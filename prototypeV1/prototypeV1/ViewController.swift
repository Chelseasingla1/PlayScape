//
//  ViewController.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 29/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonoutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonAction(_ sender: Any) {
        let storwyboard = UIStoryboard(name: "create", bundle: nil)
        let textViwController = storwyboard.instantiateViewController(withIdentifier: "testViewController")
//        self.present(textViwController, animated: true)
        
        self.tabBarController?.present(textViwController, animated: true)
        
        
//        self.navigationController?.pushViewController(textViwController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

