import UIKit

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func study(reviseNotes: (String) -> Void) {
  let notes = "Napoleon was a short, dead dude."
  for _ in 1...10 {
    reviseNotes(notes)
  }
}
study { (notes: String) in
  print("I'm reading my notes: \(notes)")
}

func runKidsParty(activities: ([String]) -> Void) {
  let kids = ["Bella", "India", "Phoebe"]
  activities(kids)
}
runKidsParty { (names: [String]) in
  for name in names {
    print("Here's your party bag, \(name).")
  }
}

func makeSale(signContract: (String) -> Void) {
  let clientName = "Apple"
  print("\(clientName) should buy our product.")
  print("You're interested? Great! Sign here.")
  signContract(clientName)
}
makeSale { (client: String) in
  print("We agree to pay you $100 million.")
  print("Signed, \(client)")
}
