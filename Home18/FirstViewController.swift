
import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var musicArray:[Music] = [Music]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        title = "Main music list"
        
    }
    
    @IBAction func addNewMusicBarButtonDidClick(_ sender: UIBarButtonItem) {
        
        if let secondViewController = SecondViewController.viewControllerWithStoryboard() {
            navigationController?.pushViewController(secondViewController, animated: true)
            secondViewController.delegate = self
            
        }
    }
    
    @IBAction func editMusicListBarButtonDidClick(_ sender: UIBarButtonItem) {
        var isEditing = tableView.isEditing
        isEditing.toggle()
        
        tableView.setEditing(isEditing, animated: true)
        
        if isEditing {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
    }
}


extension FirstViewController: UITableViewDataSource,UITableViewDelegate,SecondViewControllerDelegate {
    
    func music(music: Music) {
        musicArray.append(music)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = musicArray[indexPath.row]
        let identifier = String(describing: SongTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! SongTableViewCell
        cell.set(music: element)
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let index = musicArray[indexPath.row]
        if let thirdViewController = ThirdViewController.viewControllerWithStoryboard() {
            present(thirdViewController, animated: true)
            thirdViewController.fullSongInfo.text! = "Song name:\(index.nameSong) \n Artist:\(index.artistName) \n Style: \(index.style)"
    }
    }

    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        musicArray.remove(at: indexPath.row)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let changeMusicPosition = musicArray[sourceIndexPath.row]
        musicArray.remove(at: sourceIndexPath.row)
        musicArray.insert(changeMusicPosition, at: destinationIndexPath.row)
    }
}


