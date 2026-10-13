# SOLARIS-FETCH

东南大学成贤学院 RoboMaster **SOLARIS 战队**的终端横幅程序 —— 打开终端，就能看到战队的太阳。

一个**独立**的 Bash 小程序（不依赖 neofetch / fastfetch 等任何 fetch 工具）：左侧是战队视觉标识，右侧是实时系统信息。

## 预览

```text
───█▀█ █▀█ █▀▄ █▀█ █▄▀▄█ █▀█ █▀▀ ▀█▀ █▀▀ █▀█────   SEU CXXY · ROBOMASTER
───██▀ █ █ █▀▄ █ █ █ ▀ █ ███ ▀▀█  █  ██  ██▀────   ╭────────────────────────────╮
───█ █ ▀▀▀ ▀▀▀ ▀▀▀ █   █ █ █ ▀▀▀  █  ▀▀▀ █ █────   │   S O L A R I S  T E A M   │
 ████   ████  ██      ████  █████  ██████  ████    ╰────────────────────────────╯
██     ██  ██ ██     ██  ██ ██  ██   ██   ██       host   seu@robo-master
██     ██  ██ ██     ██  ██ ██  ██   ██   ██       os     Ubuntu 22.04.5 LTS
 ███   ██  ██ ██     ██████ █████    ██    ███     kernel 6.8.0-49-generic
    ██ ██  ██ ██     ██  ██ ██ █     ██       ██   uptime 7m
    ██ ██  ██ ██     ██  ██ ██  █    ██       ██   shell  bash
███     ████  ██████ ██  ██ ██   █ ██████ ███      cpu    Intel Core Ultra 9 285H
  ╭──── 東南大學 ────╮                             gpu    Discrete GPU
  │    ╲ ▄▄▄▄▄▄ ╱    │                             mem    1024 / 16384 MiB
  │ 1902 ▟████▙ 南京 │                             school 东南大学成贤学院 (SEU CXXY)
  │       ╲▀▀╱       │                             team   Solaris
  ╰──── 止於至善 ────╯                             slogan 秣陵形胜，共赴千山
                                                   ────────────────────────────
                                                   ▸ SYS.ACTIVE ● SOLARIS-2026 ● TEAM-01
▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇

  秣陵形胜，共赴千山
  BEYOND LIMITS · DEFEND OUR HONOR · UNITED WE BUILD VICTORY
```

> 实际运行效果为真彩色（TrueColor）：`ROBOMASTER` 为银白金属双色艺体字，`SOLARIS` 为琥珀金→太阳红水平渐变，校徽为东大原色（黄环+绿三角），底部为渐变能量条。请在支持 TrueColor 的终端（Windows Terminal、WezTerm、kitty、iTerm2 等）中观看。

## 设计元素

| 元素 | 说明 |
|---|---|
| `R O B O M A S T E R` 艺体字 | 3 行半块字符手绘字形；横笔亮银高光、竖笔枪铁蓝灰，金属装甲质感 |
| `SOLARIS` 主标识 | 7 行块状字，琥珀金 → 太阳红水平真彩渐变，呼应海报机甲的橙色发光描边 |
| 校徽 | 东南大学校徽简化版：黄环 +「東南大學」「止於至善」+ 绿倒三角 + 大礼堂剪影 +「1902 / 南京」 |
| 信息栏 | 红字英文标签（host / os / kernel / … / school / team / slogan），米白数值 |
| 能量条 + 口号 | 底部橙红渐变条，战队口号「秣陵形胜，共赴千山」 |

## 安装

依赖：仅 `bash`（以及常规 coreutils / awk / sed）。Ubuntu / Debian / WSL 可直接使用。

```bash
git clone https://github.com/SEU-CXXY-SOLARIS/solaris-fetch.git   # 替换为实际仓库地址
cd solaris-fetch
sudo install -m 755 solaris-fetch /usr/local/bin/solaris-fetch
```

或单文件拷贝：把 `solaris-fetch` 放到 `$PATH` 中任意位置并 `chmod +x` 即可。

## 使用

```bash
solaris-fetch        # 显示横幅
solaris-fetch -a     # 逐行动画显示（开机自检既视感）
```

想每次开终端自动展示，可在 `~/.bashrc` 末尾加一行 `solaris-fetch`。

## 自定义

脚本为单文件 Bash，全部视觉定义集中在文件头部：

- `g_S / g_O / g_L / g_A / g_R / g_I`：SOLARIS 七行块字字形（`#` 为实心块）
- `rR / rO / rB / rM / rA / rS / rT / rE`：ROBOMASTER 三行艺体字字形
- `tc R G B`：TrueColor 上色函数；渐变范围在字标循环中调整
- 校徽、信息栏、口号均为普通字符串数组，直接改文字即可

## License

MIT © SOLARIS Team, SEU Chengxian College RoboMaster
