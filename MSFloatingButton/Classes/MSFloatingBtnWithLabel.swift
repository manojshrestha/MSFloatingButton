//
//  MSFloatingBtnWithLabel.swift
//  MSFloatingButton
//
//  Created by Manoj Shrestha on 7/12/17.
//  Copyright © 2017 Manoj Shrestha. All rights reserved.
//

import UIKit


protocol MSFloatingBtnWithLabelDelegate {
    init()
    func floatingButtonClicked()
}

@IBDesignable
public class MSFloatingBtnWithLabel: UIView {

    @IBOutlet weak var floatingButtonHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btnFloating: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate : MSFloatingBtnWithLabelDelegate?
    
    public var handler: ((MSFloatingBtnWithLabel) -> Void)? = nil
    
    @IBInspectable
    public var icon : UIImage!
        {
        didSet {
            setupValues()
        }
    }
    
    @IBInspectable
    public var floatingButtonRadius : CGFloat = 25.0
    {
        didSet {
            setupValues()
        }
    }
    
    @IBInspectable
    public var floatingButtonColor :UIColor = UIColor.blue
        {
        didSet {
              setupValues()
        }
    }

    
    @IBInspectable
    public var title :String = ""
    {
        didSet {
            setupValues()
        }
    }
    
    @IBInspectable
    public var titleColor :UIColor = UIColor.black
        {
        didSet {
              setupValues()
        }
    }
    
    public init() {
        let size = (floatingButtonRadius * 2) + 20
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: size))
        setup()
    }
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MSFloatingBtnWithLabel", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        
        self.btnFloating.layer.cornerRadius = self.floatingButtonRadius
        self.btnFloating.imageView?.contentMode = .center;
        self.btnFloating.imageView?.contentMode = .scaleAspectFit
        self.btnFloating.clipsToBounds = true
    }
    
    fileprivate func setupValues()
    {
        self.lblTitle.text = title
        self.lblTitle.textColor = titleColor
        
        self.floatingButtonHeightConstant.constant = floatingButtonRadius * 2
        self.btnFloating.backgroundColor = floatingButtonColor
        
        if(icon != nil)
        {
            self.btnFloating.setImage(icon, for: UIControlState())
            self.btnFloating.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        }
        
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton)
    {
        self.delegate?.floatingButtonClicked()
        handler?(self)
    }
 
    
}
