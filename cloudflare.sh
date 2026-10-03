#!/bin/bash

echo "Đang cập nhật khóa GPG của Cloudflare..."
sudo rpm -e 'gpg-pubkey(4fa1c3ba-61abda35)' 2>/dev/null || true
sudo rpm --import https://pkg.cloudflareclient.com/pubkey.gpg[cite: 3]

echo "Đang thêm kho lưu trữ Cloudflare WARP..."
curl -fsSL https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo[cite: 3]

echo "Đang cập nhật lại kho ứng dụng..."
sudo dnf update -y[cite: 3]

echo "Đang tiến hành cài đặt Cloudflare WARP..."
sudo dnf install -y cloudflare-warp[cite: 3]

echo "Đang khởi động dịch vụ WARP..."
sudo systemctl enable --now warp-svc.service

echo "Đang đăng ký và kết nối 1.1.1.1..."
warp-cli registration new
warp-cli connect

echo "Cài đặt và kết nối Cloudflare WARP thành công!"
