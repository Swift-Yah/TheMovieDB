//
//  SwiftMessagesGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/3/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import SwiftMessages

struct SwiftMessagesGateway: MessageGateway {
    func error(message: String) {
        showMessage(message: message, theme: .error)
    }
    
    func hide() {
        SwiftMessages.hide()
    }
    
    func hideAll() {
        SwiftMessages.hideAll()
    }
    
    func info(message: String) {
        showMessage(message: message, theme: .info)
    }
    
    func success(message: String) {
        showMessage(message: message, theme: .success)
    }
    
    func warning(message: String) {
        showMessage(message: message, theme: .warning)
    }
    
    // MARK: Private functions
    
    private func showMessage(message: String, theme: Theme) {
        let messageView = MessageView.viewFromNib(layout: .messageView)
        messageView.configureDropShadow()
        messageView.configureTheme(theme)
        messageView.configureContent(body: message)
        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        
        var configuration = SwiftMessages.defaultConfig
        configuration.dimMode = .blur(style: .dark, alpha: 0.75, interactive: true)
        configuration.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        
        SwiftMessages.show(config: configuration, view: messageView)
    }
}
