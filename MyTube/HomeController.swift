import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // just in case...
    // navigationController?.navigationBar.isTranslucent = false
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
    // titleLabel.backgroundColor = .orange
    titleLabel.text = "Home"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    navigationItem.titleView = titleLabel
   
    collectionView?.backgroundColor = .white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // height for aspect ratio 16/9 (video) considering left/right panning
    let height = (view.frame.width - 16 - 16) * 9 / 16
    // add fixed ammount of pixels considering views bellow (title/subtitle/padding)
    return CGSize(width: view.frame.width, height: height + 16 + 68)
  }
}

class VideoCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage.init(named: "joseph")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage.init(named: "jotaro")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "The Bangles - Walk Like an Egyptian"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.text = "TheBanglesVEVO * 31M views * 4 years ago"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = .lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  func setupViews() {
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
    addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
    addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
    
    // constraints for titleLabel and subtitleTextView
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    
    // constraints for subtitleTextView
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//extension UIView {
//  func addConstraintWithFormat(format: String, views: UIView...) {
//    var viewsDictionary = [String: UIView]()
//    
//    for (index, view) in views.enumerated() {
//      let key = "v\(index)"
//      view.translatesAutoresizingMaskIntoConstraints = false
//      viewsDictionary[key] = view
//    }
//    
//    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
//  }
//}




