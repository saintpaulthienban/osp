const admin = require("firebase-admin");
const dotenv = require("dotenv");

dotenv.config();

// Kiểm tra xem biến môi trường có tồn tại không để tránh lỗi crash app
if (!process.env.FIREBASE_SERVICE_ACCOUNT) {
  console.error('❌ FIREBASE_SERVICE_ACCOUNT environment variable is missing');
  throw new Error('Thiếu biến môi trường FIREBASE_SERVICE_ACCOUNT');
}

if (!process.env.FIREBASE_STORAGE_BUCKET) {
  console.error('❌ FIREBASE_STORAGE_BUCKET environment variable is missing');
  throw new Error('Thiếu biến môi trường FIREBASE_STORAGE_BUCKET');
}

try {
  // Parse chuỗi JSON từ biến môi trường thành Object
  const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket: process.env.FIREBASE_STORAGE_BUCKET 
  });

  console.log('✅ Firebase Admin initialized successfully');
  console.log(`📦 Storage bucket: ${process.env.FIREBASE_STORAGE_BUCKET}`);
} catch (error) {
  console.error('❌ Firebase initialization error:', error.message);
  throw error;
}

const bucket = admin.storage().bucket();

module.exports = { bucket };
