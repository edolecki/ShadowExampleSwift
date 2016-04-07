# ShadowExampleSwift
A Swift 2.2 example of various drop shadow techniques that's all the rage with young whipper-snappers.

![alt text](http://ericd.net/github_images/Shadows/shadow1.png "Screen 1")
![alt text](http://ericd.net/github_images/Shadows/shadow2.png "Screen 2")
![alt text](http://ericd.net/github_images/Shadows/shadow3.png "Screen 3")
![alt text](http://ericd.net/github_images/Shadows/shadow4.png "Screen 4")

The only real thing that makes this a Swift 2.2 implementation is the "upgraded" selector for the .ValueChanged for the UIScrollView. Otherwise it's fairly standard Swift. 

```swift
pageControl.addtarget(self, action: #selector(changePage(_:)), forControlEvents: .ValueChanged)
```

I saw something very similar to this a while ago, and this is an improvement on what I saw (in presentation). If I can remember or find the site where someone had this linked to their Github project, I'll add that to the readme.
