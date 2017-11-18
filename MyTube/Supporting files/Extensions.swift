import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
}

extension UIView {
  func addConstraintWithFormat(format: String, views: UIView...) {
    var viewsDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
  }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
  
  var imageUrlString: String?
  
  func loadImageUsing(urlString: String) {
    
    imageUrlString = urlString
    
    guard let url = URL(string: urlString) else { return }
    
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
      self.image = (imageFromCache as! UIImage)
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      
      if error != nil {
        print(error!)
        return
      }
      
      if let data = data {
        DispatchQueue.main.async {
          
          let imageToCache = UIImage(data: data)
          
          if self.imageUrlString == urlString {
            self.image = imageToCache
          }
          
          imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
          
        }
      }
      
    }).resume()
  }
  
}

