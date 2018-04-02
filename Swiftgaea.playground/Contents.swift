//: ## **Welcome to Swiftgaea!**
//: **Hey there!** I'm Sergen Gönenç, a 15-year-old iOS developer and designer; and this is my playground Swiftgaea, which is going to take you 252 million years back in time to show you the formation of the modern world. **Please wait for the playground to fully load, and then, enjoy!**

//: The later comments will get a little technical, explaining how each block of code works, step by step. On a technical note, you may also realize that this was only done by the power of UIKit, and there is not a single button in the entire project.

//: First, let's add the frameworks we will use in our code.
import UIKit
import PlaygroundSupport
//: Then, let's set up the container view that our UIViews will reside in.
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 500))
containerView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
containerView.layer.cornerRadius = 50
//: These are the transformations for the continents to be pushed and rotated.
let indiaTransform = CGAffineTransform(translationX: -54, y: 71).concatenating(CGAffineTransform(rotationAngle: -CGFloat.pi/10))
let eurasiaTransform = CGAffineTransform(translationX: 0, y: -15).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/12))
let australiaTransform = CGAffineTransform(translationX: -190, y: -185).concatenating(CGAffineTransform(rotationAngle: -5*CGFloat.pi/4))
let northAmericaTransform = CGAffineTransform(translationX: 119, y: 9)
let southAmericaTransform = CGAffineTransform(translationX: 50, y: -34).concatenating(CGAffineTransform(rotationAngle: -CGFloat.pi/6))
let africaTransform = CGAffineTransform(translationX: -3, y: -3)
//: This is to show the container view in the Assistant Editor to see our project the Live View.
PlaygroundPage.current.liveView = containerView
//: Let's create an array of UIImageViews, one for each continent
let continents = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
//: Here's our function to tint and assign images. These will later be called in the keyframes of our animation.
func colorImage(imgView: Int, imgName: String, color: UIColor){
    let templateImage: UIImage? = UIImage(named:imgName)?.withRenderingMode(.alwaysTemplate)
    continents[imgView].image = templateImage
    continents[imgView].tintColor = color
}
//: Let's color our images using the function that we just wrote.
let green = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
colorImage(imgView: 0, imgName: "Africa", color: green)
colorImage(imgView: 1, imgName: "Australia", color:green)
colorImage(imgView: 2, imgName: "NorthAmerica", color:green)
colorImage(imgView: 3, imgName: "SouthAmerica", color: green)
colorImage(imgView: 4, imgName: "Eurasia", color: green)
colorImage(imgView: 5, imgName: "India", color: green)
//: This creates the background blur effect for the slider.
let sliderEffect = UIBlurEffect(style: .dark)
let sliderEffectView = UIVisualEffectView(effect: sliderEffect)
sliderEffectView.frame = CGRect(x: 0, y: 0, width: 640, height: 70)
sliderEffectView.clipsToBounds = true
sliderEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
sliderEffectView.isUserInteractionEnabled = true
containerView.addSubview(sliderEffectView)
//: Here's a function to conveniently create and place our labels, which are the text you see on the screen.
func setupLabel(label: UILabel, x: Int, y: Int, w: Int, h: Int, text: String, color: UIColor = UIColor.white) {
    
    label.text = text
    label.frame = CGRect(x: x, y: y, width: w, height: h)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = color
    containerView.addSubview(label)
}
//: Setting our labels up by calling the function we created.
var todayLabel = UILabel()
setupLabel(label: todayLabel,
          x: 28, y: 30, w: 150, h: 40,
          text: " > slide to start")
var mYearsLabel = UILabel()
mYearsLabel.textAlignment = .right
setupLabel(label: mYearsLabel,
           x: 0, y: 0, w: 200, h: 40,
           text: "0 million years ago")
mYearsLabel.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    mYearsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
    mYearsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -26),
    ])
//: This is creating the main sliding view under the map, though at this point in the code, it does nothing.
let blurEffect = UIBlurEffect(style: .dark)
let blurEffectView = UIVisualEffectView(effect: blurEffect)
blurEffectView.frame = CGRect(x: 120, y: 450, width: 400, height: 300)
blurEffectView.clipsToBounds = true
blurEffectView.layer.cornerRadius = CGFloat(20.0)
blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
blurEffectView.isUserInteractionEnabled = true
//: This is a function to position and add the continents
continents.forEach({ continent in
    continent.bounds = CGRect(origin: .zero, size: CGSize(width: 640, height: 360))
    continent.center = containerView.center
    continent.alpha = 1.0
    containerView.addSubview(continent)
})

