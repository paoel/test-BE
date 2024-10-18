const express = require('express');
const { body } = require('express-validator');
const pungutanController = require('../controllers/pungutanController');
const router = express.Router();

router.post('/pungutan', [
  body('pungutan.no_pengajuan').notEmpty().withMessage('No pengajuan tidak boleh kosong'),
  body('pungutan.kurs').isFloat({ gt: 0 }).withMessage('Kurs harus berupa angka positif'),
  body('pungutan.nilai').isFloat({ gt: 0 }).withMessage('Nilai harus berupa angka positif'),
], pungutanController.createOrUpdatePungutan);

module.exports = router;
