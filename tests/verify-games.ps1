$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$menu = Get-Content (Join-Path $root "index.html") -Raw

$games = @(
  @{ Path = "2048\index.html"; Link = "./2048/index.html"; Description = "같은 숫자 타일을 합쳐 2048을 만드세요."; Markers = @("2048", "move(", "Back to Menu") },
  @{ Path = "checkers\index.html"; Link = "./checkers/index.html"; Description = "말을 대각선으로 움직여 상대 말을 모두 잡으세요."; Markers = @("Checkers", "legalMoves", "Back to Menu") },
  @{ Path = "maze-chase\index.html"; Link = "./maze-chase/index.html"; Description = "추격자를 피해 미로의 점을 모두 모으세요."; Markers = @("Maze Chase", "requestAnimationFrame", "Back to Menu") }
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
  if (-not $menu.Contains($game.Description)) {
    throw "Missing Korean description: $($game.Description)"
  }
}

Write-Output "Verified 3 game pages and menu links."
