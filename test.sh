#!/bin/bash

# Dừng lại ngay nếu có lệnh nào gặp lỗi
set -e

echo "==> Đang kiểm tra hệ thống âm thanh..."

# 1. Kiểm tra thư mục state cache của WirePlumber (nơi lưu cấu hình jack mic thực tế)
WP_STATE_DIR="$HOME/.local/state/wireplumber"
if [ -d "$WP_STATE_DIR" ]; then
    echo "[OK] Tìm thấy thư mục cache WirePlumber tại: $WP_STATE_DIR"
    echo "     Đang tiến hành xóa sạch cache cũ..."
    rm -rf "$WP_STATE_DIR"/*
else
    echo "[CẢNH BÁO] Không tìm thấy thư mục: $WP_STATE_DIR"
    echo "           Hệ thống có thể đang dùng đường dẫn khác hoặc chưa sinh cache."
fi

# 2. Xử lý các thư mục cấu hình cũ trong ~/.config nếu có tồn tại
if [ -d "$HOME/.config/pipewire" ]; then
    echo "-> Đổi tên thư mục cấu hình cũ: ~/.config/pipewire"
    mv "$HOME/.config/pipewire" "$HOME/.config/pipewire_old_$(date +%s)"
fi

if [ -d "$HOME/.config/pulse" ]; then
    echo "-> Đổi tên thư mục cấu hình cũ (PulseAudio): ~/.config/pulse"
    mv "$HOME/.config/pulse" "$HOME/.config/pulse_old_$(date +%s)"
fi

echo "==> Đang khởi động lại các tiến trình PipeWire và WirePlumber..."
if systemctl --user restart pipewire wireplumber pipewire-pulse; then
    echo "[THÀNH CÔNG] Các tiến trình âm thanh đã được làm mới thành công!"
else
    echo "[LỖI] Không thể khởi động lại dịch vụ hệ thống qua systemctl."
    exit 1
fi

echo "Hoàn tất! Bạn hãy mở pavucontrol để kiểm tra lại micro."
