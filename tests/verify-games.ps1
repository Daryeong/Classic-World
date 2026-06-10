$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$menu = Get-Content (Join-Path $root "index.html") -Raw

$games = @(
  @{ Path = "2048\index.html"; Link = "./2048/index.html"; Markers = @("2048", "move(", "Back to Menu") },
  @{ Path = "checkers\index.html"; Link = "./checkers/index.html"; Markers = @("Checkers", "legalMoves", "Back to Menu") },
  @{ Path = "maze-chase\index.html"; Link = "./maze-chase/index.html"; Markers = @("Maze Chase", "requestAnimationFrame", "Back to Menu") }
)

foreach ($game in $games) {
  $path = Join-Path $root $game.Path
  if (-not (Test-Path $path)) {
    throw "Missing game page: $($game.Path)"
  }

  $html = Get-Content $path -Raw
  foreach ($marker in $game.Markers) {
    if (-not $html.Contains($marker)) {
      throw "Missing marker '$marker' in $($game.Path)"
    }
  }

  if (-not $menu.Contains($game.Link)) {
    throw "Missing menu link: $($game.Link)"
  }
}

Write-Output "Verified 3 game pages and menu links."
