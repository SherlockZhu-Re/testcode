package main

import (
	"fmt"
	"time"

	"github.com/robfig/cron/v3" // <- 这里导入了外部依赖
)

func main() {
	fmt.Println("Cron job service starting...")

	// 创建一个新的 cron 任务调度器
	// cron.New() 默认使用分钟级别的 cron 表达式 (5个字段)
	// 如果需要秒级 (6个字段)，使用 cron.New(cron.WithSeconds())
	c := cron.New()

	// 添加一个任务，每 5 秒执行一次
	// 表达式格式: 秒 分 时 日 月 星期
	_, err := c.AddFunc("*/5 * * * * *", func() {
		fmt.Printf("Tick every 5 seconds. Current time: %s\n", time.Now().Format("2006-01-02 15:04:05"))
	})
	if err != nil {
		fmt.Println("Error adding cron job:", err)
		return
	}

	// 启动调度器（在一个新的 goroutine 中）
	c.Start()

	fmt.Println("Scheduler started. Waiting for jobs...")

	// 阻塞主线程，防止程序退出
	// 实际应用中可能会是 HTTP 服务器监听或其他阻塞操作
	select {}
}
