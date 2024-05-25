# LoremIpsum-Swift
LoremIpsum String generator for Swift

## Instalation

### Swift Package Manager
Add the following package to your dependecies: `https://github.com/owlcoding/LoremIpsum-Swift/`

## How does it work? 
The main API is exposed as static method on `String` extension:

    import LoremImpsum
    let lorem2Paragraphs = String.Lorem(generate: .paragraph(num: 2, startsWithFirstSentence: true))
    let lorem3sentences = String.Lorem(generate: .sentence(num: 3, startsWithFirstSentence: true))
    let lorem5words = String.Lorem(generate: .word(num: 5))

    
### UIKit Extensions
Some UIKit classes implement `Loremable` protocol, so it's possible to call a `UILabel().lorem()` or `lorem(UILabel())`  to automagically fill them with randomness. `UILabel`, `UITextField`, `UITextView` and `UIButton` (even it doesn't make sense with it) are currently supported. 
