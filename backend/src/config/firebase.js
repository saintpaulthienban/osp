const admin = require("firebase-admin");
const dotenv = require("dotenv");

dotenv.config();

let bucket = null;
let initialized = false;

const initializeFirebase = () => {
  if (initialized) {
    return bucket;
  }

  // Kiểm tra xem biến môi trường có tồn tại không
  if (!process.env.FIREBASE_SERVICE_ACCOUNT) {
    console.warn('⚠️ FIREBASE_SERVICE_ACCOUNT environment variable is missing - Firebase storage disabled');
    return null;
  }

  if (!process.env.FIREBASE_STORAGE_BUCKET) {
    console.warn('⚠️ FIREBASE_STORAGE_BUCKET environment variable is missing - Firebase storage disabled');
    return null;
  }

  try {
    // Parse chuỗi JSON từ biến môi trường thành Object
    const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT);

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      storageBucket: process.env.FIREBASE_STORAGE_BUCKET 
    });

    bucket = admin.storage().bucket();
    initialized = true;
    
    console.log('✅ Firebase Admin initialized successfully');
    console.log(`📦 Storage bucket: ${process.env.FIREBASE_STORAGE_BUCKET}`);
    
    return bucket;
  } catch (error) {
    console.error('❌ Firebase initialization error:', error.message);
    return null;
  }
};

const getBucket = () => {
  if (!bucket) {
    bucket = initializeFirebase();
  }
  return bucket;
};

module.exports = { getBucket, initializeFirebase };
