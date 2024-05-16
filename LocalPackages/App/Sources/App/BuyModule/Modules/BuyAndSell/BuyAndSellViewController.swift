import UIKit
import TKUIKit

class BuyAndSellViewController: GenericViewViewController<BuyAndSellView>, KeyboardObserving {
    
  // MARK: - Init

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Insert segmented control here"
  }
}
