 //
//  ServiceManager.swift
//  Shelvinza
//
//  Created by Setblue on 10/11/16.
//  Copyright © 2016 Setblue. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceManager {
    
    static let sharedInstance = ServiceManager()
    
    var resObjects:Any!
    
    init() {}
    
    
    //MARK:- POST REQUEST
    func
    postRequestHandler(_ endpointurl:String, parameters:typeAliasDictionary,responseData:@escaping (_ data: typeAliasDictionary, _ error: NSError?, _ message: String?, _ rstatus : Int ) -> Void) {
       
        Alamofire.request(endpointurl, method: .post , parameters: parameters)
            .responseJSON { response in
                
                
                if let _ = response.error {
                    responseData(typeAliasDictionary(),  response.error as NSError?, "Unable to connect to server, please check your internet connection or try switching your network", 0)
                }else {
                    switch response.result {
                    case .success(_):
                        
                        guard let responseJSON:typeAliasDictionary = (response.value as? typeAliasDictionary) else {
                            responseData(typeAliasDictionary(), nil, "SOMETHING_WRONG", 0)
                            return
                        }
                        self.resObjects  = responseJSON
                       
                        responseData(self.resObjects as! typeAliasDictionary, nil, "", Int())
                        
                    case .failure(let error):
                        responseData(typeAliasDictionary(), error as NSError, "SOMETHING_WRONG", 0)
                }
            }
        }
    }
}
