import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var concepts: [String] = ["Big O Notation", "Biology Taxonomy", "Element Mass"]
    var conceptCodes: [String] = ["BigONotation","BiologyTaxonomy","ElementMass"]
    var conceptCode = ""
    var codePass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.concepts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.concepts[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        conceptCode = conceptCodes[indexPath.row]
        self.performSegueWithIdentifier("chooseToProb", sender: conceptCode)
    }

    //segueway stuff
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "chooseToProb") {
            var order: OrderVC = segue.destinationViewController
                as! OrderVC
            var codePass = conceptCode
            order.conceptCode = codePass
        }
    }
}

