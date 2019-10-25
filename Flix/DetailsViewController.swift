
import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {

    var movie: [String: Any]!

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as! String
        synopsisLabel.text = movie["overview"] as! String
    
        let baseURLPoster = "https://image.tmdb.org/t/p/w185"
        let posterURL = movie["poster_path"] as! String
        let fullPosterURL = URL(string: baseURLPoster + posterURL)
       
        posterView.af_setImage(withURL: fullPosterURL!)
        
        let baseURLBackDrop = "https://image.tmdb.org/t/p/w780"
        let backDropURL = movie["backdrop_path"] as! String
        let fullBackDropURL = URL(string: baseURLBackDrop + backDropURL)
        backdropView.af_setImage(withURL: fullBackDropURL!)
        
      
       
        
    }
    

   

}
