//
//  App_Constant.swift
//  TaskOfUnikwork
//
//  Created by Bhavin J kansara on 6/12/21.
//

import Foundation
import SystemConfiguration


typealias typeAliasDictionary = [String: AnyObject]



func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

func setObjectToUserDefaults(objValue: [typeAliasDictionary], ForKey: String) {
    UserDefaults.standard.setValue(objValue, forKey: ForKey)
    UserDefaults.standard.synchronize()
}

func getObjectFromUserDefaults(_ ForKey: String) -> [typeAliasDictionary] {
    return UserDefaults.standard.object(forKey: ForKey) as! [typeAliasDictionary]
}
struct Settings {
    static let shared = Settings()
    var username: String?

    private init() { }
}
