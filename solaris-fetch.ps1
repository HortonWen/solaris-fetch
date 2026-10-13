#Requires -Version 5.1
<#
.SYNOPSIS
  solaris-fetch (PowerShell 版) — SEU CXXY RoboMaster SOLARIS 战队终端横幅
.DESCRIPTION
  与 bash 版视觉完全一致的独立实现：ROBOMASTER 金属艺体字 + SOLARIS 太阳渐变字标
  + 东南大学校徽简化版 + 战队/系统信息栏 + 渐变能量条与口号。
  需要支持 TrueColor 的终端（Windows Terminal 推荐）。
.PARAMETER Animate
  逐行动画显示。
#>
[CmdletBinding()]
param([switch]$Animate)

$esc  = [char]27
$rst  = $esc + '[0m'
$bold = $esc + '[1m'
$dim  = $esc + '[2m'
function tc([int]$r, [int]$g, [int]$b) { "{0}[38;2;{1};{2};{3}m" -f $esc, $r, $g, $b }

# ── SOLARIS 字标字形（6x7，# = 实心块）──
$gS = @('.####.', '##....', '##....', '.###..', '....##', '....##', '###...')
$gO = @('.####.', '##..##', '##..##', '##..##', '##..##', '##..##', '.####.')
$gL = @('##....', '##....', '##....', '##....', '##....', '##....', '######')
$gA = @('.####.', '##..##', '##..##', '######', '##..##', '##..##', '##..##')
$gR = @('#####.', '##..##', '##..##', '#####.', '##.#..', '##..#.', '##...#')
$gI = @('######', '..##..', '..##..', '..##..', '..##..', '..##..', '######')

$colored = @()
for ($n = 0; $n -lt 7; $n++) {
    $raw = (@($gS[$n], $gO[$n], $gL[$n], $gA[$n], $gR[$n], $gI[$n], $gS[$n]) -join ' ')
    $line = ''
    for ($x = 0; $x -lt $raw.Length; $x++) {
        if ($raw[$x] -eq '#') {
            $g = 205 - [math]::Floor(150 * $x / ($raw.Length - 1))
            $b = 40  - [math]::Floor(15  * $x / ($raw.Length - 1))
            $line += (tc 255 $g $b) + [char]0x2588 + $rst   # █
        } else { $line += ' ' }
    }
    $colored += $line
}
$W = 48

# ── ROBOMASTER 艺体字：3 行半块字形，双色金属 ──
$blk = [char]0x2588; $top = [char]0x2580; $bot = [char]0x2584
$rR = @("$blk$top$blk", "$blk$blk$top", "$blk $blk")
$rO = @("$blk$top$blk", "$blk $blk", "$top$top$top")
$rB = @("$blk$top$bot", "$blk$top$bot", "$top$top$top")
$rM = @("$blk$bot$top$bot$blk", "$blk $top $blk", "$blk   $blk")
$rA = @("$blk$top$blk", "$blk$blk$blk", "$blk $blk")
$rS = @("$blk$top$top", "$top$top$blk", "$top$top$top")
$rT = @("$top$blk$top", " $blk ", " $blk ")
$rE = @("$blk$top$top", "$blk$blk ", "$top$top$top")
$rmc = @()
for ($n = 0; $n -lt 3; $n++) {
    $body = (@($rR[$n], $rO[$n], $rB[$n], $rO[$n], $rM[$n], $rA[$n], $rS[$n], $rT[$n], $rE[$n], $rR[$n]) -join ' ')
    $ld = [math]::Floor(($W - $body.Length) / 2); $rd = $W - $body.Length - $ld
    $L = ''
    $dash = $dim + (tc 110 120 138) + [char]0x2500 + $rst   # ─
    for ($p = 0; $p -lt $ld; $p++) { $L += $dash }
    for ($x = 0; $x -lt $body.Length; $x++) {
        $c = [string]$body[$x]
        if ($c -eq [string]$top -or $c -eq [string]$bot) { $L += (tc 235 240 250) + $c + $rst }
        elseif ($c -eq [string]$blk)                     { $L += (tc 150 162 185) + $c + $rst }
        else                                             { $L += ' ' }
    }
    for ($p = 0; $p -lt $rd; $p++) { $L += $dash }
    $rmc += $L
}
$colored = $rmc + $colored

# ── 左下角：东南大学校徽简化版 ──
$yE = tc 250 200 40; $gE = tc 96 168 84; $wE = tc 232 226 216
$P26 = ' ' * 26
$box = [char]0x2502   # │
$colored += @(
    ("  ${yE}╭──── 東南大學 ────╮${rst}${P26}"),
    ("  ${yE}${box}${rst}     ${gE}▔▔▔▔▔▔▔▔${rst}     ${yE}${box}${rst}${P26}"),
    ("  ${yE}${box}${rst}    ${gE}╲${rst} ${yE}▄▄▄▄▄▄${rst} ${gE}╱${rst}    ${yE}${box}${rst}${P26}"),
    ("  ${yE}${box}${rst} ${wE}1902${rst} ${yE}▟████▙${rst} ${wE}南京${rst} ${yE}${box}${rst}${P26}"),
    ("  ${yE}${box}${rst}       ${gE}╲▀▀╱${rst}       ${yE}${box}${rst}${P26}"),
    ("  ${yE}╰──── 止於至善 ────╯${rst}${P26}")
)