//: This adds the sliding view into our main screen view.
containerView.addSubview(blurEffectView)
//: In these lines, we are configuring and adding our labels to the sliding information view.
var eraLabel = UILabel()
eraLabel.text = "Today"
eraLabel.frame = CGRect(x: 21, y: 6, width: 300, height: 40)
eraLabel.adjustsFontSizeToFitWidth = false
eraLabel.textColor = UIColor.white
eraLabel.numberOfLines = 1
eraLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
eraLabel.textAlignment = .natural
eraLabel.font = UIFont.boldSystemFont(ofSize: 26)
blurEffectView.contentView.addSubview(eraLabel)

var infoLabel = UILabel()
infoLabel.text = "If you recognize these shapes, then it is because this is the world we are currently living in. However, as you can see, it is suffering from the immense pollution that humanity has created. If it continues like this, we may not even see one more million year!"
infoLabel.frame = CGRect(x: 21, y: 52, width: 350, height: 200)
infoLabel.adjustsFontSizeToFitWidth = true
// infoLabel.font = UIFont.systemFont(ofSize: 16)
infoLabel.textColor = UIColor.white
infoLabel.numberOfLines = 0
infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
infoLabel.textAlignment = .justified
infoLabel.sizeToFit()
blurEffectView.contentView.addSubview(infoLabel)

//: This creates an animator to animate the places of the continents.
let animator = UIViewPropertyAnimator(duration: 2, curve: .easeIn)
//: The actual animation occurs in three independent steps: one manipulating the positions, two changing the colors.
animator.addAnimations {
    
    UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.calculationModeLinear], animations: {
        
        //: Apply the transformations
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
            continents[0].transform = africaTransform
            continents[1].transform = australiaTransform
            continents[2].transform = northAmericaTransform
            continents[3].transform = southAmericaTransform
            continents[4].transform = eurasiaTransform
            continents[5].transform = indiaTransform
        }
        
        
        UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.2) {
            let desertColor = #colorLiteral(red: 0.5647058824, green: 0.5201646609, blue: 0.4221389627, alpha: 1)
            colorImage(imgView: 0, imgName: "Africa", color: desertColor)
            colorImage(imgView: 1, imgName: "Australia", color: desertColor)
            colorImage(imgView: 2, imgName: "NorthAmerica", color: desertColor)
            colorImage(imgView: 3, imgName: "SouthAmerica", color: desertColor)
            colorImage(imgView: 4, imgName: "Eurasia", color: desertColor)
            colorImage(imgView: 5, imgName: "India", color: desertColor)
            todayLabel.text = "Today"
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.04) {
            let green = UIColor.init(red: 0.39, green: 0.68, blue: 0.43, alpha: 1)
            colorImage(imgView: 0, imgName: "Africa", color: green)
            colorImage(imgView: 1, imgName: "Australia", color:green)
            colorImage(imgView: 2, imgName: "NorthAmerica", color:green)
            colorImage(imgView: 3, imgName: "SouthAmerica", color: green)
            colorImage(imgView: 4, imgName: "Eurasia", color: green)
            colorImage(imgView: 5, imgName: "India", color: green)
        }
        
    })
}
//: Here are some functions, to make that sweet springy slide-y animations happen.
func animateUp(springParams: UISpringTimingParameters) {
    let transform = CGAffineTransform(translationX: 0, y: -145)
    
    let blurViewAnimator = UIViewPropertyAnimator(duration: 1, timingParameters:springParams)
    
    blurViewAnimator.addAnimations ({
        blurEffectView.transform = transform
    }, delayFactor: 0)
    
    blurViewAnimator.startAnimation()

}

