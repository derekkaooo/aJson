//
//  ViewController.swift
//  aJson
//
//  Created by Derek on 2018/8/26.
//  Copyright © 2018年 Derek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var json:JSON = JSON.null
    var urlSession = URLSession(configuration: .default)
    @IBOutlet weak var myTableView: UITableView!
    var pokamon = [[String:Any]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokamon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        var dict = pokamon[indexPath.row]
        //解析資料用cell裡的元件秀出
        cell.nameLbl.text = dict["name"] as? String
        cell.typesLbl.text = (dict["types"] as? [String])?.first as? String
        cell.hpLbl.text = dict["hp"] as? String
        cell.subtypeLbl.text = dict["subtype"] as? String
        //解析image
        if let image = URL(string: dict["imageUrl"] as! String){
            let task = urlSession.downloadTask(with: image) { (url, repsponse, error) in
                if error != nil{
                    print("sorry")
                    return
                }
                if let okURL = url{
                    do{
                        let downloadImage = UIImage(data: try Data(contentsOf: okURL))
                        DispatchQueue.main.async {
                            cell.myImage.image = downloadImage
                        }
                    }catch{
                        print("error")
                    }
                }
            }
            task.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 224
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //Alamofire程式碼，搭配responseJSON解析
        Alamofire.request("https://api.pokemontcg.io/v1/cards").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                let json:JSON = try! JSON(data: response.data!)
                let swiftyJsonVar = JSON(response.result.value!)
                if let resData = swiftyJsonVar["cards"].arrayObject{
                    self.pokamon = resData as! [[String:AnyObject]]
                }
                if self.pokamon.count > 0{
                    self.myTableView.reloadData()
                }
            } else {
                print("error: \(response.error)")
            }
        })
    }
}