# ── 系统信息（CIM 采集，取不到就降级）──
function Safe([scriptblock]$sb, $fallback) { try { $v = & $sb; if ($v) { $v } else { $fallback } } catch { $fallback } }
$userName = $env:USERNAME
$hostName = $env:COMPUTERNAME
$os    = Safe { (Get-CimInstance Win32_OperatingSystem).Caption } 'Windows'
$kernel= Safe { [Environment]::OSVersion.Version.ToString() } '?'
$uptime= Safe {
    $up = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $s = ''; if ($up.Days) { $s += "$($up.Days)d " }; if ($up.Hours -or $up.Days) { $s += "$($up.Hours)h " }; $s + "$($up.Minutes)m"
} '?'
$shellName = Safe { "{0} {1}" -f $PSVersionTable.PSVersion, $PSVersionTable.PSEdition } 'powershell'
$cpu   = Safe { ((Get-CimInstance Win32_Processor | Select-Object -First 1).Name -replace '\([A-Za-z]+\)', '' -replace '\s+', ' ').Trim() } '?'
if ($cpu.Length -gt 34) { $cpu = $cpu.Substring(0, 34) }
$gpu   = Safe { ((Get-CimInstance Win32_VideoController | Select-Object -First 1).Name -replace '\s+', ' ').Trim() } ''
if ($gpu.Length -gt 34) { $gpu = $gpu.Substring(0, 34) }
$ip    = Safe { (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.IPAddress -notlike '169.254.*' -and $_.IPAddress -ne '127.0.0.1' } | Select-Object -First 1).IPAddress } ''
$mem   = Safe {
    $o = Get-CimInstance Win32_OperatingSystem
    "{0} / {1} MiB" -f [math]::Floor(($o.TotalVisibleMemorySize - $o.FreePhysicalMemory) / 1024), [math]::Floor($o.TotalVisibleMemorySize / 1024)
} '? / ?'

# ── 右侧面板 ──
$oY = tc 255 184 60; $oR = tc 255 82 45; $wt = tc 232 226 216; $gy = tc 148 140 130
function lab([string]$k, [string]$v) { "${oR}$($k.PadRight(7))${wt}$v" }
$right = @(
    "${bold}${oY}SEU CXXY ${wt}· ${oR}ROBOMASTER${rst}",
    "${oR}╭${oY}────────────────────────────${oR}╮${rst}",
    "${oR}│${bold}${wt}   S O L A R I S  T E A M   ${oR}│${rst}",
    "${oR}╰${oY}────────────────────────────${oR}╯${rst}",
    "$(lab host   "$userName@$hostName")",
    "$(lab os     "$os")",
    "$(lab kernel "$kernel")",
    "$(lab uptime "$uptime")",
    "$(lab shell  "$shellName")",
    "$(lab cpu    "$cpu")"
)
if ($gpu) { $right += "$(lab gpu    "$gpu")" }
if ($ip)  { $right += "$(lab ip     "$ip")" }
$right += @(
    "$(lab mem    "$mem")",
    "$(lab school '东南大学成贤学院 (SEU CXXY)')",
    "$(lab team   'Solaris')",
    "$(lab slogan '秣陵形胜，共赴千山')",
    "${dim}${gy}────────────────────────────${rst}",
    "${oY}▸ SYS.ACTIVE ${oR}● ${wt}SOLARIS-2026 ${oR}● ${wt}TEAM-01${rst}"
)

# ── 合成输出 ──
$out = @()
for ($n = 0; $n -lt $colored.Count -or $n -lt $right.Count; $n++) {
    $L = if ($n -lt $colored.Count) { $colored[$n] } else { ' ' * $W }
    $R = if ($n -lt $right.Count) { $right[$n] } else { '' }
    $out += ("$L   $R" + $rst)
}
$bar = ''
for ($x = 0; $x -lt $W + 40; $x++) {
    $g = 205 - [math]::Floor(150 * $x / ($W + 39))
    $b = 40  - [math]::Floor(15  * $x / ($W + 39))
    $bar += (tc 255 $g $b) + [char]0x2587   # ▇
}
$out += ($bar + $rst)
$out += ''
$out += ("  ${bold}${oY}秣陵形胜，共赴千山${rst}")
$out += ("  ${dim}$(tc 200 120 60)BEYOND LIMITS · DEFEND OUR HONOR · UNITED WE BUILD VICTORY${rst}")

foreach ($line in $out) {
    $line
    if ($Animate) { Start-Sleep -Milliseconds 40 }
}
