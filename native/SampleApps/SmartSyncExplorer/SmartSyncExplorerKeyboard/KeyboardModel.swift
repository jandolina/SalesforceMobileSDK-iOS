//
//  KeyboardModel.swift
//  SmartSyncExplorer
//
//  Created by Joe Andolina on 1/19/17.
//  Copyright © 2017 salesforce.com. All rights reserved.
//

import UIKit

//-----------------------------------------------------------------------------------

class KeyboardModel: NSObject {

    //-----------------------------------------------------------------------------------

    var validUser : Bool {
        if let config = SmartSyncExplorerConfig.sharedInstance() {
            return UserDefaults.msdk().bool(forKey: config.userLogInStatusKey)
        }
        return false
    }

    //-----------------------------------------------------------------------------------

    static let sharedInstance = KeyboardModel()
    
    //-----------------------------------------------------------------------------------

    private override init() {
        super.init()
        self.initSDK()
    }

    //-----------------------------------------------------------------------------------
    
    func initSDK() {
        guard let config = SmartSyncExplorerConfig.sharedInstance() else {
            return
        }
        
        SFSDKDatasharingHelper.sharedInstance().appGroupName = config.appGroupName
        SFSDKDatasharingHelper.sharedInstance().appGroupEnabled = config.appGroupsEnabled
        SFKeychainItemWrapper.setAccessibleAttribute(kSecAttrAccessibleWhenUnlocked)
        
        if self.validUser {
            SalesforceSDKManager.setInstanceClass(SalesforceSDKManagerWithSmartStore.self)
            SalesforceSDKManager.shared().connectedAppId = config.remoteAccessConsumerKey
            SalesforceSDKManager.shared().connectedAppCallbackUri = config.oauthRedirectURI
            SalesforceSDKManager.shared().authScopes = config.oauthScopes as! [String]?
            SalesforceSDKManager.shared().authenticateAtLaunch = config.appGroupsEnabled
            
            let activeUserIdentity = SFUserAccountManager.sharedInstance().activeUserIdentity
            let currentUser = SFUserAccountManager.sharedInstance().userAccount(forUserIdentity:activeUserIdentity!)
            SFUserAccountManager.sharedInstance().currentUser = currentUser
        }
    }
    
    //-----------------------------------------------------------------------------------
    
    func modifiedRecords( count:NSInteger=3, completion:((_ : [Any]) -> Void )!) {
        guard SFUserAccountManager.sharedInstance().currentUser != nil else {
            return
        }
        
        let dataMgr = SObjectDataManager.init(dataSpec: ContactSObjectData.dataSpec())
        
        dataMgr?.lastModifiedRecords(Int32(count), completion: { () -> Void in
            if let data = dataMgr?.dataRows {
               completion(data)
            }
        })
    }
    
    //-----------------------------------------------------------------------------------
    
    func contactList(completion:((_ : [Any]) -> Void )!) {
        guard SFUserAccountManager.sharedInstance().currentUser != nil else {
            return
        }
        
        let dataMgr = SObjectDataManager.init(dataSpec: ContactSObjectData.dataSpec())
        
        dataMgr?.lastModifiedRecords(Int32(count), completion: { () -> Void in
            if let data = dataMgr?.dataRows {
                completion(data)
            }
        })
    }
}
