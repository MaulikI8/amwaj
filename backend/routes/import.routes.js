const router = require('express').Router();
const multer = require('multer');
const { protect, authorize } = require('../middleware/auth.middleware');
const ctrl = require('../controllers/import.controller');

// Use memory storage so we read the file buffer directly (no disk write needed)
const upload = multer({
    storage: multer.memoryStorage(),
    limits: { fileSize: 10 * 1024 * 1024 }, // 10MB max
    fileFilter: (req, file, cb) => {
        if (file.mimetype === 'text/csv' ||
            file.originalname.endsWith('.csv') ||
            file.mimetype === 'application/vnd.ms-excel') {
            cb(null, true);
        } else {
            cb(new Error('Only CSV files are allowed'), false);
        }
    }
});

router.post('/csv', protect, authorize('admin'), upload.single('csv'), ctrl.importCSV);
router.get('/csv-template', protect, authorize('admin'), ctrl.downloadTemplate);

module.exports = router;
