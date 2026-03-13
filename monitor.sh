 #!/bin/bash
 
# ─────────────────────────────────────────
# monitor.sh — System Health Monitor
# Logs CPU, memory, disk, and top processes
# ─────────────────────────────────────────
 
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/health-$(date +%Y-%m-%d).log"
 
mkdir -p "$LOG_DIR"
 
echo "========================================" >> "$LOG_FILE"
echo "Health Check — $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
 
# CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo "CPU Usage     : $CPU%" >> "$LOG_FILE"
 
# Memory usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PCT=$(awk "BEGIN {printf \"%.1f\", ($MEM_USED/$MEM_TOTAL)*100}")
echo "Memory        : ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PCT}%)" >> "$LOG_FILE"
 
# Disk usage
DISK=$(df -h / | awk 'NR==2 {print $3 " used of " $2 " (" $5 ")"}')
echo "Disk (/)      : $DISK" >> "$LOG_FILE"
 
# Top 3 CPU processes
echo "" >> "$LOG_FILE"
echo "Top Processes (by CPU):" >> "$LOG_FILE"
ps aux --sort=-%cpu | awk 'NR>=2 && NR<=4 {printf "  %-20s CPU: %s%%\n", $11, $3}' >> "$LOG_FILE"
 
echo "" >> "$LOG_FILE"
 
echo "Health check logged to $LOG_FILE"
 
