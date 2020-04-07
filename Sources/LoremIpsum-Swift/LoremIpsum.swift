//MIT License
//
//Copyright (c) 2019
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

import Foundation

public struct RandomNumberGeneratorContainer: RandomNumberGenerator {
    var rng: RandomNumberGenerator
    
    public init(rng: RandomNumberGenerator) {
        self.rng = rng
    }
    
    mutating public func next() -> UInt64 {
        return self.rng.next()
    }
}

extension Array {
    func last(number: Int) -> Array {
        var a = self
        let result = (0..<number).compactMap { _ in return a.popLast() }
        return result.reversed()
    }
    
    func first(number: Int) -> Array {
        return self
            .enumerated()
            .filter { idx, _ in return idx < number }
            .compactMap { return $0.element }
    }
}

extension String {
    public class LoremIpsum {
        
        public func word(using rng: inout RandomNumberGeneratorContainer) -> String {
            return LoremIpsum.words.randomElement(using: &rng) ?? LoremIpsum.words[0]
        }
        
        public func sentence(using rng: inout RandomNumberGeneratorContainer) -> String {
            let length = Int(randomNormalLikeDistributedNumber(mean: 8, std_dev: 4, using: &rng))
            var words: [String] = []
            stride(from: 1, to: length, by: 1).forEach { _ in
                var w = word(using: &rng)
                while words.last(number: 2).contains(w) {
                    w = word(using: &rng)
                }
                words.append(w)
            }
            return sentencify(arrayOfWords: commify(arrayOfWords: words, using: &rng))
        }
        
        public var veryFirstSentence: String {
            return sentencify(arrayOfWords: LoremIpsum.words.first(number: LoremIpsum.numberOfWordsInVeryFirstSentence))
        }
        
        public func paragraph(numberOfSentences: Int? = nil, using rng: inout RandomNumberGeneratorContainer) -> String {
            var length: Int
            if let l = numberOfSentences {
                length = l
            } else {
                length = Int(randomNormalLikeDistributedNumber(mean: 30, std_dev: 19, using: &rng))
            }
            
            if length <= 1 { length = 2 }
            return stride(from: 1, to: length, by: 1).map { _ in return sentence(using: &rng) }.joined(separator: " ")
            
        }
        
        public func generateParagraphsAsString(numberOfParagraphs: Int, includingVeryFirstSentence: Bool, using rng: inout RandomNumberGeneratorContainer) -> String {
            return generateParagraphs(numberOfParagraphs: numberOfParagraphs, includingVeryFirstSentence: includingVeryFirstSentence, using: &rng)
                .joined(separator: "\n\n")
        }
        
        public func generateParagraphs(numberOfParagraphs: Int, includingVeryFirstSentence: Bool, using rng: inout RandomNumberGeneratorContainer) -> [String] {
            guard numberOfParagraphs > 0 else { return [] }
            return stride(from: 1, through: numberOfParagraphs, by: 1).map { idx in
                var par = paragraph(using: &rng)
                if idx == 1 && includingVeryFirstSentence {
                    par = veryFirstSentence + " " + par
                }
                return par
            }
        }
        
        private func sentencify(arrayOfWords: [String]) -> String {
            guard let firstWord = arrayOfWords.first else { return "" }
            var array = arrayOfWords
            array[0] = firstWord.prefix(1).uppercased() + firstWord.dropFirst()
            
            return array.joined(separator: " ") + "."
        }
        
        private func commify(arrayOfWords: [String], using rng: inout RandomNumberGeneratorContainer) -> [String] {
            let sentenceLength = arrayOfWords.count
            var array = arrayOfWords
            if sentenceLength > 4 {
                let mean = log(Double(sentenceLength))
                let std_dev = mean / 6
                let commas = Int(randomNormalLikeDistributedNumber(mean: mean, std_dev: std_dev, using: &rng))
                stride(from: 1, to: commas, by: 1).forEach { idx in
                    let wrd = Int(idx * sentenceLength / (commas + 1))
                    if wrd < sentenceLength - 1 && wrd > 0 {
                        array[wrd] = array[wrd] + ","
                    }
                }
            }
            
            return array
        }
        
