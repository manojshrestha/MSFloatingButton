//
//  FloatingButtonCollectionViewController.swift
//  MSFloatingButton1
//
//  Created by Manoj Shrestha on 7/12/17.
//  Copyright © 2017 Manoj Shrestha. All rights reserved.
//

import UIKit
import BubbleTransition

public class FloatingButtonCollectionViewController: UIViewController, MSFloatingBtnWithLabelDelegate {
    
    //MARK:- Properties
    fileprivate var floatingButtonCollection = [MSFloatingBtnWithLabel]()
    var floatingButtonsCollectionRadius: CGFloat = 100.0
    var floatingButtonRadius: CGFloat = 25.0
    let transition = BubbleTransition()

    public var backgroundColor : UIColor = UIColor.clear {
        didSet {
            self.view.backgroundColor = backgroundColor
            self.transition.bubbleColor = backgroundColor
        }
    }
    
    public var transitionDuration : Double = 0.5 {
        didSet {
            self.transition.duration = transitionDuration
        }
    }
    
    
    var transitionButton : UIButton!
    
    //MARK:- View Controller Delegate Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        showFloatingButtons()
        addCloseButton()
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidLayoutSubviews() {
        animateFloatingButtons(true) { (finish) in}
    }
    
    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        animateFloatingButtons(false) { (finished) in
            self.dismiss(animated: true) {
                //lol
            }
        }
    }
    
    
    //MARK:- Floating Button Methods
    fileprivate func showFloatingButtons()
    {
        let centerPoint = self.view.center
        var index = 0
        for btns in self.floatingButtonCollection
        {
            btns.center = centerPoint
            btns.floatingButtonRadius = floatingButtonRadius
            self.view.addSubview(btns)
            index = index + 1
        }
    }
    
    public func addFloatingButton(_ floatingButton: MSFloatingBtnWithLabel)
    {
        self.floatingButtonCollection.append(floatingButton)
    }
    
    public func addFloatingButtons(_ floatingButtons: [MSFloatingBtnWithLabel])
    {
        for btn in floatingButtons
        {
            self.floatingButtonCollection.append(btn)
        }
    }
    
    public func removeAllFloatingButton()
    {
        self.floatingButtonCollection.removeAll()
    }
    
    
    
    //MARK:- Animation Methods
    fileprivate func animateFloatingButtons(_ isOpening: Bool,completion: ((Bool) -> Void)?)
    {
        
        if(floatingButtonCollection.count == 0)
        {
            completion!(true)
            return
        }
        else if(floatingButtonCollection.count == 1)
        {
            let fb = floatingButtonCollection[0]
            fb.delegate = self
            completion!(true)
            return
        }
        
        let buttonCenters = getFloatingButtonCenters(self.floatingButtonCollection.count, radius: floatingButtonsCollectionRadius)
        
        if(isOpening)
        {
            for i in 0..<floatingButtonCollection.count
            {
                let fBtn = floatingButtonCollection[i] as MSFloatingBtnWithLabel
                fBtn.tag = i
                fBtn.alpha = 0
                fBtn.delegate = self
            }
            
            let firstBtn: MSFloatingBtnWithLabel = floatingButtonCollection[0]
            self.moveFloatingButton(firstBtn, toPoint: buttonCenters[0], completion: { (finished) in
                completion!(finished)
            })
        }
        else
        {
            //For closing
            let centerPoint = self.view.center
            let firstBtn: MSFloatingBtnWithLabel = floatingButtonCollection[0]
            self.moveFloatingButton(firstBtn, toPoint: centerPoint, completion: { (finished) in
                completion!(finished)
            })
        }
    }
    
    fileprivate func moveFloatingButton(_ floatingButton: MSFloatingBtnWithLabel, toPoint : CGPoint, completion: ((Bool) -> Void)?)
    {
        
        //Moves All floating button recursively
        let centerPoint = self.view.center
        let btnCount = floatingButtonCollection.count
        let buttonCenters = getFloatingButtonCenters(self.floatingButtonCollection.count, radius: floatingButtonsCollectionRadius)
        let nextIndex = floatingButton.tag + 1
        UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations:
            {
                floatingButton.center = toPoint
                //for closing
                if(centerPoint == toPoint)
                {
                    floatingButton.alpha = 0
                }
                else
                {
                    floatingButton.alpha = 1
                }
        })
        {finished in
            if(nextIndex < btnCount)
            {
                let nextBtn: MSFloatingBtnWithLabel = self.floatingButtonCollection[nextIndex]
                //for closing
                if(centerPoint == toPoint)
                {
                    self.moveFloatingButton(nextBtn, toPoint: centerPoint, completion: { (finished) in
                        completion!(finished)
                    })
                }
                else
                {
                    self.moveFloatingButton(nextBtn, toPoint: buttonCenters[nextIndex], completion: { (finished) in
                        completion!(finished)
                    })
                }
            }
            else
            {
                completion!(true)
            }
        }
    }
    
    
    fileprivate func getFloatingButtonCenters(_ buttonCount: Int, radius: CGFloat) -> [CGPoint]
    {
        var buttonsCenters = [CGPoint]()
        let centerPoint = self.view.center
        
        if(buttonCount == 1)
        {
            return [centerPoint]
        }
        
        for buttonIndex in 0..<buttonCount
        {
            
            let rAngle  = ((2 * CGFloat(Double.pi) ) / CGFloat(buttonCount))
            let bAngle : CGFloat = (CGFloat(buttonIndex)  * rAngle) - CGFloat(Double.pi)/2 //subtract part to rotate 90 deg
            let  newx = centerPoint.x + floatingButtonsCollectionRadius * cos(bAngle)
            let  newy = centerPoint.y + floatingButtonsCollectionRadius * sin(bAngle)
            
            let btnCenter = CGPoint(x: newx, y: newy)
            buttonsCenters.append(btnCenter)
        }
        return buttonsCenters
    }
    
    
    @objc func floatingButtonClicked() {
        animateFloatingButtons(false) { (finished) in
            self.dismiss(animated: true) {
                //lol
            }
        }
    }
    
    //MARK:- Close button
    fileprivate func addCloseButton()
    {
        let btnClose = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let img = UIImage(named: "icoClose")?.withRenderingMode(.alwaysTemplate)
        btnClose.setImage(img, for: UIControlState())
        btnClose.tintColor = UIColor.black
        btnClose.addTarget(self, action: #selector(self.floatingButtonClicked), for: .touchUpInside)
        self.view.addSubview(btnClose)
        
        let trailingConstraint = NSLayoutConstraint(item: btnClose, attribute:
            .trailingMargin, relatedBy: .equal, toItem: self.view,
                             attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: btnClose, attribute:
            .bottom, relatedBy: .equal, toItem: self.view,
                     attribute: NSLayoutAttribute.bottom, multiplier: 1.0,
                     constant: -8)
        
        btnClose.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingConstraint,bottomConstraint])
    }
}


extension FloatingButtonCollectionViewController: UIViewControllerTransitioningDelegate
{
    
    // MARK: UIViewControllerTransitioningDelegate
   public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = transitionButton.center
        //transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
   public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = transitionButton.center
        //transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
}
