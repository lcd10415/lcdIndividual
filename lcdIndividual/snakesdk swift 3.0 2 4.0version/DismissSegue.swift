import UIKit

//http://jeffreysambells.com/2014/02/19/dismissing-a-modal-view-using-a-storyboard-segue
//http://stackoverflow.com/questions/35727353/assertion-failure-with-segues
class DismissModalSegue: UIStoryboardSegue {
    override func perform() {
        self.source.presentingViewController?.dismiss(animated: false, completion: {
            UIViewController.topMostViewController()!.view.isHidden = false
        })
    }
}