        private func randomNormalLikeDistributedNumber(mean: Double, std_dev: Double, using rng: inout RandomNumberGeneratorContainer) -> Double
        {
            let x = Double.random(in: ClosedRange(uncheckedBounds: (0, 1)), using: &rng)
            let y = Double.random(in: ClosedRange(uncheckedBounds: (0, 1)), using: &rng)
            let z = sqrt(-2 * log(x)) * cos(2 * Double.pi * y)
            return z * std_dev + mean
        }
        
        private static let numberOfWordsInVeryFirstSentence: Int = 8
        private static let words: [String] = [
            // Lorem ipsum...
            "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
            // and the rest of the vocabulary
            "a", "ac", "accumsan", "ad", "aenean", "aliquam", "aliquet", "ante",
            "aptent", "arcu", "at", "auctor", "augue", "bibendum", "blandit",
            "class", "commodo", "condimentum", "congue", "consequat", "conubia",
            "convallis", "cras", "cubilia", "curabitur", "curae", "cursus",
            "dapibus", "diam", "dictum", "dictumst", "dignissim", "dis", "donec",
            "dui", "duis", "efficitur", "egestas", "eget", "eleifend", "elementum",
            "enim", "erat", "eros", "est", "et", "etiam", "eu", "euismod", "ex",
            "facilisi", "facilisis", "fames", "faucibus", "felis", "fermentum",
            "feugiat", "finibus", "fringilla", "fusce", "gravida", "habitant",
            "habitasse", "hac", "hendrerit", "himenaeos", "iaculis", "id",
            "imperdiet", "in", "inceptos", "integer", "interdum", "justo",
            "lacinia", "lacus", "laoreet", "lectus", "leo", "libero", "ligula",
            "litora", "lobortis", "luctus", "maecenas", "magna", "magnis",
            "malesuada", "massa", "mattis", "mauris", "maximus", "metus", "mi",
            "molestie", "mollis", "montes", "morbi", "mus", "nam", "nascetur",
            "natoque", "nec", "neque", "netus", "nibh", "nisi", "nisl", "non",
            "nostra", "nulla", "nullam", "nunc", "odio", "orci", "ornare",
            "parturient", "pellentesque", "penatibus", "per", "pharetra",
            "phasellus", "placerat", "platea", "porta", "porttitor", "posuere",
            "potenti", "praesent", "pretium", "primis", "proin", "pulvinar",
            "purus", "quam", "quis", "quisque", "rhoncus", "ridiculus", "risus",
            "rutrum", "sagittis", "sapien", "scelerisque", "sed", "sem", "semper",
            "senectus", "sociosqu", "sodales", "sollicitudin", "suscipit",
            "suspendisse", "taciti", "tellus", "tempor", "tempus", "tincidunt",
            "torquent", "tortor", "tristique", "turpis", "ullamcorper", "ultrices",
            "ultricies", "urna", "ut", "varius", "vehicula", "vel", "velit",
            "venenatis", "vestibulum", "vitae", "vivamus", "viverra", "volutpat",
            "vulputate",
        ]
    }
    
    public static func loremIpsum(paragraphs: Int,
                                  using rng: inout RandomNumberGeneratorContainer
        ) -> String {
        return LoremIpsum().generateParagraphsAsString(numberOfParagraphs: paragraphs, includingVeryFirstSentence: true, using: &rng)
    }
    
    public static func loremIpsum(paragraphs: Int) -> String {
        var srng = RandomNumberGeneratorContainer(rng: SystemRandomNumberGenerator())
        return loremIpsum(paragraphs: paragraphs,
                          using: &srng)
    }
}
