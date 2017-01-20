//
//  KeyboardViewController.swift
//  SmartSyncExplorerKeyboard
//
//  Created by Joe Andolina on 1/17/17.
//  Copyright © 2017 salesforce.com. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the sdk
        let _ = KeyboardModel.sharedInstance
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

//    func initSDK(_ completionBlock: ((Void) -> Void)? = nil )  {
//        
//        let cfg = SmartSyncExplorerConfig.sharedInstance()
//        SFSDKDatasharingHelper.sharedInstance().appGroupName = cfg?.appGroupName
//        SFSDKDatasharingHelper.sharedInstance().appGroupEnabled = true
//        
//        guard
//            let config = SmartSyncExplorerConfig.sharedInstance() else {
//            return
//        }
//        
//        if( self.validUser ) {
//            print("----------> User has logged in")
//            SalesforceSDKManager.setInstanceClass(SalesforceSDKManagerWithSmartStore.self)
//            
//            SalesforceSDKManager.shared().connectedAppId = config.remoteAccessConsumerKey
//            SalesforceSDKManager.shared().connectedAppCallbackUri = config.oauthRedirectURI
//            SalesforceSDKManager.shared().authScopes = config.oauthScopes as! [String]?
//            SalesforceSDKManager.shared().authenticateAtLaunch = config.appGroupsEnabled
//            
//            let currentUser = SFUserAccountManager.sharedInstance().userAccount(forUserIdentity:SFUserAccountManager.sharedInstance().activeUserIdentity!)
//            SFUserAccountManager.sharedInstance().currentUser = currentUser;
//            
//            if( currentUser != nil) {
//                if ( self.dataMgr == nil ) {
//                    self.dataMgr = SObjectDataManager.init(dataSpec:ContactSObjectData.dataSpec())
//                }
//                ///self.dataMgr?.lastModifiedRecords(3, completion: completionBlock)
//            }
//        }
//        else {
//            print("----------> User not logged in")
//        }
//    }
}
