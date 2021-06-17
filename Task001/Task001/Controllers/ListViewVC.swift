//
//  ListViewVC.swift
//  Task001
//
//  Created by Bhavin J kansara on 6/16/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewVC: UIViewController {

    @IBOutlet weak var tableViewBG: UITableView!
    
    var arrOfList = [JSON]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params : NSDictionary = [
            "user_id"  : "16212"
        ]

        self.webservice_Get_List(url: "http://54.177.187.71/dev/QuantumGenius/API_V8/Quanta_purchase/get_member_playlist", params: params, header: [:])
    }



}
extension ListViewVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrOfList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ListViewCell()
        
        if let c = tableView.dequeueReusableCell(withIdentifier: "ListViewCell") as? ListViewCell {
            cell = c
        }
        else {
            cell = Bundle.main.loadNibNamed("ListViewCell", owner: self, options: nil)![0] as! ListViewCell
        }
        let dict = self.arrOfList[indexPath.row]
        let df = DateFormatter.init()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = Date()
        date = df.date(from: dict["created_at"].stringValue)!
        df.dateFormat = "EEEE MMM dd,yyyy"
        cell.lblDate.text = df.string(from: date)
        cell.lblName.text = dict["name"].stringValue
        cell.lblEmail.text = dict["email"].stringValue
        cell.lblTrial.text = "\(dict["trial_period_left"].stringValue) days remaining"
        return cell
    }
    
}
extension ListViewVC {
    func webservice_Get_List(url : String,params : NSDictionary,header:[String:String])
    {
        WebService().CallGlobalAPI(url: url, headers: header, parameters: params, HttpMethod: "POST", ProgressView: true, uiView : self.view, NetworkAlert: true) {( _ jsonResponse:JSON? , _ strErrorMessage:String) in
            
           
            print(jsonResponse?.dictionary)
            if strErrorMessage.count != 0 {
                print("SERVER_ERROR")
            }
            else {
                let responseCode = jsonResponse!["success"].stringValue
                let responseText = jsonResponse!["message"].stringValue
                
                if responseCode == "true" {
                    self.arrOfList = jsonResponse!["data"].arrayValue
                    self.tableViewBG.reloadData()
                }
                else if responseCode == "false" {
                   print("Status = 0")
                }
               
                
            }
        }
    }
}
