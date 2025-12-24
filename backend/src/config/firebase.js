const admin = require("firebase-admin");
const dotenv = require("dotenv");

dotenv.config();

// Kiểm tra xem biến môi trường có tồn tại không để tránh lỗi crash app
if (!process.env.FIREBASE_SERVICE_ACCOUNT) {
  throw new Error('Thiếu biến môi trường FIREBASE_SERVICE_ACCOUNT');
}

// Parse chuỗi JSON từ biến môi trường thành Object
const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET 
});

const bucket = admin.storage().bucket();

module.exports = { bucket };
