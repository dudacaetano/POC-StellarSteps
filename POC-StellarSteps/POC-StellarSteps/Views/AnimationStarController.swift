import UIKit
import SwiftUI

struct AnimationStarRepresentable: UIViewControllerRepresentable {
    
    var imagePrefix: String
    var total: Int
    
    func makeUIViewController(context: Context) -> AnimationStarController {
        let storyboard = UIStoryboard(name: "Storyboard_Step7", bundle: .main)
        let controller = storyboard.instantiateInitialViewController{coder in AnimationStarController(imagePrefix: imagePrefix, total: total, coder: coder)
        }
        guard let animationController = controller as? AnimationStarController else {
            fatalError("Could not cast controller to Animation_star")
        }
        
        return animationController
    }
    
    func updateUIViewController(_ uiViewController: AnimationStarController, context: Context) {
        
    }
    
}

class AnimationStarController: UIViewController {
    
    @IBOutlet weak var star: UIImageView!
    
    var starImages: [UIImage] = []
    
    var imagePrefix: String
    var total: Int
    
    
    init?(imagePrefix: String, total:Int, coder: NSCoder){
        self.imagePrefix = imagePrefix
        self.total = total
        super.init(coder: coder)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starImages = createImageArray(imagePrefix: imagePrefix, total: total)
        animate(imageView: star, images: starImages)
    }
    
    func createImageArray(imagePrefix: String, total: Int) -> [UIImage] {
        var imageArray: [UIImage] = []
        
        for imagesCount in 0..<total {
            let imageName = "\(imagePrefix)\(imagesCount+1)"
            let image = UIImage(named: imageName)!
            imageArray.append(image)
        }
        return imageArray
    }
    
    func animate(imageView: UIImageView, images: [UIImage]){
        imageView.animationImages = images
        imageView.animationDuration = 4.0
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + imageView.animationDuration) {
//            
//            imageView.image =  images.last //Define a ultima image após a animacao
//        }
       

    }

}


#Preview("Smile") {
    UIStoryboard(name: "Storyboard_Step7", bundle: .main).instantiateInitialViewController() { coder in AnimationStarController(imagePrefix: "smile", total: 5, coder: coder)
    }!
}


#Preview("Step") {
    UIStoryboard(name: "Storyboard_Step7", bundle: .main).instantiateInitialViewController() { coder in AnimationStarController(imagePrefix: "step", total: 5, coder: coder)
    }!
}




