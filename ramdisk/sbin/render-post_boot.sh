#!/system/bin/sh

############################
# Custom Kernel Settings for Render Kernel!!
#
echo "[Render-Kernel] Boot Script Started" | tee /dev/kmsg
#stop mpdecision

############################
# CPU-Boost Settings
#
echo 500 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 0:1324800 2:1324800 > /sys/module/cpu_boost/parameters/input_boost_freq

############################
# Governor Tunings
#
# Configure governor settings for little cluster
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction

# Online CPU2
echo 1 > /sys/devices/system/cpu/cpu2/online

# Configure governor settings for big cluster
echo interactive > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
echo 19000 1400000:39000 1700000:19000 2100000:79000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
echo 1248000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
echo 85 1500000:90 1800000:70 2100000:95 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
echo 19000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
echo 79000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
echo 307200 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction

############################
# Scheduler and Read Ahead
#
#echo zen > /sys/block/mmcblk0/queue/scheduler
#echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# VM tuning
#
echo 20 > /proc/sys/vm/dirty_background_ratio
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 40 > /proc/sys/vm/dirty_ratio
echo 0 > /proc/sys/vm/swappiness
echo 100 > /proc/sys/vm/vfs_cache_pressure

############################
# Disable Debugging
#
echo "0" > /sys/module/kernel/parameters/initcall_debug;
echo "0" > /sys/module/alarm_dev/parameters/debug_mask;
echo "0" > /sys/module/binder/parameters/debug_mask;
echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask;
echo "[Render-Kernel] disable debug mask" | tee /dev/kmsg

############################
# Init.d Support
#
/sbin/busybox run-parts /system/etc/init.d

############################
# Boot Script is complete, now enable SELinux
#
#setenforce 1
echo "[Render-Kernel] Boot Script Completed!" | tee /dev/kmsg
