//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var data: String?
    var index: Int?

    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var fontSize: Int = 17 {
        didSet {
            setup()
        }
    }

    @IBInspectable var enableByDefault: Bool = true {
        didSet {
            if enableByDefault {
                isEnabled = true
            }
            else {
                isEnabled = false
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.alpha = 1.0
            }
            else {
                self.alpha = 0.5
            }
        }
    }
    
    var buttonDropdownLable:UILabel!
    var dropdownImage:UIImageView!
    
    @IBInspectable var buttonText: String = "" {
        didSet {
            if dropdownTheme && (buttonDropdownLable != nil) {
                buttonDropdownLable!.text = ""
                buttonDropdownLable!.text = buttonText
            }
        }
    }
    
    @IBInspectable var buttonCustomImgName: String = ""
    
    var defaultVlaue = ""
    
    @IBInspectable var fontNameStyle: Int = 1 {
        didSet {
            setup()
        }
    }

    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        if let titleLb = self.titleLabel {
//            titleLb.font = UIFont.retunRequiredFont(fontName: fontName(rawValue: fontNameStyle)!)
            titleLb.font = titleLb.font.withSize(CGFloat(self.fontSize))
        }
        
        if let dropLabel = buttonDropdownLable {
//            dropLabel.font = UIFont.retunRequiredFont(fontName: fontName(rawValue: fontNameStyle)!)
            dropLabel.font = dropLabel.font.withSize(CGFloat(self.fontSize))
        }

//        if let text = titleLabel?.text {
//            if !text.isEmpty {
//                isEnabled = false
//            }
//        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        self.defaultVlaue = self.buttonText
        setup()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        setup()
    }
    
    func addSubviews() {
        dropdownImage = UIImageView()
        addSubview(dropdownImage)
        buttonDropdownLable = UILabel()
        addSubview(buttonDropdownLable)
    }
    
    func changeButtonText (text:String) {
        if dropdownTheme && (buttonDropdownLable != nil) {
            buttonDropdownLable.removeFromSuperview()
            buttonDropdownLable = nil
            self.buttonText = text
            self.layoutSubviews()
        }
    }
    
    func setDefaultValue () {
        changeButtonText(text: defaultVlaue)
    }
    
    @IBInspectable var dropdownTheme: Bool = false {
        didSet {
            if dropdownTheme {
                self.layer.cornerRadius = 16
                self.backgroundColor = UIColor.white
                /*buttonDropdownLable = UILabel.init(frame: CGRect.init(x: 36, y: 0, width: self.frame.size.width - 8 - 8 - 28, height: self.frame.size.height))
                buttonDropdownLable!.textColor = UIColor.greyishBrown
                buttonDropdownLable!.textAlignment = .right
                self.addSubview(buttonDropdownLable!)
                
                let img = UIImageView.init(frame: CGRect.init(x:8, y: 8, width:20, height: 20))
                img.image = #imageLiteral(resourceName: "dropdown")
                img.contentMode = .scaleAspectFit
                self.addSubview(img)*/
            } else {
                self.layer.cornerRadius = 0
                self.backgroundColor = UIColor.white
                
            }
        }
    }
    
    @IBInspectable var customTheme: Bool = false
    
   
    
    override func layoutSubviews() {
    super.layoutSubviews()
        #if !TARGET_INTERFACE_BUILDER
        if dropdownTheme {
            if buttonDropdownLable == nil || buttonDropdownLable.frame == CGRect.zero  {
                buttonDropdownLable = UILabel.init(frame: CGRect.init(x: 36, y: 0, width: self.frame.size.width - 36 - 16, height: self.frame.size.height))
                buttonDropdownLable.text = buttonText
                buttonDropdownLable!.textColor = UIColor.gray
                buttonDropdownLable!.textAlignment = .right
//                buttonDropdownLable!.fontSize = self.fontSize
//                buttonDropdownLable!.setup()
                self.addSubview(buttonDropdownLable!)
            }
            
            if dropdownImage.frame == CGRect.zero {
                dropdownImage = UIImageView.init(frame: CGRect.init(x:16, y: self.frame.size.height/2 - 5, width:10, height: 10))
                //            dropdownImage.center.y = self.center.y
                dropdownImage.image = #imageLiteral(resourceName: "dropdown")
                dropdownImage.contentMode = .scaleAspectFit
                self.addSubview(dropdownImage)
                defaultVlaue = buttonText
            }
            
        } else if customTheme {
            if buttonDropdownLable == nil || buttonDropdownLable.frame == CGRect.zero  {
                buttonDropdownLable = UILabel.init(frame: CGRect.init(x: 8, y: 0, width: self.frame.size.width - 24 - 16, height: self.frame.size.height))
                buttonDropdownLable.text = buttonText
//                buttonDropdownLable!.textColor = UIColor.oceanBlue
                buttonDropdownLable!.textAlignment = .right
//                buttonDropdownLable!.fontSize = 14
//                buttonDropdownLable!.setup()
                self.addSubview(buttonDropdownLable!)
            }
            
            if dropdownImage.frame == CGRect.zero {
                dropdownImage = UIImageView.init(frame: CGRect.init(x: self.frame.size.width - 24, y: self.frame.size.height/2 - 8, width:16, height: 16))
//                dropdownImage.center.y = self.center.y
//                dropdownImage.backgroundColor = UIColor.black
                dropdownImage.image = UIImage.init(named: buttonCustomImgName)
                dropdownImage.contentMode = .scaleAspectFit
                self.addSubview(dropdownImage)
                defaultVlaue = buttonText
            }
        }
        #endif
    }
    
}
