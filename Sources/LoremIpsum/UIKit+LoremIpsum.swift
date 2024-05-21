//MIT License
//
//Copyright (c) 2020
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

public protocol Loremable {
    func lorem()
}

#if !os(macOS)
import UIKit

extension UILabel: Loremable {
    public func lorem() {
        let paragraph = String.Lorem(generate: .paragraph(num: 1, startsWithFirstSentence: true))
        self.text = paragraph
        self.attributedText = NSAttributedString(string: paragraph)
    }
}

extension UITextField: Loremable {
    public func lorem() {
        self.text = String.Lorem(generate: .sentence(num: 1, startsWithFirstSentence: false))
    }
}

extension UITextView: Loremable {
    public func lorem() {
        self.text = String.Lorem(generate: .paragraph(num: 3, startsWithFirstSentence: true))
    }
}

extension UIButton: Loremable {
    public func lorem() {
        setTitle(String.Lorem(generate: .sentence(num: 1, startsWithFirstSentence: false)), for: .normal)
    }
}

public func lorem<T: Loremable>(_ uikitElement: T) {
    uikitElement.lorem()
}

#endif

