# 赛道接力图生成器

自动生成行业板块轮动接力图的Excel工具，直观展示每日领涨板块的变化规律。

## 功能特点

- ✅ 自动获取每日行业板块涨幅数据（前30名）
- ✅ 按涨幅从高到低排序
- ✅ 横向拼接多日数据，形成接力图
- ✅ 为每个板块分配固定颜色，方便追踪
- ✅ 支持增量更新，保留历史数据

## 安装依赖

```bash
pip install -r requirements.txt
```

## 使用方法

### 方法一：每日自动更新（推荐）

直接运行脚本，会自动获取今天的数据并更新Excel：

```bash
python sector_relay_chart.py
```

### 方法二：指定日期更新

```bash
# 使用 YYYY-MM-DD 格式
python sector_relay_chart.py -d 2026-01-29

# 或使用 YYYYMMDD 格式
python sector_relay_chart.py -d 20260129
```

### 方法三：自定义设置

```bash
# 指定Excel文件路径和取前20个板块
python sector_relay_chart.py -f "我的接力图.xlsx" -n 20

# 自动覆盖已存在的数据（适合定时任务）
python sector_relay_chart.py --auto-overwrite

# 仅查看已有数据，不更新
python sector_relay_chart.py --view
```

### 方法四：Python代码调用

```python
from sector_relay_chart import SectorRelayChart

chart = SectorRelayChart(excel_path="赛道接力图.xlsx", top_n=30)
chart.update_excel("2026-01-29")  # 指定日期
chart.update_excel(auto_overwrite=True)  # 自动覆盖
```

### 方法三：手动添加历史数据

如果你想手动添加某天的数据，可以：

1. 从财经网站（如东方财富、同花顺）获取当天的板块涨幅榜
2. 整理成Excel格式，第一行是日期，下面按涨幅从高到低排列板块名称
3. 运行脚本会自动合并到现有文件中

## 数据来源

- 使用 `akshare` 库获取实时行业板块数据
- 数据来源：东方财富等财经网站

## 输出文件

- `赛道接力图.xlsx` - 主Excel文件，包含所有历史数据
- `sector_colors.json` - 板块颜色映射文件，确保同一板块颜色一致

## 自定义设置

在 `SectorRelayChart` 初始化时可以调整：

- `excel_path`: Excel文件保存路径
- `top_n`: 每日取前N个板块（默认30）

## 注意事项

1. **数据获取时间**：建议在交易日收盘后（15:00之后）运行，确保数据完整
2. **网络连接**：需要网络连接来获取实时数据
3. **颜色一致性**：颜色映射保存在 `sector_colors.json`，删除此文件会重新分配颜色

## 定时任务设置（可选）

### macOS/Linux (crontab)

每天下午3:30自动更新（使用自动覆盖模式）：

```bash
crontab -e
# 添加以下行（注意替换为你的实际路径）
30 15 * * 1-5 cd /Users/ttzach/Documents/code && /usr/bin/python3 sector_relay_chart.py --auto-overwrite
```

### Windows (任务计划程序)

1. 打开"任务计划程序"
2. 创建基本任务
3. 触发器：每个工作日 15:30
4. 操作：启动程序 `python sector_relay_chart.py`

## 故障排除

如果数据获取失败，脚本会使用示例数据，你可以：
1. 检查网络连接
2. 确认 akshare 库已正确安装
3. 手动从财经网站获取数据并更新Excel
