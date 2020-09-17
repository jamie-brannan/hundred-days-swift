# Day 23 (3)
:calendar: – Thursday September 17, 2020

:desert_island: been on vacation, and picking back up the challenge

## Picking back up

Added a condition so that there's stuff.

```swift
    /// view the table at cell row
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
    /// get file name
    let flagFileName = flags[indexPath.row]
    /// title the cell with the file name minus the end of the name
    let cellTitle = flagFileName.replacingOccurrences(of: "@2x.png", with: "")
    /// if the cell title has two letters, it's an acronym that needs to be capitalized
    if cellTitle.count == 2 {
        cell.textLabel?.text = cellTitle.uppercased()
    } else {
        cell.textLabel?.text = cellTitle.capitalizingFirstLetter()
    }
    return cell
  }
}
```
