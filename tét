#!/bin/bash
echo "Đang dọn dẹp cache cấu hình âm thanh cũ..."

# Xóa hoặc đổi tên cache cũ của PipeWire và PulseAudio
[ -d ~/.config/pipewire ] && mv ~/.config/pipewire ~/.config/pipewire_old_$(date +%s)
[ -d ~/.config/pulse ] && mv ~/.config/pulse ~/.config/pulse_old_$(date +%s)

echo "Đang khởi động lại các tiến trình PipeWire..."
systemctl --user restart pipewire wireplumber pipewire-pulse

echo "Hoàn tất! Bạn hãy kiểm tra lại âm thanh."
