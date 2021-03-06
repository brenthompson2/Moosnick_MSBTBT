//
//  MArtifactViewController
//  ViewMaster
//
//  Created by Robert England on 3/11/18.
//  Copyright (c) 2018 Robert England. All rights reserved.
//
//  Abstract: Controller that manages the full size tile view of the packet,
//     including creating the reflection and flipping the tile.
//

import UIKit

@objc(MArtifactViewController)
class MArtifactViewController: UIViewController {
    
    // idea of making a delegate for the scroll view:
    // https://stackoverflow.com/questions/2448983/get-the-current-uiscrollview-scroll-values-on-the-iphone
    // Additional help from:
    // https://developer.apple.com/documentation/uikit/uiscrollviewdelegate
    private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
        let scrollLabel: UILabel
        
        // Sets the scroll label that this delegate will fade as the scroll view goes down
        init(_ scrollLabel: UILabel) {
            self.scrollLabel = scrollLabel
        }
        
        // Set the amount of transparency the label has to be the percent scrolled * 16
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            scrollLabel.alpha = 1 - ((scrollView.contentOffset.y / scrollView.contentSize.height) * 16)
        }
    }
    
    // Make a new delegate for the scroll view, with a dummy label
    private var delegate = ScrollViewDelegate(UILabel())
    
    var myArtifact: MArtifact?
    
    private let reflectionFraction: CGFloat = 0.35
    private let reflectionOpacity: CGFloat = 0.5
    
    private var packetView: MArtifactView!
    private var reflectionView: UIImageView!
    
    // MARK:  -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        // Get a reference to the scroll view
        let scrollView = self.view.viewWithTag(1) as! UIScrollView
        
        // Handy tip about content size:
        // https://stackoverflow.com/questions/4272854/uiscrollview-wont-scroll
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 2000)
        
        // Set the image to be in the top half of the screen space
        let viewRect = CGRect(x: 0, y: 0,
                              width: self.view.bounds.width,
                              height: self.view.bounds.height / 2)
        
        // create the packet view
        packetView = scrollView.viewWithTag(2) as! MArtifactView
        packetView.frame = viewRect
        
        // add the packet View to the view controller's interface
        // tell the packet view who its controller is
        self.packetView.image = UIImage(named: (myArtifact?.imagePath)!)
        scrollView.addSubview(self.packetView)
        
        self.packetView.viewController = self
        
        // create the reflection view
        var reflectionRect = viewRect
        
        // the reflection view is a fraction of the size of the original view being reflected,
        //    and is offset to be at the bottom of the view being reflected
        reflectionRect.size.height = reflectionRect.height * reflectionFraction
        reflectionRect = reflectionRect.offsetBy(dx: 0, dy: viewRect.height)
        
        let tempReflectionImageView = UIImageView(frame: reflectionRect)
        self.reflectionView = tempReflectionImageView
        
        // determine the size of the reflection to create
        let reflectionHeight = Int(self.packetView.bounds.height * reflectionFraction)
        
        // create the reflection image, assign it to the UIImageView and add the image view to the view controller's view
        self.reflectionView.image = self.packetView.reflectedImageRepresentationWithHeight(reflectionHeight)
        self.reflectionView.alpha = reflectionOpacity
        
        scrollView.addSubview(self.reflectionView)
        
        // Make the name label
        let nameRect = CGRect(x: 0,
                              y: self.view.bounds.height - 300,
                              width: self.view.bounds.width,
                              height: 200)
        
        let nameLabel = UILabel(frame: nameRect)
        
        nameLabel.text = myArtifact?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 45)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        nameLabel.numberOfLines = 3
        
        scrollView.addSubview(nameLabel)
        
        // Make the description label
        let descriptionRect = CGRect(x: 100,
                              y: self.view.bounds.height - 500,
                              width: self.view.bounds.width - 200,
                              height: 1000)
        
        let descriptionLabel = UILabel(frame: descriptionRect)
        
        descriptionLabel.numberOfLines = 100
        descriptionLabel.text = myArtifact?.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 30)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = NSTextAlignment.center
        descriptionLabel.sizeToFit()
        descriptionLabel.center = CGPoint(x: self.view.bounds.width / 2,
                                          y: self.view.bounds.height + descriptionLabel.frame.height / 2)
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width,
                                        height: self.view.bounds.height + descriptionLabel.frame.height + 200)
        
        scrollView.addSubview(descriptionLabel)
        
        // Make the "scroll to see more" label
        let scrollRect = CGRect(x: 0,
                              y: self.view.bounds.height - 100,
                              width: self.view.bounds.width,
                              height: 100)
        
        let scrollLabel = UILabel(frame: scrollRect)
        
        scrollLabel.text = "Scroll for more information"
        scrollLabel.font = UIFont.systemFont(ofSize: 20)
        scrollLabel.textColor = UIColor.white
        scrollLabel.textAlignment = NSTextAlignment.center
        
        // Make a new delegate, this time with the real scroll label
        delegate = ScrollViewDelegate(scrollLabel)
        scrollView.delegate = delegate
        
        self.view.addSubview(scrollLabel)
    }
}
