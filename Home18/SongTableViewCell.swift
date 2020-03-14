
import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    
    
   func set(music: Music) {
    songNameLabel.text = music.nameSong
   }
}
