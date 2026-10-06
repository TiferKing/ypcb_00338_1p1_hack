# ypcb_00338_1p1_hack

YPCB-00338-1P1 板卡逆向资料

## 包含内容

 - constraints: 约束文件，描述引脚作用。
 - documents: 参考文档。
 - examples: 样例工程。
 - ypcb003381p1: 板卡文件。

## 使用方法

将文件夹ypcb003381p1复制进 Vivado/\<version\>/data/boards/board_files/ ，如果没有board_files目录就自行创建一个。

打开Vivado新建工程即可选择“YPCB-00338-1P1 Accelerator Card”。

## AC24 引脚（板卡复位）/ AC24 is a board reset

AC24（IO_25_14）连接到板卡复位。比特流如果让它保持默认的下拉，启动释放 I/O 时板卡就会复位，DONE 永远拉不高。
请把 AC24 驱动为高电平，或者在 Vivado 中设置 `set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]`。
参见 [#3](https://github.com/TiferKing/ypcb_00338_1p1_hack/issues/3)。

AC24 (IO_25_14) is wired to a board reset. A bitstream that leaves it at the default pull-down resets the
card as startup releases the I/O, and DONE never goes high. Drive AC24 high, or in Vivado set
`set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]`. See
[#3](https://github.com/TiferKing/ypcb_00338_1p1_hack/issues/3).

## 开源工具链 / Open toolchain

用开源工具（yosys、nextpnr-xilinx、prjxray）点亮本板，包括两路 DDR3 与 PCIe：
Bring-up of this card with open tools only (yosys, nextpnr-xilinx, prjxray), including both DDR3 channels
and PCIe: https://github.com/sirmick/ypcb-00338-1p1

## 详细信息

更多详细信息可以参考我的博客：

https://www.tiferking.cn/index.php/2024/12/19/650/