func animateDown(springParams: UISpringTimingParameters) {
    let reverseTransform = CGAffineTransform(translationX: 0, y: 0)
    let reverseAnimator = UIViewPropertyAnimator(duration: 1, timingParameters:springParams)
    reverseAnimator.addAnimations ({
        blurEffectView.transform = reverseTransform
    }, delayFactor: 0)
    reverseAnimator.startAnimation()
}
//: This creates the spring for the view to bounce.
let springParams = UISpringTimingParameters(dampingRatio: 0.5, initialVelocity: CGVector(dx: 0, dy: 10))
//: This code creates and places the little arrow that is on the side of the sliding view.
var arrowImage = UIImage(named: "DownArrow")
var arrowView  = UIImageView(image: arrowImage)
var arrowFrame = CGRect(x: 360, y: 15, width: 24, height: 24)
arrowView.frame = arrowFrame
arrowView.contentMode = .scaleToFill
blurEffectView.contentView.addSubview(arrowView)
arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//: This function rotates the arrow while the view is sliding.
func animateArrow(reverse: Bool) {
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    var transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    
    if reverse == false {
        transform = CGAffineTransform(rotationAngle: -2*CGFloat.pi)
    }
    
    animator.addAnimations {
        arrowView.transform = transform
    }
    
    animator.startAnimation()
}
//: To use all those functions, we need to "extend" what a view can do, and we do this right here.
var open = false
extension UIView {
    @objc func swipedUp() {
        animateUp(springParams: springParams)
        animateArrow(reverse: open)
        open = true
    }
    @objc func swipedDown() {
        animateDown(springParams: springParams)
        animateArrow(reverse: open)
        open = false
    }
    @objc func tapped(){
        if open == false {
            swipedUp()
        } else {
            swipedDown()
        }
    }

}
//: These nifty gesture recognizers recognize your swipes and taps, so that we can act on them.
let upRecognizer = UISwipeGestureRecognizer(target: blurEffectView.contentView, action: #selector(blurEffectView.contentView.swipedUp))
upRecognizer.direction = .up
blurEffectView.contentView.addGestureRecognizer(upRecognizer)

let downRecognizer = UISwipeGestureRecognizer(target: blurEffectView.contentView, action: #selector(blurEffectView.contentView.swipedDown))
downRecognizer.direction = .down
blurEffectView.contentView.addGestureRecognizer(downRecognizer)

let tapRecognizer = UITapGestureRecognizer(target: blurEffectView.contentView, action: #selector(blurEffectView.contentView.tapped))
blurEffectView.contentView.addGestureRecognizer(tapRecognizer)
//: This is the code for the slider to scrub the animation through an event listener, which notifies us whenever you slide the slider.
class ScrubReceiver: NSObject {
    
    var onValueChange: ((Float) -> ())?
    
    func performValueChangedHandler(slider: UISlider) {
        onValueChange?(slider.value)
    }
}
public class EventListener: NSObject {
    public var eventFired: (() -> ())?
    
    @objc public func handleEvent() {
        eventFired?()
    }
}
//: This function changes the information text based on the position of our slider.
func changeLabels(mya: Int) {
    
    mYearsLabel.text = "\(mya) million years ago"
    
    if mya >= 200 {
        eraLabel.text = "Triassic Period"
        infoLabel.text = "The Triassic Period is the first period of the Mesozoic Era, the period that sees the first dinosaurs and mammals emerge; and also, both the start and end of this period are marked by major extinction events, one of which exterminates almost all life."
    } else if 145...200 ~= mya {
        eraLabel.text = "Jurassic Period"
        infoLabel.text = "Does the name ring any bells? Well, that's because the Jurassic is the period in which dinosaurs evolve and become the dominant race of the land. This is also the period in which many creatures important today start to emerge, and Pangaea starts to split apart."
    } else if 66...144 ~= mya {
        eraLabel.text = "Cretaceous Period"
        infoLabel.text = "The Cretaceous mostly sees dinosaurs, plants and marine life thriving; and Pangaea separating into two supercontinents called Laurasia and Gondwana. However, it ends with one of the greatest mass extinctions, wiping out dinosaurs and almost all other life."
    } else if 1...65 ~= mya {
        eraLabel.text = "Cenozoic Era"
        infoLabel.text = "After dinosaurs go extinct, an new era for the world begins, and right now, we are still inside it. In this era, continents assume their modern geographic positions; and biological life evolves to form what we see today, with the first species of humanity taking shape."
    } else if mya == 0 {
        eraLabel.text = "Today"
        infoLabel.text = "If you recognize these shapes, then it is because this is the world we are currently living in. However, as you can see, it is suffering from the immense pollution that humanity has created. If it continues like this, we may not even see one more million year!"
    }
    
}

//: This whole almost 100-line block of code creates the sliding, swipable card that welcomes you when you first run the project, by doing similar things to what we did while creating the sliding bottom view.
let welcomeEffect = UIBlurEffect(style: .dark)
let welcomeEffectView = UIVisualEffectView(effect: welcomeEffect)
welcomeEffectView.frame = CGRect(x:-400, y:180, width: 400, height:200)
welcomeEffectView.clipsToBounds = true
welcomeEffectView.layer.cornerRadius = CGFloat(20.0)
welcomeEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
welcomeEffectView.isUserInteractionEnabled = true
containerView.addSubview(welcomeEffectView)

var welcomeLabel = UILabel()
welcomeLabel.text = "Welcome!"
welcomeLabel.frame = CGRect(x: 21, y: 9, width: 300, height: 40)
welcomeLabel.adjustsFontSizeToFitWidth = false
welcomeLabel.textColor = UIColor.white
welcomeLabel.numberOfLines = 1
welcomeLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
welcomeLabel.textAlignment = .natural
welcomeLabel.font = UIFont.boldSystemFont(ofSize: 26)
welcomeEffectView.contentView.addSubview(welcomeLabel)

var welcomeInfo = UILabel()
welcomeInfo.text = "Hello there! I am Sergen, your time machine operator. Today, you'll have the chance to see how the continents of the world today have formed, from the supercontinent Pangaea to today. Are you ready to go back in time? Just slide the slider above! (swipe to dismiss)"
welcomeInfo.frame = CGRect(x: 21, y: 55, width: 350, height: 200)
welcomeInfo.adjustsFontSizeToFitWidth = true
welcomeInfo.textColor = UIColor.white
welcomeInfo.numberOfLines = 0
welcomeInfo.lineBreakMode = NSLineBreakMode.byWordWrapping
welcomeInfo.textAlignment = .justified
welcomeInfo.sizeToFit()
welcomeEffectView.contentView.addSubview(welcomeInfo)

let welcomeSpring = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0, dy: 0))

func animateWelcome(rightDirection: Bool?) {
    
    var transform = CGAffineTransform(translationX: 520, y: 0)
    
    if rightDirection == true {
        transform = CGAffineTransform(translationX: 1200, y: 0)
    } else if rightDirection == false {
        transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    let welcomeViewAnimator = UIViewPropertyAnimator(duration: 1.5, timingParameters:welcomeSpring)
    
    welcomeViewAnimator.addAnimations ({
        welcomeEffectView.transform = transform
    }, delayFactor: 0)
    
    welcomeViewAnimator.startAnimation()
}

extension UIView {
    @objc func slideLeft(){
        animateWelcome(rightDirection: false)
    }
    @objc func slideRight(){
        animateWelcome(rightDirection: true)
    }
    @objc func welcomeTap(){
        animateWelcome(rightDirection: true)
    }
}

let rightRecognizer = UISwipeGestureRecognizer(target: welcomeEffectView.contentView, action: #selector(welcomeEffectView.contentView.slideRight))
rightRecognizer.direction = .right
welcomeEffectView.contentView.addGestureRecognizer(rightRecognizer)

let leftRecognizer = UISwipeGestureRecognizer(target: welcomeEffectView.contentView, action: #selector(welcomeEffectView.contentView.slideLeft))
leftRecognizer.direction = .left
welcomeEffectView.contentView.addGestureRecognizer(leftRecognizer)

let welcomeTap = UITapGestureRecognizer(target: welcomeEffectView.contentView, action: #selector(welcomeEffectView.contentView.welcomeTap))
welcomeEffectView.contentView.addGestureRecognizer(welcomeTap)

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
    animateWelcome(rightDirection: nil)
})
//: Then, we create and position our slider, and add our animator to our event listener.
let scrubber = UISlider(frame: CGRect(x: 25, y: 0, width: containerView.frame.width-50, height: 50))
var dispatched = false
let eventListener = EventListener()
eventListener.eventFired = {
    animator.fractionComplete = CGFloat(scrubber.value)
    
    let mya = Int(scrubber.value*252)
    changeLabels(mya: mya)
    
    if dispatched == false {
        animateWelcome(rightDirection: true)
        dispatched = true
    }
}

scrubber.addTarget(eventListener, action: #selector(EventListener.handleEvent), for: .valueChanged)
//: This adds our slider to the main view.
containerView.addSubview(scrubber)
//: This code extends the functions of the slider, to make it tappable.
extension UISlider {
    @objc func sliderTap(recognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = recognizer.location(in: scrubber)
        
        let positionOfSlider: CGPoint = scrubber.frame.origin
        let widthOfSlider: CGFloat = scrubber.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(scrubber.maximumValue) / widthOfSlider)
        
        scrubber.setValue(Float(newValue), animated: true)
        animator.fractionComplete = CGFloat(scrubber.value)
        changeLabels(mya: Int(scrubber.value*252))
    }
}

let sliderTapRecognizer = UITapGestureRecognizer(target: scrubber, action: #selector(scrubber.sliderTap(recognizer:)))
scrubber.addGestureRecognizer(sliderTapRecognizer)
//: Wow! If you are reading this, **thank you!** I am astonished by your patience. You now entirely know how this playground works, line by line.

//: **Hope to see you in WWDC18!**

//: **Credits:**
//: Images of World Map designed by Freepik




//: Made with <3 by Sergen Gönenç, for only 399.99 lines :)
