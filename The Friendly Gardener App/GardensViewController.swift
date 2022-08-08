import UIKit
import CoreData

class GardensViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            var gardens = try self.context.fetch(Garden.fetchRequest())
            print(gardens.first?.title)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        let garden = Garden(context: self.context)
        garden.title = "Backyard"
        garden.area = 10
    
        do {
            try self.context.save()
        }
        catch {
            print("Error when saving item")
        }
    }
}
