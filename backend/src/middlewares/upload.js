const multer = require("multer");

// Sử dụng memoryStorage để lưu file dưới dạng Buffer
const storage = multer.memoryStorage();

const photoMimeTypes = [
  "image/jpeg",
  "image/jpg",
  "image/png",
  "image/gif",
  "image/webp",
];
const documentMimeTypes = [
  "application/pdf",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  "application/vnd.ms-excel",
];

const createUploader = ({ allowedMimeTypes, fileSize }) =>
  multer({
    storage: storage,
    limits: { fileSize: fileSize || 10 * 1024 * 1024 }, // Default 10MB
    fileFilter: (req, file, cb) => {
      if (allowedMimeTypes.includes(file.mimetype)) {
        return cb(null, true);
      }
      return cb(new Error("Invalid file type"));
    },
  });

const photoUploader = createUploader({
  allowedMimeTypes: photoMimeTypes,
  fileSize: 5 * 1024 * 1024, // 5MB for photos
});

const documentUploader = createUploader({
  allowedMimeTypes: documentMimeTypes,
  fileSize: 10 * 1024 * 1024, // 10MB for documents
});

const decisionUploader = createUploader({
  allowedMimeTypes: documentMimeTypes,
  fileSize: 10 * 1024 * 1024, // 10MB for decisions
});

const certificateUploader = createUploader({
  allowedMimeTypes: [...photoMimeTypes, ...documentMimeTypes],
  fileSize: 10 * 1024 * 1024, // 10MB for certificates
});

const handleUploadErrors = (uploader) => (req, res, next) => {
  uploader(req, res, (error) => {
    if (!error) {
      return next();
    }

    if (error instanceof multer.MulterError) {
      const payload =
        error.code === "LIMIT_FILE_SIZE"
          ? { message: "File exceeds the allowed size limit" }
          : { message: `Upload error: ${error.message}` };
      return res.status(400).json(payload);
    }

    return res
      .status(400)
      .json({ message: error.message || "Invalid file upload" });
  });
};

const uploadPhoto = handleUploadErrors(photoUploader.single("photo"));
const uploadDocument = handleUploadErrors(documentUploader.single("document"));
const uploadDecision = handleUploadErrors(
  decisionUploader.single("decision_file")
);
const uploadMultiple = handleUploadErrors(
  certificateUploader.array("files", 5)
);
const uploadDocuments = handleUploadErrors(
  certificateUploader.array("documents", 10)
);

module.exports = {
  uploadPhoto,
  uploadDocument,
  uploadDecision,
  uploadMultiple,
  uploadDocuments,
};
