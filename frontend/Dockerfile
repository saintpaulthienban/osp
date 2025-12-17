# 1. Dùng Node.js để build
FROM node:18-alpine as BUILD_IMAGE

WORKDIR /app

# Copy package.json và cài đặt thư viện
COPY package*.json ./
RUN npm install

# Copy toàn bộ code vào
COPY . .

# --- QUAN TRỌNG NHẤT: KHAI BÁO BIẾN BUILD ---
# Khai báo ARG để nhận biến từ Railway
ARG VITE_API_URL
# Gán giá trị ARG vào ENV để Vite có thể đọc được lúc build
ENV VITE_API_URL=$VITE_API_URL

# Tiến hành Build (Lúc này Vite sẽ nướng biến môi trường vào file JS)
RUN npm run build

# 2. Dùng server nhẹ để chạy code đã build (Production)
FROM node:18-alpine as PRODUCTION_IMAGE
WORKDIR /app

# Cài đặt 'serve' - một web server tĩnh siêu nhẹ
RUN npm install -g serve

# Copy folder 'dist' (kết quả build) từ bước trên xuống bước này
COPY --from=BUILD_IMAGE /app/dist ./dist

# Mở cổng (Railway sẽ tự động map PORT vào đây)
ENV PORT=3000
EXPOSE 3000

# Chạy server
CMD ["serve", "-s", "dist", "-l", "3000"]
