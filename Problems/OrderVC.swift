import UIKit
import SwiftyJSON
import Alamofire
import Toast

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var conceptCode:String?
    var answerCheck: [String] = []
    
    @IBOutlet weak var questionLbl: UILabel!
    var tableData: [String] = []
    
    @IBAction func checkBtn(sender: AnyObject) {
        if (tableData == answerCheck) {
            self.view.makeToast("Correct")
            displayQuestion(conceptCode!)
        }
        else {
            self.view.makeToast("Incorrect")
        }
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        var params = ["concept": conceptCode]
        
        displayQuestion(conceptCode!)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = tableData[fromIndexPath.row]
        tableData.removeAtIndex(fromIndexPath.row)
        tableData.insert(itemToMove, atIndex: toIndexPath.row)
        
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func displayQuestion(contestCode: String) {
        Alamofire.request(.GET, "http://52.24.226.232/khanGetProb?concept="+conceptCode!)
            .responseString { _, _, string, _ in
                if let dataFromString = string!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    var choicesJson = json["choices"]
                    var choices: [String] = []
                    for (k,v) in choicesJson {
                        choices.append(v.stringValue)
                        
                    }
                    
                    var answerJson = json["answer"]
                    var answer: [String] = []
                    for (k,v) in answerJson {
                        answer.append(v.stringValue)
                    }
                    
                    self.questionLbl.text = json["question"].stringValue
                    
                    self.tableData = choices
                    self.answerCheck = answer
                    self.tableView.reloadData()
                }
        }
    }
}
