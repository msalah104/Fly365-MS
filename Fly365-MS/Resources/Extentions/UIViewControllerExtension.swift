//
//  UIViewControllerExtension.swift
//  Tasawwaq
//
//  Created by Marwan on 8/25/18.
//

import UIKit
import MBProgressHUD
import SwiftMessages

protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {
    static var identifier: String {
        return "\(self)"
    }
}

protocol Instantiatable {
    static func instantiate(from storyboardIdentifier: UIStoryboard) -> Self
}

extension UIViewController: Instantiatable { }

extension Instantiatable where Self: UIViewController {
    static func instantiate(from storyboardIdentifier: UIStoryboard = .main) -> Self {
        
        guard let viewController = storyboardIdentifier.instantiateViewController(withIdentifier: self.identifier) as? Self else {
            return Self()
        }
        return viewController
    }
}

extension UIViewController {

    /**
    Show Alert
    - parameter title: Title for the alert
    - parameter text: Message for the alert
    - parameter completion: Completion block to be executed once finished.
    */
    func showAlert(title: String?, text: String?, completion: (() -> ())? = nil) {
        let message = text
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgress(on view: UIView? = nil, color: UIColor = .white) {
        
        let finalView = view ?? self.view
        let hud = MBProgressHUD.showAdded(to: (finalView)!, animated: true)
        hud.backgroundColor = color

    }
    
    func hideProgress(on view: UIView? = nil) {
        let view = view ?? self.view
        MBProgressHUD.hide(for: view!, animated: true)
    }
    
    func show(errorMessage: String, hideProgress: Bool = true) {
        if hideProgress {
            self.hideProgress()
        }
        showSwiftMesssages(message: errorMessage)
    }
    
    func showAlert(errorMessage: String, hideProgress: Bool = true) {
        if hideProgress {
            self.hideProgress()
        }
        AlertView().Default().setAlertTitle(title: "خطأ").setAlertContent(content: errorMessage).show(view: self)
    }
    
    func show(error: Error, hideProgress: Bool = true) {
        if hideProgress {
            self.hideProgress()
        }
        showSwiftMesssages(message: error.message)
    }
    
    private func showSwiftMesssages(message: String) {
        let messageview = MessageView.viewFromNib(layout: .cardView)
        // Theme message elements with the warning style.
        messageview.configureTheme(.error)
        
        // Add a drop shadow.
        messageview.configureDropShadow()
        
        messageview.button?.isHidden = true
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        messageview.configureContent(title: "", body: message, iconText: iconText)
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        //messageview.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        // (messageview.backgroundView)?.cornerRadius = 10
        
        // Show the message.
        SwiftMessages.show(view: messageview)
    }
    
}
