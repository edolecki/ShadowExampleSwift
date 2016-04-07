//
//  ViewController.swift
//  ShadowExampleSwift
//
//  Created by Manish Kumar on 21/08/15.
//  Modified by Eric E. Dolecki on Thu April 7, 2016
//  Copyright (c) 2015 Innofied Solutions Pvt. Ltd. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate
{
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var flowers = ["flower.jpg", "flower2.jpg", "flower.3.jpg", "flower4.jpg", "flower5.jpg", "flower6.jpg", "flower7.jpg"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 75))
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.height - 75, width: self.view.frame.width, height: 75))
        pageControl.currentPage = 0
        pageControl.backgroundColor = UIColor.lightGrayColor()
        pageControl.numberOfPages = 7
        pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.addTarget(self, action: #selector(changePage(_:)), forControlEvents: .ValueChanged) //Swift 2.2 selector.
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        
        // Build the user interface.
        populateScrollView()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let page = Int(ceil(fractionalPage))
        pageControl.currentPage = page
    }
    
    func changePage( sender:UIPageControl ){
        let page = sender.currentPage
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func populateScrollView(){
        var positionX:CGFloat = self.view.center.x
        for i in 1...7 {
            let img = UIImageView(frame: CGRect(x: positionX, y: scrollView.frame.size.height / 2 - 100, width: 200, height: 200))
            img.tag = i
            img.center = CGPoint(x: positionX, y: img.center.y)
            img.contentMode = .ScaleAspectFit
            
            positionX = positionX + self.view.frame.size.width
            
            let myLabel = UILabel(frame: CGRect(x: 0, y: img.frame.origin.y + img.frame.height + 80, width: 200, height: 15))
            myLabel.textAlignment = .Center
            myLabel.center = CGPoint(x: img.center.x, y: myLabel.center.y)
            myLabel.textColor = UIColor.darkGrayColor()
            myLabel.font = UIFont.systemFontOfSize(14.0)
            
            scrollView.addSubview(img)
            scrollView.addSubview(myLabel)
            
            img.image = UIImage(named: flowers[i - 1])
            
            switch i {
                case 1:
                    createNormalShadowWithShadowOffset( img )
                    myLabel.text = "Normal Shadow"
                case 2:
                    createTrapezoidalShadowToImage( img )
                    myLabel.text = "Trapezoid Shadow"
                    img.image = UIImage(named: "flower2.jpg")
                case 3:
                    createOverallShadowToImage( img )
                    myLabel.text = "Overall Shadow"
                    img.image = UIImage(named: "flower3.jpg")
                case 4:
                    createEllepticalShadowBeneathImage( img )
                    myLabel.text = "Elliptical Shadow"
                case 5:
                    createRoundedCornerShadow( img )
                    myLabel.text = "Rounded Corner Shadow"
                case 6:
                    createCurlShadowForImageView( img )
                    myLabel.text = "Curled Shadow"
                case 7:
                    createAnimatedShadows( img )
                    myLabel.text = "Animated Shadow"
                default:
                    createNormalShadowWithShadowOffset( img )
                    myLabel.text = "Normal Shadow"
                    img.image = UIImage(named: "flower.jpg")
            }
        }
        scrollView.contentSize = CGSize(width: positionX - (self.view.frame.width / 2), height: scrollView.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createNormalShadowWithShadowOffset( img:UIImageView )
    {
        img.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.7).CGColor
        img.layer.shadowOffset = CGSizeMake(5.0, 5.0)
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 5.0
    }
    
    func createTrapezoidalShadowToImage( img:UIImageView )
    {
        let size = img.bounds.size
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(size.width * 0.17, size.height * 0.80))
        path.addLineToPoint(CGPointMake(size.width * 0.80, size.height * 0.80))
        path.addLineToPoint(CGPointMake(size.width * 1.20, size.height * 1.20))
        path.addLineToPoint(CGPointMake(size.width * -0.23, size.height * 1.20))
        path.closePath()
        img.layer.shadowColor = UIColor(white: 0.0, alpha: 0.6).CGColor
        img.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 6.0
        img.layer.shadowPath = path.CGPath
    }
    
    // No offset for the shadow.
    func createOverallShadowToImage( img:UIImageView )
    {
        img.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.9).CGColor
        img.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 12.0
    }

    func createEllepticalShadowBeneathImage( img:UIImageView )
    {
        
        // Create elliptical shdow forimage through UIBezierPath.
        let ovalRect = CGRectMake(0.0, img.frame.size.height + 10, img.frame.size.width, 15)
        let path = UIBezierPath(ovalInRect: ovalRect)
        
        // Applying shadow to path.
        img.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        img.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        img.layer.shadowOpacity = 0.8
        img.layer.shadowRadius = 4.0
        img.layer.shadowPath = path.CGPath
    }
    
    func createRoundedCornerShadow( img:UIImageView )
    {
        // Make the image view rounded.
        img.layer.cornerRadius = img.frame.size.width/2.0;
        img.layer.masksToBounds = true

        // Apply the rounded corner shadow to image.
        putShadowOnView(img, shadowColor: UIColor(white: 0.0, alpha: 0.5), radius: 10.0, offset: CGSizeMake(0.0, 0.0), opacity: 1.0)
    }

    
    func createCurlShadowForImageView( img:UIImageView){
        
        // Create a bezier path with curl effect.
        let size = img.frame.size
        let path = UIBezierPath()
        
        // Starting from left point.
        path.moveToPoint(CGPointMake(0.0, size.height))
        path.addLineToPoint(CGPointMake(0.0, size.height + 20.0))
        
        // The curved bottom part.
        path.addCurveToPoint(CGPointMake(size.width, size.height + 20.0), controlPoint1: CGPointMake(20.0, size.height), controlPoint2: CGPointMake(size.width - 20.0, size.height))

        // Closing the path by going upper top part.
        path.addLineToPoint(CGPointMake(size.width, size.height))
        
        // Close the path and apply the path as shadow.
        path.closePath()
        
        // Apply shadow to imageView using the created path.
        img.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
        img.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 3.0
        img.layer.shadowPath = path.CGPath
    }
    
    func createAnimatedShadows( img:UIImageView )
    {
        img.layer.shadowColor =  UIColor(white: 0.0, alpha: 0.3).CGColor
        img.layer.shadowOffset = CGSizeMake(20.0, -20.0)
        img.layer.shadowOpacity = 1.0
        img.layer.shadowRadius = 5.0
    
        // Apply the animation to shadow.
        let animation = CABasicAnimation(keyPath: "shadowOffset")
        animation.fromValue = NSValue(CGSize:CGSizeMake(-20.0, -20.0))
        animation.toValue = NSValue(CGSize: CGSizeMake(20.0, -20.0))
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        img.layer.addAnimation(animation, forKey: "shadowOffset")
    }

    //http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow#12969741
    
    func putShadowOnView(viewToWorkUpon:UIView, shadowColor:UIColor, radius:CGFloat, offset:CGSize, opacity:Float)-> UIView{
        
        var shadowFrame = CGRectZero // Modify this if needed
        shadowFrame.size.width = 0.0
        shadowFrame.size.height = 0.0
        shadowFrame.origin.x = 0.0
        shadowFrame.origin.y = 0.0
    
        let shadow = UIView(frame: shadowFrame)
        shadow.userInteractionEnabled = false
        shadow.layer.shadowColor = shadowColor.CGColor
        shadow.layer.shadowOffset = offset
        shadow.layer.shadowRadius = radius
        shadow.layer.masksToBounds = false
        shadow.clipsToBounds = false
        shadow.layer.shadowOpacity = opacity
        viewToWorkUpon.superview?.insertSubview(shadow, belowSubview: viewToWorkUpon)
        shadow.addSubview(viewToWorkUpon)
        return shadow
    }
}

