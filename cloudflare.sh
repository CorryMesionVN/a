#!/bin/bash

echo "Đang cập nhật khóa GPG của Cloudflare..."
sudo rpm -e 'gpg-pubkey(4fa1c3ba-61abda35)' 2>/dev/null || true
sudo rpm --import https://pkg.cloudflareclient.com/pubkey.gpg

echo "Đang thêm kho lưu trữ Cloudflare WARP..."
curl -fsSL https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo

echo "Đang cập nhật lại kho ứng dụng..."
sudo dnf update -y

echo "Đang tiến hành cài đặt Cloudflare WARP..."
sudo dnf install -y cloudflare-warp

echo "Cài đặt hoàn tất! Bạn có thể chạy lệnh 'warp-cli connect' để sử dụng."
