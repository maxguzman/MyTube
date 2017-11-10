import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: height + 16 + 68)
  }
}






