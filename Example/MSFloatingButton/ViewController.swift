//
//  ViewController.swift
//  MSFloatingButton1
//
//  Created by Manoj Shrestha on 7/12/17.
//  Copyright © 2017 Manoj Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var btnAdd: UIButton!
    //let transition = PopAnimator()

    
    let btnDictionary = [["title":"GIF","icon":"icoGif","backgroundColor":UIColor(red: 246.0/255.0, green: 219.0/255.0, blue: 74.0/255.0, alpha: 1.0)],
                         ["title":"Link","icon":"icoLink","backgroundColor":UIColor(red: 90.0/255.0, green: 187.0/255.0, blue: 139.0/255.0, alpha: 1.0)],
                         ["title":"Chat","icon":"icoChat","backgroundColor":UIColor(red: 85.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)],
                         ["title":"Audio","icon":"icoAudio","backgroundColor":UIColor(red: 166.0/255.0, green: 127.0/255.0, blue: 192.0/255.0, alpha: 1.0)],
                         ["title":"Video","icon":"icoVideo","backgroundColor":UIColor(red: 155.0/255.0, green: 163.0/255.0, blue: 174.0/255.0, alpha: 1.0)],
                         ["title":"Text","icon":"icoText","backgroundColor":UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)],
                         ["title":"Photo","icon":"icoPhoto","backgroundColor":UIColor(red: 215.0/255.0, green: 95.0/255.0, blue: 69.0/255.0, alpha: 1.0)]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAdd.layer.cornerRadius = self.btnAdd.frame.height/2
        let bgColor = UIColor(red: 240.0/255.0, green: 152.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        self.btnAdd.backgroundColor = bgColor
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClicked(_ sender: UIButton)
    {
        let floatingCollectionVC = FloatingButtonCollectionViewController()
        floatingCollectionVC.backgroundColor = self.btnAdd.backgroundColor!//bgColor
        floatingCollectionVC.transitionDuration = 0.2
        for i in 0...(btnDictionary.count - 1) {
            let fbtn = MSFloatingBtnWithLabel()
            fbtn.floatingButtonColor = btnDictionary[i]["backgroundColor"] as! UIColor
            fbtn.titleColor = UIColor.black
            fbtn.title = btnDictionary[i]["title"] as! String
            fbtn.titleColor = UIColor.white
            fbtn.handler = {fbtn in print("clicked \(fbtn.title)")}
            fbtn.icon = UIImage(named: btnDictionary[i]["icon"] as! String)
            floatingCollectionVC.addFloatingButton(fbtn)
        }

        floatingCollectionVC.transitionButton = self.btnAdd
        present(floatingCollectionVC, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }}




