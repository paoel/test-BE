const { validationResult } = require('express-validator');  // Tambahkan ini
const db = require('../config/db');  // Koneksi database

exports.createOrUpdatePungutan = (req, res) => {
  // Validasi request
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const {
    no_pengajuan, nama_pengaju, tgl_pengajuan,
    incoterms, valuta, kurs, nilai, biaya_tambahan, biaya_pengurangan,
    voluntary_declaration, asuransi, freight, bruto, netto, flag_kontainer
  } = req.body.pungutan;

  // Lakukan perhitungan ulang
  const nilai_fob = nilai + biaya_tambahan - biaya_pengurangan + voluntary_declaration;
  const cif = nilai_fob + asuransi + freight;
  const cif_rp = cif * kurs;

  // Jika tidak ada primary key, lakukan insert baru
  const insertQuery = `INSERT INTO header (no_pengajuan, nama_pengaju, tgl_pengajuan) VALUES (?, ?, ?)`;
  db.query(insertQuery, [no_pengajuan, nama_pengaju, tgl_pengajuan], (err, result) => {
    if (err) {
      console.error('Error inserting header:', err);
      return res.status(500).json({ error: 'Error inserting header' });
    }

    const id_header = result.insertId;
    const pungutanQuery = `INSERT INTO pungutan (id_header, incoterms, valuta, kurs, nilai, biaya_tambahan, biaya_pengurangan,
                           voluntary_declaration, nilai_fob, asuransi, freight, cif, cif_rp, bruto, netto, flag_kontainer)
                           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(pungutanQuery, [id_header, incoterms, valuta, kurs, nilai, biaya_tambahan, biaya_pengurangan,
                             voluntary_declaration, nilai_fob, asuransi, freight, cif, cif_rp, bruto, netto, flag_kontainer], (err, result) => {
      if (err) {
        console.error('Error inserting pungutan:', err);
        return res.status(500).json({ error: 'Error inserting pungutan', details: err.message });
      }
      res.status(201).json({ message: 'Data saved successfully', id: result.insertId });
    });
  });
};
