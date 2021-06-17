//
//  ServiceCollection.swift
//  Shelvinza
//
//  Created by Setblue on 10/11/16.
//  Copyright © 2016 Setblue. All rights reserved.
//

import Foundation
import SwiftyJSON

class ServiceCollection {

    static let sharedInstance = ServiceCollection()
    var resObj:Any!

    init() {}
 
    func getDataList(param : typeAliasDictionary,response : @escaping( _ data : typeAliasDictionary , _ rstatus : Int, _ message : String) -> Void ) {
        
        let url : String = "http://54.177.187.71/dev/QuantumGenius/API_V8/Quanta_purchase/get_member_playlist"
        ServiceManager.sharedInstance.postRequestHandler(url, parameters: param) { (data, error, message, rstatus ) in
            if error != nil {
                response(typeAliasDictionary(), 0, message!)
            }else{
                
                    guard let resDic : typeAliasDictionary = data as? typeAliasDictionary else {
                        response(typeAliasDictionary(), 0, "SOMETHING_WRONG")
                        return
                    }
                self.resObj = resDic
                
                response(self.resObj as! typeAliasDictionary , rstatus, message!)
                
            }
        }
    }
}
