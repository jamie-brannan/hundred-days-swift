import UIKit

class Singer {
    /// default value is Taylor Swift
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

/// change copy
var singerCopy = singer
singerCopy.name = "Justin Bieber"

/// prints as Jbeebs
print(singer.name)



struct SingerStruct {
  var name = "TSwift"
}

var singerStruct = SingerStruct()
print(singerStruct.name)

var singerStructCopy = singerStruct
singerStructCopy.name = "Jbeebs"

/// reprint the original
print(singerStruct.name)
print(singerStructCopy.name)
