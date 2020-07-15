# LoremIpsum-Swift
LoremIpsum String generator for Swift

## Instalation

### Swift Package Manager
Add the following package to your dependecies: `https://github.com/owlcoding/LoremIpsum-Swift/`

## How does it work? 
The main API is exposed as static method on `String` extension:

    import LoremImpsum
    let lorem = String.loremIpsum(paragraphs: 2)
    
### UIKit Extensions
Some UIKit classes implement `Loremable` protocol, so it's possible to call a `UILabel().lorem()` or `lorem(UILabel())`  to automagically fill them with randomness. `UILabel`, `UITextField`, `UITextView` and `UIButton` (even it doesn't make sense with it) are currently supported. 
